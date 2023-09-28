// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

contract Enum {
   
    // Enum :- Enums restrict a variable to have one of only a few predefined values. 
    //The values in this enumerated list are called enums.
    // Enum representing shipping status
    enum Status {
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }

    // Default value is the first element listed in
    // definition of the type, in this case "Pending"
    Status public status;

    // Returns uint
    // Pending  - 0
    // Shipped  - 1
    // Accepted - 2
    // Rejected - 3
    // Canceled - 4
    function get() public view returns (Status) {
        return status;
    }

    // Update status by passing uint into input
    function set(Status _status) public {
        status = _status;
    }

    // You can update to a specific enum like this
    function cancel() public {
        status = Status.Canceled;
    }

    // delete resets the enum to its first value, 0
    function reset() public {
        delete status;
    }
}



//Declaring and importing Enum File that the enum is declared in 
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
// This is saved 'EnumDeclaration.sol'

enum Status {
    Pending,
    Shipped,
    Accepted,
    Rejected,
    Canceled
}



//File that imports the enum above
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./EnumDeclaration.sol";

contract Enum {
    Status public status;
}
