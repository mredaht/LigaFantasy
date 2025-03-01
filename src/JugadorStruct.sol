// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

library JugadorStruct {
    struct Jugador {
        uint256 id; // Identificador único del jugador
        string nombre;
        string equipo;
        uint256 puntuacion;
    }
}
