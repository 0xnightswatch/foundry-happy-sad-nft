// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

/**
 * @title MoodNft
 * @author 0xnightswatch
 * @notice This contract implements a dynamic, mood-based NFT that's 100% stored on-chain
 * @dev The NFT uses SVG images encoded in Base64 and stored on-chain
 * Users can flip the mood between HAPPY and SAD, which changes the displayed image
 * All metadata is generated dynamically and stored on-chain using data URIs
 */
contract MoodNft is ERC721 {
    /*//////////////////////////////////////////////////////////////
                            CUSTOM ERRORS
    //////////////////////////////////////////////////////////////*/
    
    /// @notice Thrown when someone tries to flip the mood of an NFT they don't own
    error MoodNft__CantFlipMoodIfNotOwner();
    
    /// @notice Thrown when attempting to mint more than the allowed number of NFTs
    error MoodNft_TotalNumberOfNftWasReached();

    /*//////////////////////////////////////////////////////////////
                            STATE VARIABLES
    //////////////////////////////////////////////////////////////*/
    
    /// @notice Counter to track the total number of NFTs minted
    uint256 private s_tokenCounter;
    
    /// @notice Base64-encoded SVG data URI for the sad mood image
    string private s_sadSvgImageUri;
    
    /// @notice Base64-encoded SVG data URI for the happy mood image
    string private s_happySvgImageUri;

    /**
     * @notice Enum representing the possible moods of the NFT
     * @dev HAPPY = 0, SAD = 1
     */
    enum Mood {
        HAPPY,
        SAD
    }

    /// @notice Maps each token ID to its current mood state
    mapping(uint256 => Mood) private s_tokenIdToMood;

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/
    
    /**
     * @notice Initializes the MoodNft contract with SVG image URIs
     * @dev Sets the NFT collection name to "Mood NFT" and symbol to "MN"
     * @param sadSvgImageUri Base64-encoded data URI for the sad mood SVG image
     * @param happySvgImageUri Base64-encoded data URI for the happy mood SVG image
     * These URIs should be in the format: data:image/svg+xml;base64,[base64-encoded-svg]
     */
    constructor(
        string memory sadSvgImageUri,
        string memory happySvgImageUri
    ) ERC721("Mood NFT", "MN") {
        s_tokenCounter = 0;
        s_happySvgImageUri = happySvgImageUri;
        s_sadSvgImageUri = sadSvgImageUri;
    }

    /*//////////////////////////////////////////////////////////////
                        EXTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Mints a new Mood NFT to the caller
     * @dev Currently limited to minting only one NFT (tokenId 0) per contract deployment
     * The NFT is initialized with a HAPPY mood by default
     * NOTE: Due to the current logic, only token ID 0 can be minted successfully
     */
    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        if (s_tokenCounter != 0) {
            revert MoodNft_TotalNumberOfNftWasReached();
        }
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }

    /**
     * @notice Returns the base URI for computing tokenURI
     * @dev Overrides ERC721's _baseURI to use a data URI format for on-chain metadata
     * @return The base URI string for JSON metadata encoded in Base64
     */
    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    /**
     * @notice Returns the metadata URI for a given token ID
     * @dev Dynamically generates the metadata JSON on-chain based on the NFT's current mood
     * The entire metadata is encoded as a Base64 data URI for full on-chain storage
     * @param tokenId The ID of the token to query
     * @return A data URI containing Base64-encoded JSON metadata with the appropriate mood image
     * 
     * Structure of returned JSON:
     * - name: The collection name
     * - description: Description of the dynamic NFT
     * - attributes: Trait information (moodiness: 100)
     * - image: SVG image data URI that changes based on current mood
     */
    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        // Select the appropriate image URI based on the current mood
        string memory imageURI;
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageURI = s_happySvgImageUri;
        } else {
            imageURI = s_sadSvgImageUri;
        }

        // Construct the complete metadata JSON and encode it as a Base64 data URI
        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes( // bytes casting actually unnecessary as 'abi.encodePacked()' returns a bytes
                            abi.encodePacked(
                                '{"name":"',
                                name(), // You can add whatever name here
                                '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
                                '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }

    /**
     * @notice Toggles the mood of an NFT between HAPPY and SAD
     * @dev Only the NFT owner can flip its mood
     * After flipping, you may need to refresh the NFT in your wallet to see the updated image
     * @param tokenId The ID of the token whose mood should be flipped
     * @custom:reverts MoodNft__CantFlipMoodIfNotOwner if caller is not the token owner
     */
    function flipMood(uint256 tokenId) public {
        // Only the owner of the NFT can change its mood
        if (msg.sender != _ownerOf(tokenId)) {
            revert MoodNft__CantFlipMoodIfNotOwner();
        }
        // Toggle between HAPPY and SAD
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    /*//////////////////////////////////////////////////////////////
                            VIEW FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Returns the current mood of a given token
     * @param tokenId The ID of the token to query
     * @return The current Mood enum value (HAPPY or SAD) for the specified token
     */
    function getMood(uint256 tokenId) public view returns (Mood) {
        return s_tokenIdToMood[tokenId];
    }
}
