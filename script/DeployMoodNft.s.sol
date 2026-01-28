// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {MoodNft} from "../src/MoodNft.sol";
import {Script, console} from "forge-std/Script.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

/**
 * @title DeployMoodNft
 * @author 0xnightswatch
 * @notice Deployment script for the MoodNft contract
 * @dev Reads SVG files from disk, converts them to Base64 data URIs, and deploys the contract
 */
contract DeployMoodNft is Script {
    /**
     * @notice Main deployment function
     * @dev Reads the sad.svg and happy.svg files, converts them to data URIs,
     * and deploys the MoodNft contract with these URIs
     * @return moodNft The newly deployed MoodNft contract instance
     */
    function run() external returns (MoodNft) {
        // Read SVG files from the img directory
        string memory sadSvg = vm.readFile("./img/sad.svg");
        string memory happySvg = vm.readFile("./img/happy.svg");

        // Deploy the contract with Base64-encoded SVG URIs
        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(
            svgToImageURI(sadSvg),
            svgToImageURI(happySvg)
        );
        vm.stopBroadcast();
        return moodNft;
    }

    /**
     * @notice Converts an SVG string to a Base64-encoded data URI
     * @dev Takes raw SVG markup and returns it as a data URI suitable for on-chain storage
     * @param svg The raw SVG markup as a string
     * @return A complete data URI in the format: data:image/svg+xml;base64,[base64-encoded-svg]
     */
    function svgToImageURI(
        string memory svg
    ) public pure returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "data:image/svg+xml;base64,",
                    Base64.encode(bytes(string(abi.encodePacked(svg))))
                )
            );
    }
}
