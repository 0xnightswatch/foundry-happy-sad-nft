// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

/**
 * @title BasicNft
 * @author 0xnightswatch
 * @notice This contract implements a basic ERC721 NFT with IPFS-hosted metadata
 * @dev This is a static NFT collection where each token points to immutable IPFS content
 * The NFT represents a "Dogie" collection where each dog has its own unique token ID
 */
contract BasicNft is ERC721 {
    /*//////////////////////////////////////////////////////////////
                            STATE VARIABLES
    //////////////////////////////////////////////////////////////*/
    
    /// @notice Counter to track the total number of NFTs minted
    /// @dev Incremented with each mint, ensuring unique token IDs
    uint256 private s_tokenCounter;
    
    /// @notice Maps each token ID to its corresponding IPFS metadata URI
    /// @dev Stores the tokenURI for each minted NFT
    mapping(uint256 => string) private s_tokenIdToUri;

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/
    
    /**
     * @notice Initializes the BasicNft contract
     * @dev Sets the NFT collection name to "Dogie" and symbol to "DOG"
     * Each NFT in the Dogie collection will have its unique token ID starting from 0
     */
    constructor() ERC721("Dogie", "DOG") {
        s_tokenCounter = 0;
    }

    /*//////////////////////////////////////////////////////////////
                        EXTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Mints a new NFT to the caller
     * @dev Creates a new token with the next available token ID and assigns it to msg.sender
     * @param tokenUri The IPFS URI pointing to the NFT's metadata (typically ipfs://...)
     * This should link to a JSON file containing the NFT's name, description, and image
     */
    function mintNft(string memory tokenUri) public {
        s_tokenIdToUri[s_tokenCounter] = tokenUri;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter += 1;
    }

    /**
     * @notice Returns the metadata URI for a given token ID
     * @dev Overrides the ERC721 tokenURI function to return our custom IPFS URI
     * @param tokenId The ID of the token to query
     * @return The IPFS URI string associated with the token ID
     */
    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        return s_tokenIdToUri[tokenId];
    }
}
