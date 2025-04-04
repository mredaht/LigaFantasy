// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";
import {FantasyPlayerNFT} from "./FantasyPlayerNFT.sol";
import {JugadorStruct} from "./JugadorStruct.sol";

// Este contrato se encargará de gestionar la liga de fantasía
// Gestiona la entrada de usuarios
// Maneja la selección de jugadores
// Calcula la puntuación de cada equipo
// Gestiona la distribución de recompensas

contract FantasyLeague is Ownable {
    using JugadorStruct for JugadorStruct.Jugador;

    enum Status {
        JornadaSinComenzar,
        JornadaEnCurso,
        JornadaFinalizada
    }

    struct Equipo {
        address payable owner;
        string nombre;
        uint256[5] jugadores;
        uint256 puntuacionEquipo;
        uint256 idCapitan;
        bool seleccionado;
    }

    FantasyPlayerNFT public fantasyPlayerNFT;
    Status public gameStatus = Status.JornadaSinComenzar;
    JugadorStruct.Jugador[] public jugadores;
    Equipo[] fantasyTeams;
    uint256 private constant ENTRY_FEE = 0.1 ether;
    mapping(address => Equipo) public equipos;
    mapping(address => bool) public UsuariosInscritos;
    mapping(uint256 => bool) public jugadorElegido; // Mapea IDs de jugadores a si ya fueron seleccionados

    constructor(address _fantasyPlayerNFT) Ownable(msg.sender) {
        fantasyPlayerNFT = FantasyPlayerNFT(_fantasyPlayerNFT);
    }

    modifier onlyInscrito() {
        require(UsuariosInscritos[msg.sender], "No has pagado la entrada!!");
        _;
    }

    modifier jugadoresDisponibles(uint256[5] memory _jugadores) {
        for (uint256 i = 0; i < _jugadores.length; i++) {
            require(_jugadores[i] < jugadores.length, "ID de jugador invalido");
            require(!jugadorElegido[_jugadores[i]], "Jugador ya seleccionado");
        }
        _;
    }

    function pagarEntrada() public payable {
        require(msg.value == ENTRY_FEE, "La entrada cuesta 0.1 ether");
        require(!UsuariosInscritos[msg.sender], "Ya estas inscrito en la jornada");
        UsuariosInscritos[msg.sender] = true;
    }

    function seleccionarJugadores(string memory _nombreEquipo, uint256[5] memory _jugadores)
        public
        onlyInscrito
        jugadoresDisponibles(_jugadores)
    {
        require(!equipos[msg.sender].seleccionado, "Ya seleccionaste tus jugadores");
        require(bytes(_nombreEquipo).length > 0, "El nombre del equipo no puede estar vacio");

        // Marcar los jugadores como seleccionados
        for (uint256 i = 0; i < _jugadores.length; i++) {
            jugadorElegido[_jugadores[i]] = true;
        }

        equipos[msg.sender] = Equipo({
            owner: payable(msg.sender),
            nombre: _nombreEquipo,
            jugadores: _jugadores,
            puntuacionEquipo: 0,
            idCapitan: _jugadores[0], // Se podría permitir elegir el capitán luego
            seleccionado: true
        });
    }

    function cargarJugadoresDisponibles() external onlyOwner {
        uint256 totalJugadores = fantasyPlayerNFT.getNextTokenId();

        delete jugadores; // Resetear la lista para evitar duplicados

        for (uint256 i = 0; i < totalJugadores; i++) {
            (uint256 id, string memory nombre, string memory equipo,,,,,,,,,,,) = fantasyPlayerNFT.jugadores(i);
            jugadores.push(JugadorStruct.Jugador(id, nombre, equipo, 0, 0, 0, 0, 0, 0, 0, false, 0, 0, false));
        }
    }

    function actualizarEstadisticas(
        uint256 _tokenId,
        uint256 _goles,
        uint256 _asistencias,
        uint256 _paradas,
        uint256 _penaltisParados,
        uint256 _despejes,
        uint256 _minutosJugados,
        bool _porteriaCero,
        uint256 _tarjetasAmarillas,
        uint256 _tarjetasRojas,
        bool _ganoPartido
    ) external onlyOwner {
        require(_tokenId < jugadores.length, "Jugador no existe");

        JugadorStruct.Jugador storage jugador = jugadores[_tokenId];

        jugador.goles = _goles;
        jugador.asistencias = _asistencias;
        jugador.paradas = _paradas;
        jugador.penaltisParados = _penaltisParados;
        jugador.despejes = _despejes;
        jugador.minutosJugados = _minutosJugados;
        jugador.porteriaCero = _porteriaCero;
        jugador.tarjetasAmarillas = _tarjetasAmarillas;
        jugador.tarjetasRojas = _tarjetasRojas;
        jugador.ganoPartido = _ganoPartido;

        // Calcular nueva puntuación
        jugador.puntuacion = calcularPuntuacion(jugador);
    }

    function calcularPuntuacion(JugadorStruct.Jugador memory jugador) internal pure returns (uint256) {
        uint256 puntuacion = 0;

        if (jugador.ganoPartido) puntuacion += 3;
        puntuacion += jugador.goles * 4;
        puntuacion += jugador.asistencias * 3;
        puntuacion += jugador.paradas * 1;
        puntuacion += jugador.penaltisParados * 5;
        puntuacion += jugador.despejes * 1;

        if (jugador.minutosJugados >= 30) {
            puntuacion += (jugador.minutosJugados >= 60) ? 2 : 1;
        }
        if (jugador.porteriaCero) puntuacion += 3;

        puntuacion -= jugador.tarjetasAmarillas * 1;
        puntuacion -= jugador.tarjetasRojas * 3;

        return puntuacion;
    }
}
