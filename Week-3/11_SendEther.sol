// SPDX-License-Identifier: MIT
/*
//transfer function is revert the transaction if any error occured in between any transaction but 
send function did not revert the transaction. 

    function sendEth() public payable{
        payable(0x417Bf7C9dc415FEEb693B6FE313d1186C692600F).transfer(1 ether);
    }
    function sendEthWithSendFun() public payable{
        bool success=payable(0x09943Fa8DD32C76f7b880627a0F6af73e8f5A595).send(1 ether);
        require(success,"Transfer Failed!");
    }

    //Best way to transfer ether by using call function
    function sendEthWithCallFun() public payable{
        (bool success,)=payable(0x09943Fa8DD32C76f7b880627a0F6af73e8f5A595).call{value : 1 ether}("Jay Gangwar");
        require(success,"Transfer Failed!");
    }

*/

/*
You can send Ether to other contracts by

transfer (2300 gas, throws error)
send (2300 gas, returns bool)
call (forward all gas or set gas, returns bool)
How to receive Ether?
A contract receiving Ether must have at least one of the functions below

receive() external payable
fallback() external payable
receive() is called if msg.data is empty, otherwise fallback() is called.

Which method should you use?
call in combination with re-entrancy guard is the recommended method to use after December 2019.

Guard against re-entrancy by

making all state changes before calling other contracts
using re-entrancy guard modifier

*/




pragma solidity ^0.8.13;

contract ReceiveEther {
    /*
    Which function is called, fallback() or receive()?

           send Ether
               |
         msg.data is empty?
              / \
            yes  no
            /     \
receive() exists?  fallback()
         /   \
        yes   no
        /      \
    receive()   fallback()
    */

    
    // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract SendEther {
    function sendViaTransfer(address payable _to) public payable {
        // This function is no longer recommended for sending Ether.
        _to.transfer(msg.value);
    }

    function sendViaSend(address payable _to) public payable {
        // Send returns a boolean value indicating success or failure.
        // This function is not recommended for sending Ether.
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    function sendViaCall(address payable _to) public payable {
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        (bool sent,) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}
