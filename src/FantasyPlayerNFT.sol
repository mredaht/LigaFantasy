// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import {JugadorStruct} from "./JugadorStruct.sol";

// Contrato para los NFTs
// Implementa ERC-721 para representar jugadores
// Permite que el administrador asigne jugadores a los usuarios
// almacena los atributos de cada jugador (nombre,  equipo, puntuaciones, etc.)

contract FantasyPlayerNFT is ERC721, Ownable {
    using JugadorStruct for JugadorStruct.Jugador;

    uint256 public nextTokenId;

    // Mapeo de id de jugador a jugador
    mapping(uint256 => JugadorStruct.Jugador) public jugadores;

    //uint256[] public jugadoresDisponibles; // Lista de IDs de jugadores disponibles

    constructor() ERC721("FantasyLeague", "FLNFT") Ownable(msg.sender) {}

    function mintPlayer(
        address to,
        string memory name,
        string memory team
    ) external onlyOwner {
        require(
            bytes(name).length > 0,
            "El nombre del jugador no puede estar vacio"
        );
        require(
            bytes(team).length > 0,
            "El nombre del equipo no puede estar vacio"
        );
        uint tokenId = nextTokenId;
        _safeMint(to, tokenId);
        jugadores[tokenId] = JugadorStruct.Jugador(
            tokenId,
            name,
            team,
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
        );
        nextTokenId++;
        //jugadoresDisponibles.push(tokenId);
    }

    /*
    function obtenerJugador(
        uint256 _id
    ) external view returns (uint256, string memory, string memory, uint256) {
        JugadorStruct.Jugador memory jugador = jugadores[_id];
        return (jugador.id, jugador.nombre, jugador.equipo, jugador.puntuacion);
    }*/

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

        // Llamamos a la función para calcular la puntuación después de actualizar
        jugador.puntuacion = calcularPuntuacion(jugador);
    }

    function calcularPuntuacion(
        JugadorStruct.Jugador memory jugador
    ) public pure returns (uint256) {
        uint256 puntuacion = 0;

        if (jugador.ganoPartido) {
            puntuacion += 3;
        }
        puntuacion += jugador.goles * 4;
        puntuacion += jugador.asistencias * 3;
        puntuacion += jugador.paradas * 1;
        puntuacion += jugador.penaltisParados * 5;
        puntuacion += jugador.despejes * 1;

        if (jugador.minutosJugados >= 30) {
            puntuacion += (jugador.minutosJugados >= 60) ? 2 : 1;
        }
        if (jugador.porteriaCero) {
            puntuacion += 3;
        }

        puntuacion -= jugador.tarjetasAmarillas * 1;
        puntuacion -= jugador.tarjetasRojas * 3;

        return puntuacion;
    }
}
