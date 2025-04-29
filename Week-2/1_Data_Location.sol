/*
 - Variables are declared as either storage, memory or calldata to explicitly specify the location of the data.

 1. storage - variable is a state variable (store on blockchain)
 2. memory - variable is in memory and it exists while a function is being called
 3. calldata - special data location that contains function arguments

1. storage
 - It can be used for both function declaration parameters as well as within the function logic
 - It is mutable (it can be overwritten and changed)
 - It is persistent (the value persists on the blockchain)

2. memory
 - It can be used for both function declaration parameters as well as within the function logic
 - It is mutable (it can be overwritten and changed)
 - It is non-persistent (the value does not persist after the transaction has completed)


3. callData
 - It can only be used for function declaration parameters (and not function logic)
 - It is immutable (it can't be overwritten and changed)
 - It must be used for dynamic parameters of an external function
 - It is non-persistent (the value does not persist after the transaction has completed)
*/



// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract DataLocations {
    uint256[] public arr;
    mapping(uint256 => address) map;
    struct MyStruct {
        uint256 foo;
    }
    mapping(uint256 => MyStruct) myStructs;

    function f() public {
        // call _f with state variables
        _f(arr, map, myStructs[1]);

        // get a struct from a mapping
        MyStruct storage myStruct = myStructs[1];
        // create a struct in memory
        MyStruct memory myMemStruct = MyStruct(0);
    }

    function _f(
        uint256[] storage _arr,
        mapping(uint256 => address) storage _map,
        MyStruct storage _myStruct
    ) internal {
        // do something with storage variables
    }

    // You can return memory variables
    function g(uint256[] memory _arr) public returns (uint256[] memory) {
        // do something with memory array
    }

    function h(uint256[] calldata _arr) external {
        // do something with calldata array
    }
}

contract Test {
    string stringTest;

    function memoryTest(string memory _exampleString)
        public
        pure
        returns (string memory)
    {
        // You can modify memory
        _exampleString = "example"; 
        // You can use memory within a function's logic
        string memory newString = _exampleString; 
        return newString; 
    }

    function calldataTest(string calldata _exampleString)
        external
        pure
        returns (string memory)
    {
        // cannot modify _exampleString, but can return it
        return _exampleString;
    }
}
