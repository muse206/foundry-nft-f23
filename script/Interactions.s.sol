//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "../src/BasicNft.sol";


contract MintBasicNft is Script {
    string public constant WHALE_URI = 
        "ipfs://bafybeih6fjgpcs4dqmkncnbr4h3egliicebyfjpm4cpazssvf2psfwmrca/?filename=PirateWhale.png";
    function run() external {
        address mostRecentlyDeployedBasicNft = DevOpsTools
            .get_most_recent_deployment("BasicNft", block.chainid);
        mintNftOnContract(mostRecentlyDeployedBasicNft);
    }
    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(WHALE_URI);
        vm.stopBroadcast();
    }

}