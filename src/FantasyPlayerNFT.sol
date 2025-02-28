// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// Contrato para los NFTs
// Implementa ERC-721 para representar jugadores
// Permite que el administrador asigne jugadores a los usuarios
// almacena los atributos de cada jugador (nombre,  equipo, puntuaciones, etc.)

contract FantasyPlayerNFT is ERC721URIStorage, Ownable {
    uint256 public nextTokenId;

    // Estructura para representar un jugador
    struct Jugador {
        string nombre;
        string equipo;
        uint256 puntuacion;
    }

    // Mapeo de id de jugador a jugador
    mapping(uint256 => Jugador) public jugadores;

    constructor() ERC721("FantasyLeague", "FLNFT") Ownable(msg.sender) {}

    function mintPlayer(
        address to,
        string memory _name,
        string memory _team
    ) external onlyOwner {
        uint tokenId = nextTokenId;
        _safeMint(to, tokenId);
        jugadores[tokenId] = Jugador(_name, _team, 0);
        nextTokenId++;
    }

    function updateScore(uint256 tokenId, uint256 _score) external onlyOwner {
        require(ownerOf(tokenId) != address(0), "Player does not exist");
        jugadores[tokenId].puntuacion = _score;
    }
}
