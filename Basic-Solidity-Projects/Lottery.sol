// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

/**
 * @title Lottery
 * @dev A simple lottery contract where players can enter by paying a fixed amount of ether, and the owner can pick a winner randomly.
 */
contract Lottery {
    address public owner; // Address of the contract owner
    address payable[] public players; // Array to store player addresses
    address[] public winners; // Array to store winner addresses
    uint public lotteryId; // ID of the current lottery round

    /**
     * @dev Constructor function to initialize the contract and set the owner and initial lottery ID.
     */
    constructor() {
        owner = msg.sender; // Set the contract deployer as the owner
        lotteryId = 0; // Initialize the lottery ID
    }

    /**
     * @dev Function for players to enter the lottery by sending a fixed amount of ether.
     */
    function enterLottery() public payable {
        require(
            msg.value == 0.1 ether,
            "Please pay 0.1 ether to enter the lottery"
        ); // Check if the sent value is correct
        players.push(payable(msg.sender)); // Add the player to the players array
    }

    /**
     * @dev Function to retrieve the list of players.
     * @return An array of player addresses.
     */
    function getPlayers() public view returns (address payable[] memory) {
        return players; // Return the array of player addresses
    }

    /**
     * @dev Function to get the current balance of the contract.
     * @return The balance of the contract in wei.
     */
    function getBalance() public view returns (uint) {
        return address(this).balance; // Return the balance of the contract
    }

    /**
     * @dev Function to get the current lottery ID.
     * @return The ID of the current lottery round.
     */
    function getLotteryId() public view returns (uint) {
        return lotteryId; // Return the current lottery ID
    }

    /**
     * @dev Function to generate a random number based on block information.
     * @return A random number.
     */
    function getRandomNumber() public view returns (uint) {
        // Generate a random number using block information
        return
            uint(
                keccak256(
                    abi.encodePacked(
                        owner,
                        block.timestamp,
                        block.number,
                        block.difficulty
                    )
                )
            );
    }

    /**
     * @dev Function for the owner to pick a winner randomly.
     */
    function pickWinner() public {
        require(
            msg.sender == owner,
            "Only owner can call the pickWinner function"
        ); // Check if the caller is the owner
        uint randomIndex = getRandomNumber() % players.length; // Generate a random index
        players[randomIndex].transfer(address(this).balance); // Transfer the contract balance to the winner
        winners.push(players[randomIndex]); // Add the winner to the winners array
        lotteryId++; // Increment the lottery ID for the next round
        players = new address payable[](0); // Reset the players array for the next round
    }
}
