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
        //AgregacionDeJugadores,
        //FormacionDeEquipos,
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
    uint256 public constant ENTRY_FEE = 0.1 ether;
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
            require(_jugadores[i] < jugadores.length, "Jugador no valido");

            if (jugadorElegido[_jugadores[i]]) {
                revert(
                    string(
                        abi.encodePacked(
                            "Jugador ya seleccionado: ",
                            jugadores[_jugadores[i]].nombre,
                            " del equipo ",
                            jugadores[_jugadores[i]].equipo
                        )
                    )
                );
            }
        }
        _;
    }

    function pagarEntrada() public payable {
        require(msg.value == ENTRY_FEE, "La entrada cuesta 0.1 ether");
        require(
            !UsuariosInscritos[msg.sender],
            "Ya estas inscrito en la jornada"
        );
        UsuariosInscritos[msg.sender] = true;
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
            idCapitan: _jugadores[0], // Se podría permitir elegir el capitán luego
            seleccionado: true
        });
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
}
