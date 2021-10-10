# 🏗 Easy Mint

Easy Mint allows you to lazy mint NFTs for free. Token metadata & minting signatures are stored on Rarible back-end until a buyer fills the order. It also includes integration for Canva NFT Minter which allows the Canva users to publish their designs as NFT using the custom Canva Publish app. Easy Mint is powered using scaffold-eth - Rarible Starter App and Canva NFT Minter. 

---
#### [Ropsten App Link](https://easy-mint.netlify.app/lazyMint?tokenURI=Qmc9hvaC9EUK7efbCfJc2QESB9NxW84jbPiTvz1p6Lh91d)

#### [ 🏃‍♀️ Quick Start ](#quick-start)

#### [🖼 Minting Your Collectibles](#mint-your-collectibles)

#### [🗂 Rarible Item Indexer](#rarible-item-indexer)

#### [📒 Rarible Order Book](#rarible-order-book)

#### [🦥 Lazy Minting](#lazy-minting)

#### [💵 Selling a lazy minted item](#selling-a-lazy-minted-item)



# Quick Start

⚠️⚠️ **This application connects to the Rarible contracts & API on Ropsten** ⚠️⚠

required: [Node](https://nodejs.org/dist/latest-v12.x/) plus [Yarn](https://classic.yarnpkg.com/en/docs/install/) and [Git](https://git-scm.com/downloads)


```bash
git clone https://github.com/viraja1/nft_tools.git
cd nft_tools/easy_mint
```

```bash

yarn install

```

```bash

yarn start

```

📱 Open http://localhost:3000 to see the app

🏗 scaffold-eth is a hackthon stack for quick product prototyping on Ethereum.

👩‍🔬 This scaffolding leverages state of the art tooling from the ecosystem.

🖼 This fork of scaffold-eth implements the basic features and functionality of the Rarible protocol

🧪 It is a free standing dapp so you can learn by making small changes.

# Mint your collectibles


Get Ropsten Eth from a [faucet](https://faucet.ropsten.be/)

You can Mint an NFT by clicking on the Mint tab and specifying the IPFS hash for the metadata URI. 

You can then visit your new NFTs on the Rarible site by specifying the contract address & tokenID in the URL like this

![Screen Shot 2021-06-14 at 3 53 15 PM](https://user-images.githubusercontent.com/4401444/121971823-a59f8880-cd47-11eb-8aff-84a51728d8f9.png)


`https://ropsten.rarible.com/token/0x66f806bf40bfa98f2dac85a85d437895043f2be5:1?tab=owners`


# Rarible Item Indexer

Go to the Rarible Item indexer tab and enter the contract address of your NFT.

This tab uses the metadata indexer which is documented here: https://api-reference.rarible.com/#operation/getItemMetaById


![Screen Shot 2021-06-14 at 4 04 38 PM](https://user-images.githubusercontent.com/4401444/121971842-b3550e00-cd47-11eb-9a93-1ebaa32e2bc0.png)


You can also use the Rarible indexer to get NFT data for an entire collection, all NFTs owned by an address, and more.

# Rarible Order Book

We can create a sell order for one of these NFTs right from the item indexer.

First we need to make sure the Rarible Exchange is approved to transfer NFTs on our behalf when they are sold.

Enter the Rarible Transfer Proxy address and hit 'Approve'.

Rarible Transfer Proxy on Ropsten: 0xf8e4ecac18b65fd04569ff1f0d561f74effaa206

![Screen Shot 2021-06-14 at 4 11 37 PM](https://user-images.githubusercontent.com/4401444/121971856-bd770c80-cd47-11eb-9f47-472f53232466.png)


[Example Tx](https://ropsten.etherscan.io/tx/0x288715731a6daac47757968c3dcd89e8af462b87df410cf2a4c5a14ae3c481a4)

Now select 'Sell for ETH' and enter the ETH amount and use the *️⃣ button to format it in wei.

Sign the order to submit it to Rarible.


![Screen Shot 2021-06-14 at 4 16 10 PM](https://user-images.githubusercontent.com/4401444/121971873-c667de00-cd47-11eb-9fba-18e6874d4ea4.png)



Now go over to the Rarible Order Indexer tab and find the order you just created by entering the collection address and token ID.

Fill the order, and submit the transaction to the Rarible exchange.


![Screen Shot 2021-06-14 at 4 28 29 PM](https://user-images.githubusercontent.com/4401444/121971889-d1227300-cd47-11eb-9964-6592d5ad2388.png)


[Example Tx](https://ropsten.etherscan.io/tx/0xabe5433e500a6d3db229fb7630f898c37d30d4422dde69c1ab20a2b84cce2462)

Now on the Rarible UI you can see the listing and transfer history!


![Screen Shot 2021-06-14 at 5 20 35 PM](https://user-images.githubusercontent.com/4401444/121971901-d97aae00-cd47-11eb-966b-d8c36bd0e6db.png)


# Lazy Minting

With Lazy Minting you can defer the gas costs of minting the NFT to the first buyer.

For this example we will use the standard Rarible ERC721 contract deployed here: 0xB0EA149212Eb707a1E5FC1D2d3fD318a8d94cf05

All you need for lazy minting is the IPFS hash of your NFT content.

Go to the IPFS upload tab

Modify the content, or just hit upload

![Screen Shot 2021-06-14 at 7 39 22 PM](https://user-images.githubusercontent.com/4401444/121972118-5148d880-cd48-11eb-9260-2ced5b4f7660.png)


Copy the IPFS hash

Go to the lazy minting tab and enter the hash.

Press mint

![Screen Shot 2021-06-14 at 7 39 35 PM](https://user-images.githubusercontent.com/4401444/121972108-4c842480-cd48-11eb-8474-85f56c23d3f4.png)



Now let's go to the item indexer and see the lazy minted NFT

Copy your contract address and token ID from the lazy minting tab

Enter them on the item indexer

We can also view the lazy minted item on the Rarible UI!

![Screen Shot 2021-06-14 at 7 40 48 PM](https://user-images.githubusercontent.com/4401444/121972194-750c1e80-cd48-11eb-83a6-2345de2f9c7f.png)



https://ropsten.rarible.com/token/0xB0EA149212Eb707a1E5FC1D2d3fD318a8d94cf05:52585140568026265337503508601622814624376142828352682734444878603886713110535?tab=history

# Selling a lazy minted item

Same process as the normal minted item. Enter your contract address & token ID on the order indexer, and click 'fill order'.

![Screen Shot 2021-06-14 at 5 59 45 PM](https://user-images.githubusercontent.com/4401444/121971984-05962f00-cd48-11eb-92ed-93e2a96eadb1.png)


# Canva Integration
Create a new Canva app and specify this App's frontend url as the redirect url in the Canva App Backend

https://github.com/viraja1/canva_nft_minter

# Built with scaffold-eth

This starter app was built using Austin Griffith's Scaffold-Eth framework. For more starter apps and inspiration check out the [BuidlGuidl](https://buidlguidl.com/)

