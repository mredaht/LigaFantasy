// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import {FantasyPlayerNFT} from "../src/FantasyPlayerNFT.sol";
import {SavePlayers} from "./SavePlayers.s.sol";

contract MintPlayers is Script {
    function run() external {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        address nftContractAddress = vm.envAddress("NFT_CONTRACT_ADDRESS");

        vm.startBroadcast(privateKey);

        FantasyPlayerNFT nft = FantasyPlayerNFT(nftContractAddress);
        SavePlayers.PlayerData[] memory players = SavePlayers.getPlayers();

        for (uint256 i = 0; i < players.length; i++) {
            nft.mintPlayer(msg.sender, players[i].name, players[i].team);
        }

        vm.stopBroadcast();
    }
}
