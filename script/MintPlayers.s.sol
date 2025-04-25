// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Script.sol";
import {FantasyPlayerNFT} from "../src/FantasyPlayerNFT.sol";
import {SavePlayers} from "./SavePlayers.s.sol";

contract MintPlayers is Script {
    function run() external {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        address nftContractAddress = vm.envAddress("NFT_CONTRACT_ADDRESS");
        address owner = vm.addr(privateKey);

        vm.startBroadcast(privateKey);

        FantasyPlayerNFT nft = FantasyPlayerNFT(nftContractAddress);
        SavePlayers.PlayerData[] memory players = SavePlayers.getPlayers();

        uint256 batchSize = 20;
        uint256 start = vm.envOr("START_INDEX", uint256(0));
        uint256 end = start + batchSize;
        if (end > players.length) {
            end = players.length;
        }

        for (uint256 i = start; i < end; i++) {
            nft.mintPlayer(owner, players[i].name, players[i].team);
        }

        vm.stopBroadcast();
    }
}
