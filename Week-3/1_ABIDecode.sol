// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

/*
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract Decode{
    uint8 public constant a=9;
    uint public constant b=10;

    function decode(bytes calldata data) external pure returns(uint8,uint){
        return abi.decode(data,(uint8,uint));
    }

    function decodePacked(bytes calldata data) external pure returns(uint8 x,uint y) {
        x=uint8(bytes1(data));
        y=uint(bytes32(data[1:]));
    }
}
*/


contract AbiDecode {
    struct MyStruct {
        string name;
        uint[2] nums;
    }

    function encode(
        uint x,
        address addr,
        uint[] calldata arr,
        MyStruct calldata myStruct
    ) external pure returns (bytes memory) {
        return abi.encode(x, addr, arr, myStruct);
    }

    function decode(bytes calldata data)
        external
        pure
        returns (
            uint x,
            address addr,
            uint[] memory arr,
            MyStruct memory myStruct
        )
    {
        // (uint x, address addr, uint[] memory arr, MyStruct myStruct) = ...
        (x, addr, arr, myStruct) = abi.decode(data, (uint, address, uint[], MyStruct));
    }
}
