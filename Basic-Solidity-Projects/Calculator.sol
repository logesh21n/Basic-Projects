// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

/**
 * @title Calculator
 * @dev A simple contract that provides basic arithmetic operations.
 */
contract Calculator {
    /**
     * @dev Adds two numbers.
     * @param a The first number.
     * @param b The second number.
     * @return The sum of the two numbers.
     */
    function add(uint a, uint b) public pure returns (uint) {
        return a + b; // Return the sum of the two numbers
    }

    /**
     * @dev Subtracts one number from another.
     * @param a The first number.
     * @param b The second number.
     * @return The result of subtracting b from a.
     */
    function sub(uint a, uint b) public pure returns (uint) {
        return a - b; // Return the result of subtracting b from a
    }

    /**
     * @dev Multiplies two numbers.
     * @param a The first number.
     * @param b The second number.
     * @return The product of the two numbers.
     */
    function mul(uint a, uint b) public pure returns (uint) {
        return a * b; // Return the product of the two numbers
    }

    /**
     * @dev Divides one number by another.
     * @param a The numerator.
     * @param b The denominator.
     * @return The result of dividing a by b.
     */
    function div(uint a, uint b) public pure returns (uint) {
        require(b != 0, "Cannot divide by zero"); // Ensure that the denominator is not zero
        return a / b; // Return the result of dividing a by b
    }
}
