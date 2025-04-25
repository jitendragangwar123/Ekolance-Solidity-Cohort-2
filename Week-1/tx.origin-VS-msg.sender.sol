/*
tx.origin:
    - Represents the original sender of the entire transaction.
    - This value never changes throughout a series of contract calls. 
    If an externally owned account (EOA) initiates a transaction that goes 
    through multiple contracts, tx.origin will always be the address of that initial EOA.

msg.sender:
    - Represents the immediate caller of the current function.
    - This value can change with each contract call. When an EOA calls a contract, 
    msg.sender is the EOA's address. If that contract then calls another contract, 
    the msg.sender in the second contract will be the address of the first contract.
*/


// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract ContractB {
    address public originalCaller;
    uint public data;

    function setData(uint _data) public {
        originalCaller = tx.origin;
        data = _data;
    }
}

contract ContractA {
    ContractB public contractB;

    constructor(address _contractBAddress) {
        contractB = ContractB(_contractBAddress);
    }

    function callB(uint _value) public {
        contractB.setData(_value);
    }
}
