// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Game {
    constructor() payable {}

    // Randomly picks a number out of 0 to `2²⁵⁶–1`.
    function pickCard() private view returns (uint256) {
        // encodedPacked takes in the two params - blockhash and blockl.timestamp
        // returns a byte array whitch furter gets passed into keccak256 which returns "bytes32"
        // with further converted to a "uint256"
        // keccak256 is a hashing function which takes in a bytes array and converts into a bytes32
        uint256 pickedCard = uint256(
            keccak256(abi.encodePacked(blockhash(block.number), block.timestamp))
        );
        return pickedCard;
    }

    function guess(uint256 _guess) public {
        uint256 _pickedCard = pickCard();
        if (_guess == _pickedCard) {
            (bool send, ) = msg.sender.call{value: 0.1 ether}("");
            require(!send, "Transacrion failed");
        }
    }

    // Retruns the balance of ether in the contract

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
