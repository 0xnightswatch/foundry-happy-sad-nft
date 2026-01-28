// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {MoodNft} from "../src/MoodNft.sol";

/**
 * @title MintBasicNft
 * @author 0xnightswatch
 * @notice Script to mint a BasicNft from the most recently deployed contract
 * @dev Uses DevOpsTools to find the latest deployment on the current chain
 */
contract MintBasicNft is Script {
    /// @notice IPFS URI pointing to the PUG NFT metadata
    string public constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    /**
     * @notice Main execution function that finds and mints on the latest deployment
     * @dev Retrieves the most recent BasicNft deployment and mints a PUG NFT
     */
    function run() external {
        address mostRecentDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNft",
            block.chainid
        );
        mintNftOnContract(mostRecentDeployed);
    }

    /**
     * @notice Mints a PUG NFT on a specific BasicNft contract
     * @dev Broadcasts the mint transaction to the network
     * @param contractAddrss The address of the BasicNft contract to mint from
     */
    function mintNftOnContract(address contractAddrss) public {
        vm.startBroadcast();
        BasicNft(contractAddrss).mintNft(PUG);
        vm.stopBroadcast();
    }
}

/**
 * @title MintMoodNft
 * @author 0xnightswatch
 * @notice Script to mint a MoodNft from the most recently deployed contract
 * @dev Uses DevOpsTools to find the latest deployment on the current chain
 */
contract MintMoodNft is Script {
    /**
     * @notice Main execution function that finds and mints on the latest deployment
     * @dev Retrieves the most recent MoodNft deployment and mints a new mood NFT
     */
    function run() external {
        address mostRecentDeloyed = DevOpsTools.get_most_recent_deployment(
            "MoodNft",
            block.chainid
        );
        mintMoodNft(mostRecentDeloyed);
    }

    /**
     * @notice Mints a MoodNft on a specific MoodNft contract
     * @dev Broadcasts the mint transaction to the network
     * The newly minted NFT will start with a HAPPY mood by default
     * @param contractAddress The address of the MoodNft contract to mint from
     */
    function mintMoodNft(address contractAddress) public {
        vm.startBroadcast();
        MoodNft(contractAddress).mintNft();
        vm.stopBroadcast();
    }
}

/**
 * @title FlipMoodNft
 * @author 0xnightswatch
 * @notice Script to flip the mood of a MoodNft token
 * @dev Uses DevOpsTools to find the latest deployment and flips token ID 0
 */
contract FlipMoodNft is Script {
    /// @notice The token ID to flip (currently set to 0)
    uint256 constant tokenIdToPass = 0;

    /**
     * @notice Main execution function that finds and flips the mood of the latest deployment
     * @dev Retrieves the most recent MoodNft deployment and flips the mood of token 0
     */
    function run() external {
        address mostRecentDeployed = DevOpsTools.get_most_recent_deployment(
            "MoodNft",
            block.chainid
        );
        flipMoodNft(mostRecentDeployed);
    }

    /**
     * @notice Flips the mood of token 0 on a specific MoodNft contract
     * @dev Broadcasts the flipMood transaction to the network
     * The mood will toggle between HAPPY and SAD
     * @param contractAddress The address of the MoodNft contract
     */
    function flipMoodNft(address contractAddress) public {
        vm.startBroadcast(msg.sender);
        MoodNft(contractAddress).flipMood(tokenIdToPass);
        vm.stopBroadcast();
    }
}
