// SPDX-License-Identifier: MIT

/*
:- Difference between abi.encode(),abi.encodePacked() or bytes.concate() ?

abi.encode() :- THis encodes the data and converts them into bytes.
:- 0x000000000000000000000000000000000000000000000000000000000000000800000000000000000000000000000000000000000000000000000000000003e7
:- The 1'st number is 8 (0x08) padded to 32 bytes.
:- The 2'nd number is 999 (0x3e7) padded to 32 bytes.

abi.encodePacked() :- This does the same as abi.encode(), but it also compresses it.
:- 0x0800000000000000000000000000000000000000000000000000000000000003e7
:- 0x08 (not padded sinse it's uint8)

bytes.concat() :- It contains bytes but without padding. The way we use this function here returns there the same result
as abi.encodePacked().
:- 0x0800000000000000000000000000000000000000000000000000000000000003e7
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
contract EncodeNumberData{
    uint8 constant a=8;
    uint constant b=999;
    function encode() external pure returns(bytes memory){
        return abi.encode(a,b);
    }
    function encodePacked() external pure returns(bytes memory){
        return abi.encodePacked(a,b);
    }
    function bytesConcate() external pure returns(bytes memory){
        return bytes.concat(bytes1(a),bytes32(b));
    }
} 



// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;
contract EncodeStringData{
    string constant a="Ram";
    string constant b="Shyam";
    function encode() external pure returns(bytes memory){
        return abi.encode(a,b);
    }
    function encodePacked() external pure returns(bytes memory){
        return abi.encodePacked(a,b);
    }
    function bytesConcate() external pure returns(bytes memory){
        return bytes.concat(bytes(a),bytes(b));
    }
} 


pragma solidity ^0.8.16;

interface IERC20 {
    function transfer(address, uint) external;
}

contract Token {
    function transfer(address, uint) external {}
}

contract AbiEncode {
    function test(address _contract, bytes calldata data) external {
        (bool ok, ) = _contract.call(data);
        require(ok, "call failed");
    }

    function encodeWithSignature(address to, uint amount)
        external
        pure
        returns (bytes memory)
    {
        // Typo is not checked - "transfer(address, uint)"
        return abi.encodeWithSignature("transfer(address,uint256)", to, amount);
    }

    function encodeWithSelector(address to, uint amount)
        external
        pure
        returns (bytes memory)
    {
        // Type is not checked - (IERC20.transfer.selector, true, amount)
        return abi.encodeWithSelector(IERC20.transfer.selector, to, amount);
    }

    function encodeCall(address to, uint amount) external pure returns (bytes memory) {
        // Typo and type errors will not compile
        return abi.encodeCall(IERC20.transfer, (to, amount));
    }
}

