pragma solidity 0.6.6;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@chainlink/contracts/src/v0.6/VRFConsumerBase.sol";
import "./Base64.sol";

contract EmojiCollectible is ERC721, VRFConsumerBase {
    string[] private emojis = [
       "😀", 
       "😃",
       "😄",
       "😁",
       "😆",
       "😅", 
       "😂", 
       "🤣",
       "😊",
       "😇",
       "🙂", 
       "🙃",
       "😉",
       "😌",
       "😍",
       "🥰",
       "😘",
       "😗",
       "😙",
       "😚",
       "😋",
       "😛",
       "😝",
       "😜",
       "🤪",
       "🤨",
       "🧐",
       "🤓",
       "😎",
       "🤩",
       "🥳",
       "😏",
       "😒",
       "😞",
       "😔", 
       "😟", 
       "😕", 
       "🙁", 
       "😣",
       "😖",
       "😫",
       "😩",
       "🥺",
       "😢",
       "😭",
       "😤",
       "😠",
       "😡",
       "🤬",
       "🤯",
       "😳",
       "🥵",
       "🥶", 
       "😱",
       "😨", 
       "😰", 
       "😥", 
       "😓", 
       "🤗", 
       "🤔", 
       "🤭", 
       "🤫", 
       "🤥", 
       "😶", 
       "😐", 
       "😑", 
       "😬", 
       "🙄", 
       "😯", 
       "😦",
       "😧", 
       "😮", 
       "😲",
       "😴", 
       "🤤", 
       "😪", 
       "😵",
       "🤐", 
       "🥴", 
       "🤢", 
       "🤮", 
       "🤧", 
       "😷", 
       "🤒", 
       "🤕", 
       "🤑", 
       "🤠", 
       "😈",
       "👿", 
       "👹", 
       "👺", 
       "🤡", 
       "💩",
       "👻", 
       "💀", 
       "☠️", 
       "👽", 
       "👾", 
       "🤖", 
       "🎃", 
       "😺", 
       "😸", 
       "😹", 
       "😻", 
       "😼", 
       "😽",
       "🙀", 
       "😾"
    ];

    mapping(bytes32 => address) public requestIdToSender;
    mapping(bytes32 => uint256) public requestIdToTokenId;
    event requestedCollectible(bytes32 indexed requestId, address requester); 
    event emojiAssigned(uint256 indexed tokenId);


    bytes32 internal keyHash;
    uint256 internal fee;
    
    constructor(address _VRFCoordinator, address _LinkToken, bytes32 _keyhash)
    public 
    VRFConsumerBase(_VRFCoordinator, _LinkToken)
    ERC721("EMOJI", "EMOJI")
    {
        keyHash = _keyhash;
        fee = 0.1 * 10 ** 18;
    }

    function createCollectible() 
        public returns (bytes32){
            bytes32 requestId = requestRandomness(keyHash, fee);
            requestIdToSender[requestId] = msg.sender;
            emit requestedCollectible(requestId, msg.sender);
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomNumber) internal override {
        address owner = requestIdToSender[requestId];
        uint256 newItemId = randomNumber % emojis.length;
        require(!_exists(newItemId), "This token has already been minted");
        _safeMint(owner, newItemId);
        emit emojiAssigned(newItemId);
        requestIdToTokenId[requestId] = newItemId;
    }


    function tokenURI(uint256 tokenId) override public view returns (string memory) {
        // Inspired by Loot contract - https://etherscan.io/address/0x13a48f723f4ad29b6da6e7215fe53172c027d98f#code
        string memory start = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 300 300"><style>svg { background-color: white;} .emoji{font-size:8rem;}</style><text x="10" y="140" class="emoji">';
        string memory end = '</text></svg>';
        string memory emoji = emojis[tokenId];
        string memory svg = string(abi.encodePacked(start, emoji, end));
        string memory output = string(abi.encodePacked(svg));
        string memory json = Base64.encode(bytes(string(abi.encodePacked('{"name": "Emoji #', toString(tokenId), '", "description": "On-Chain Emoji collectible", "image": "data:image/svg+xml;base64,', Base64.encode(bytes(output)), '"}'))));
        output = string(abi.encodePacked('data:application/json;base64,', json));
        return output;
    }

    function toString(uint256 value) internal pure returns (string memory) {
    // Inspired by OraclizeAPI's implementation - MIT license
    // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
}