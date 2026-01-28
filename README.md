# Foundry Happy-Sad NFT 🐶

## 📖 About

This project demonstrates two different approaches to creating NFTs on Ethereum:

### 1. **BasicNft** - Static IPFS-Based NFT
- Creates **static, immutable** NFT images stored on IPFS
- Each NFT features a unique dog image with a fixed appearance
- Metadata and images are hosted off-chain on IPFS for decentralization
- Perfect for traditional NFT collections with unchanging artwork

### 2. **MoodNft** - Dynamic On-Chain SVG NFT
- Creates **dynamic NFTs** with images stored entirely on-chain using SVG
- The NFT's appearance changes based on its "mood" (Happy 😊 or Sad 😢)
- Owners can flip the mood of their NFT at any time
- All metadata and images are generated on-chain using Base64-encoded data URIs
- **100% on-chain** - no external dependencies!

## ✨ Features

- **Two NFT Types**: Choose between static IPFS NFTs or dynamic on-chain NFTs
- **Mood Switching**: MoodNft owners can toggle between happy and sad states
- **On-Chain SVG**: MoodNft images are fully stored on the blockchain
- **IPFS Integration**: BasicNft leverages IPFS for decentralized storage
- **Foundry Scripts**: Complete deployment and interaction scripts included

## 🚀 Getting Started

### Prerequisites
- [Foundry](https://book.getfoundry.sh/getting-started/installation) installed
- An Ethereum wallet with some testnet ETH

### Installation

1. Clone the repository:
```bash
git clone https://github.com/0xnightswatch/foundry-happy-sad-nft.git
cd foundry-happy-sad-nft
```

2. Install dependencies:
```bash
make install
```

3. Build the project:
```bash
make build
```

### Running Tests

Run all tests:
```bash
make test
```

## 📝 Usage

### Deploy BasicNft
```bash
make deployBasicNft
```

### Deploy MoodNft
```bash
make deployMoodNft
```

### Mint a BasicNft
```bash
make mintBasicNft
```

### Mint a MoodNft
```bash
make mintMoodNft
```

### Flip the Mood of a MoodNft
```bash
make flipMoodNft
```

**Note:** After flipping the mood, you may need to refresh the NFT in your wallet (remove and re-import it) to see the updated image.

## 🎨 Customization Ideas

This project is designed to be a starting point for your own NFT experiments! Here are some ways to extend it:

### For BasicNft:
- Replace the dog images with your own artwork on IPFS
- Create a larger collection with multiple token IDs
- Add rarity traits and attributes to the metadata

### For MoodNft:
- Add more mood states beyond happy and sad (excited, angry, sleepy, etc.)
- Create different SVG designs for each mood
- Add attributes that change based on mood
- Implement time-based automatic mood changes
- Add game mechanics that reward mood flipping

## 🛠️ Technical Details

### BasicNft Contract
- **Standard**: ERC721
- **Storage**: IPFS (off-chain)
- **Name**: Dogie
- **Symbol**: DOG

### MoodNft Contract
- **Standard**: ERC721
- **Storage**: 100% on-chain SVG
- **Name**: Mood NFT
- **Symbol**: MN
- **States**: HAPPY (0) or SAD (1)

## 📂 Project Structure

```
├── src/
│   ├── BasicNft.sol       # Static IPFS-based NFT contract
│   └── MoodNft.sol        # Dynamic on-chain SVG NFT contract
├── script/
│   ├── DeployBasicNft.s.sol    # BasicNft deployment script
│   ├── DeployMoodNft.s.sol     # MoodNft deployment script
│   └── Interactions.s.sol      # Minting and interaction scripts
├── test/
│   ├── unit/              # Unit tests
│   └── integrations/      # Integration tests
├── img/
│   ├── happy.svg          # Happy mood SVG image
│   └── sad.svg            # Sad mood SVG image
└── Makefile               # Build and deployment commands
```

## 🤝 Contributing

Feel free to fork this project and make it your own! Contributions are welcome.

## 📄 License

This project is licensed under the MIT License.

## 🎉 Have Fun!

Experiment with the code, create unique NFTs, and learn about the different approaches to NFT development on Ethereum!
