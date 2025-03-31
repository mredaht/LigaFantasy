// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {FantasyPlayerNFT} from "./FantasyPlayerNFT.sol";
import {JugadorStruct} from "./JugadorStruct.sol";

// Contrato que se encarga de almacenar y actualizar las puntuaciones de los jugadores
// recibe datos de puntuacion de jugadores usando oraculos
// actualiza la puntuacion de los nft

contract ScoreOracle {

}
/* 
// Evento que se emite cuando se actualiza la puntuación de un jugador
    event PlayerScoreUpdated(uint256 playerId, uint256 score);

    // Mapeo de los jugadores a sus puntuaciones
    mapping(uint256 => uint256) public playerScores;

    // Función para actualizar la puntuación de un jugador
    function updatePlayerScore(uint256 playerId, uint256 score) public {
        playerScores[playerId] = score;
        emit PlayerScoreUpdated(playerId, score);
*/
