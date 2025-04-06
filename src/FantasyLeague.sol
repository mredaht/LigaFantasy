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
        bool seleccionado;
    }

    // === EVENTOS ===
    event EntradaPagada(address indexed usuario);
    event JugadoresSeleccionados(
        address indexed usuario,
        string nombreEquipo,
        uint256[5] jugadores
    );
    event EstadisticasActualizadas(
        uint256 indexed jugadorId,
        uint256 nuevaPuntuacion
    );
    event PremioDistribuido(address indexed ganador, uint256 cantidad);
    event EstadoJornadaActualizado(Status nuevoEstado);

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

    modifier enEstado(Status _estado) {
        require(gameStatus == _estado, "Estado invalido para esta accion");
        _;
    }

    function iniciarJornada()
        external
        onlyOwner
        enEstado(Status.JornadaSinComenzar)
    {
        gameStatus = Status.JornadaEnCurso;
        emit EstadoJornadaActualizado(gameStatus);
    }

    function finalizarJornada()
        external
        onlyOwner
        enEstado(Status.JornadaEnCurso)
    {
        gameStatus = Status.JornadaFinalizada;
        emit EstadoJornadaActualizado(gameStatus);
    }

    function pagarEntrada() public payable {
        require(msg.value == ENTRY_FEE, "La entrada cuesta 0.1 ether");
        require(
            !UsuariosInscritos[msg.sender],
            "Ya estas inscrito en la jornada"
        );
        UsuariosInscritos[msg.sender] = true;
        emit EntradaPagada(msg.sender);
    }

    function seleccionarJugadores(
        string memory _nombreEquipo,
        uint256[5] memory _jugadores
    ) public onlyInscrito jugadoresDisponibles(_jugadores) {
        require(
            !equipos[msg.sender].seleccionado,
            "Ya seleccionaste tus jugadores"
        );
        require(
            bytes(_nombreEquipo).length > 0,
            "El nombre del equipo no puede estar vacio"
        );

        // Marcar los jugadores como seleccionados
        for (uint256 i = 0; i < _jugadores.length; i++) {
            jugadorElegido[_jugadores[i]] = true;
        }

        equipos[msg.sender] = Equipo({
            owner: payable(msg.sender),
            nombre: _nombreEquipo,
            jugadores: _jugadores,
            puntuacionEquipo: 0,
            seleccionado: true
        });

        fantasyTeams.push(equipos[msg.sender]);

        emit JugadoresSeleccionados(msg.sender, _nombreEquipo, _jugadores);
    }

    function cargarJugadoresDisponibles() external onlyOwner {
        uint256 totalJugadores = fantasyPlayerNFT.getNextTokenId();

        delete jugadores; // Resetear la lista para evitar duplicados

        for (uint256 i = 0; i < totalJugadores; i++) {
            (
                uint256 id,
                string memory nombre,
                string memory equipo,
                ,
                ,
                ,
                ,
                ,
                ,
                ,
                ,
                ,
                ,

            ) = fantasyPlayerNFT.jugadores(i);
            jugadores.push(
                JugadorStruct.Jugador(
                    id,
                    nombre,
                    equipo,
                    0,
                    0,
                    0,
                    0,
                    0,
                    0,
                    0,
                    false,
                    0,
                    0,
                    false
                )
            );
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

        emit EstadisticasActualizadas(_tokenId, jugador.puntuacion);
    }

    function calcularPuntuacion(
        JugadorStruct.Jugador memory jugador
    ) internal pure returns (uint256) {
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

    function calcularPuntuacionEquipo(
        address _jugador
    ) public view returns (uint256 total) {
        require(equipos[_jugador].seleccionado, "El jugador no tiene equipo");
        total = 0;
        uint256[5] memory ids = equipos[_jugador].jugadores;
        for (uint256 i = 0; i < ids.length; i++) {
            total += jugadores[ids[i]].puntuacion;
        }
        return total;
    }

    function actualizarPuntuacionesDeTodos()
        public
        onlyOwner
        enEstado(Status.JornadaFinalizada)
    {
        for (uint256 i = 0; i < fantasyTeams.length; i++) {
            address addr = fantasyTeams[i].owner;
            uint256 puntos = calcularPuntuacionEquipo(addr);
            equipos[addr].puntuacionEquipo = puntos;
        }
    }

    function distribuirPremio()
        external
        onlyOwner
        enEstado(Status.JornadaFinalizada)
    {
        address ganador;
        uint256 maxPuntos = 0;

        for (uint256 i = 0; i < fantasyTeams.length; i++) {
            address addr = fantasyTeams[i].owner;
            uint256 puntos = calcularPuntuacionEquipo(addr);

            if (puntos > maxPuntos) {
                maxPuntos = puntos;
                ganador = addr;
            }
        }
        require(ganador != address(0), "No hay ganador");
        uint256 premio = (address(this).balance * 80) / 100; // 80% del balance
        (bool success, ) = payable(ganador).call{value: premio}("");
        require(success, "Transferencia al ganador fallida");

        emit PremioDistribuido(ganador, premio);
    }
}
