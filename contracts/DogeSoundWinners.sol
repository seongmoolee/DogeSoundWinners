pragma solidity ^0.5.6;

import "./klaytn-contracts/token/KIP17/KIP17Full.sol";
import "./klaytn-contracts/token/KIP17/KIP17Mintable.sol";
import "./klaytn-contracts/token/KIP17/KIP17Burnable.sol";
import "./klaytn-contracts/token/KIP17/KIP17Pausable.sol";

contract DogeSoundWinners is KIP17Full("DSC DogeSound Winners", "DSW"), KIP17Mintable, KIP17Burnable, KIP17Pausable {

    mapping(uint256 => string) public dogeSounds;

    function tokenURI(uint256 tokenId) public view returns (string memory) {
        require(_exists(tokenId), "KIP17Metadata: URI query for nonexistent token");
        
        if (tokenId == 0) {
            return "https://api.dogesound.club/dogesoundwinners/0";
        }

        string memory baseURI = "https://api.dogesound.club/dogesoundwinners/";
        string memory idstr;
        
        uint256 temp = tokenId;
        uint256 digits;
        while (temp != 0) {
            digits += 1;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (tokenId != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(tokenId % 10)));
            tokenId /= 10;
        }
        idstr = string(buffer);

        return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, idstr)) : "";
    }
    
    function mint(address to, uint256 tokenId, string memory dogeSound) public onlyMinter returns (bool) {
        dogeSounds[tokenId] = dogeSound;
        return mint(to, tokenId);
    }
}
