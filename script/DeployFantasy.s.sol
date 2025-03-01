// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import "../src/FantasyPlayerNFT.sol";
import "../src/FantasyLeague.sol";

contract DeployFantasy is Script {
    function run() external {
        vm.startBroadcast();

        // 1. Desplegar el contrato de jugadores NFT
        FantasyPlayerNFT fantasyPlayerNFT = new FantasyPlayerNFT();
        console.log("FantasyPlayerNFT deployed at:", address(fantasyPlayerNFT));

        // 2. Mintear jugadores (Ejemplo: 7 mejores jugadores por equipo de La Liga)
        string[7] memory barcelonaPlayers = [
            "Lewandowski",
            "Pedri",
            "Gavi",
            "Ter Stegen",
            "De Jong",
            "Araujo",
            "Raphinha"
        ];
        string[7] memory realMadridPlayers = [
            "Bellingham",
            "Vinicius",
            "Rodrygo",
            "Kroos",
            "Modric",
            "Courtois",
            "Camavinga"
        ];

        for (uint256 i = 0; i < 7; i++) {
            string memory barcaPlayer = barcelonaPlayers[i];
            string memory madridPlayer = realMadridPlayers[i];

            fantasyPlayerNFT.mintPlayer(msg.sender, barcaPlayer, "Barcelona");
            fantasyPlayerNFT.mintPlayer(
                msg.sender,
                madridPlayer,
                "Real Madrid"
            );
        }

        console.log("Minted players for Barcelona & Real Madrid");

        // 3. Desplegar el contrato FantasyLeague
        FantasyLeague fantasyLeague = new FantasyLeague(
            address(fantasyPlayerNFT)
        );
        console.log("FantasyLeague deployed at:", address(fantasyLeague));

        // 4. Cargar los jugadores disponibles en la FantasyLeague
        fantasyLeague.cargarJugadoresDisponibles();
        console.log("Jugadores cargados en FantasyLeague");

        vm.stopBroadcast();
    }
}
