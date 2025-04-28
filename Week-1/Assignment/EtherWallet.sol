// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title EtherWallet
/// @author Jitendra Kumar
/// @notice A simple smart contract that allows users to deposit and withdraw Ether.
contract EtherWallet {
    address payable public owner;
    mapping(address => uint256) private deposits;
    bool private withdrawing;

    event Deposit(address indexed sender, uint256 amount);
    event Withdrawal(address indexed recipient, uint256 amount);

    modifier nonReentrant() {
        require(!withdrawing, "Reentrant call");
        withdrawing = true;
        _;
        withdrawing = false;
    }

    constructor() {
        owner = payable(msg.sender);
    }

    /// @notice Allows the contract to receive Ether directly.
    receive() external payable {
        emit Deposit(msg.sender, msg.value); 
    }

    /// @notice Allows users to deposit Ether into their account within the wallet.
    function deposit() external payable {
        require(msg.value > 0, "Amount must be greater than zero!");
        deposits[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    /// @notice Allows the contract owner to withdraw a specific amount of Ether from the contract.
    /// @param _amount The amount of Ether to withdraw.
    function withdraw(uint256 _amount) external nonReentrant {
        require(msg.sender == owner, "Only the owner can withdraw funds.");
        require(address(this).balance >= _amount, "Insufficient contract balance.");
        (bool success, ) = owner.call{value: _amount}("");
        require(success, "Withdrawal failed.");
        emit Withdrawal(owner, _amount);
    }

    /// @notice Allows users to withdraw their deposited Ether.
    function withdrawDeposit() external nonReentrant {
        address payable sender = payable(msg.sender);
        uint256 amount = deposits[sender];
        require(amount > 0 && address(this).balance >= amount, "Invalid or insufficient deposit.");
        deposits[sender] = 0;
        (bool success, ) = sender.call{value: amount}("");
        require(success, "Withdrawal not successful!");
        emit Withdrawal(sender, amount);
    }

    /// @notice Returns the amount of Ether deposited by the caller.
    /// @return The deposited amount in Wei.
    function getDepositAmount() external view returns (uint256) {
        return deposits[msg.sender];
    }

    /// @notice Returns the total balance of the contract.
    /// @return The contract balance in Wei.
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
