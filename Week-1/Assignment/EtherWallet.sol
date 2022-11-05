//SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract EtherWallet {
    address payable public owner;
    mapping(address => uint) private sender_amount;

    constructor() {
        owner = payable(msg.sender);
    }

    // receive() external payable {}

    function deposit() external payable {
        require(msg.value > 0,"amount must be greater than zero!");
        sender_amount[msg.sender]+=msg.value;
        
    }

    function withdraw(uint _amount) external {
        require(msg.sender == owner, "caller is not owner");
        payable(msg.sender).transfer(_amount);
    }

    function withdrawDeposit() public{
        address sender_address =payable(msg.sender);
        uint amount=sender_amount[sender_address];
        (bool success,)=sender_address.call{value:amount}("Withdraw");
        require(success,"Withdraw not successful!");
        sender_amount[sender_address]=0;
    }

    function getDepositAmount() public view returns(uint){
        return sender_amount[msg.sender];
    }

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}
