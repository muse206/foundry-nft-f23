//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";
import {BasicNft} from "../../src/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public constant USER = address(1);
    string public constant WHALE_URI = 
        "ipfs://bafybeih6fjgpcs4dqmkncnbr4h3egliicebyfjpm4cpazssvf2psfwmrca/?filename=PirateWhale.png";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }
    function testNameIsCorrect() public view {
        string memory expectedName = "Pirate Whale";
        string memory actualName = basicNft.name();
        abi.encodePacked(actualName, expectedName);
        assert(
            keccak256(abi.encodePacked(expectedName)) == 
                keccak256(abi.encodePacked(actualName))
        );
    }
    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(WHALE_URI);

        assert(basicNft.balanceOf(USER) == 1);
        assert( 
            keccak256(abi.encodePacked(WHALE_URI)) ==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }
}