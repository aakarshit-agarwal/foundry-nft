// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";
import {BasicNft} from "../../src/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft deployBasicNft;
    BasicNft basicNft;

    address public user1 = makeAddr("user1");
    string public constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployBasicNft = new DeployBasicNft();
        basicNft = deployBasicNft.run();
    }

    function testName() public view {
        string memory expectedName = "BasicNft";
        string memory actualName = basicNft.name();
        assert(
            keccak256(abi.encodePacked(actualName)) ==
                keccak256(abi.encodePacked(expectedName))
        );
    }

    function testCanMintAndHaveBalance() public {
        vm.prank(user1);
        basicNft.mintNft(PUG);

        assert(basicNft.balanceOf(user1) == 1);
        assert(
            keccak256(abi.encodePacked(basicNft.tokenURI(0))) ==
                keccak256(abi.encodePacked(PUG))
        );
    }
}
