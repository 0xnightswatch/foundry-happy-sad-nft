// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";

/**
 * @title DeployBasicNft
 * @author 0xnightswatch
 * @notice Deployment script for the BasicNft contract
 * @dev Uses Foundry's Script contract to handle deployment broadcasts
 */
contract DeployBasicNft is Script {
    /**
     * @notice Main deployment function
     * @dev Deploys a new BasicNft contract and returns its address
     * @return basicNft The newly deployed BasicNft contract instance
     */
    function run() external returns (BasicNft) {
        // Start broadcasting transactions to the network
        vm.startBroadcast();
        BasicNft basicNft = new BasicNft();
        vm.stopBroadcast();
        return basicNft;
    }
}
