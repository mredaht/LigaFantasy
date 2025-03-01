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
    uint256[] public jugadoresDisponibles; // Lista de IDs de jugadores disponibles

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
        jugadores[tokenId] = JugadorStruct.Jugador(tokenId, name, team, 0);
        nextTokenId++;
        jugadoresDisponibles.push(tokenId);
    }

    function obtenerJugador(
        uint256 _id
    ) external view returns (uint256, string memory, string memory, uint256) {
        JugadorStruct.Jugador memory jugador = jugadores[_id];
        return (jugador.id, jugador.nombre, jugador.equipo, jugador.puntuacion);
    }
}
