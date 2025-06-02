// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// contract Gas {
//     uint256 public i = 0;

//     function forever() public {
//         while (true) {
//             i += 1;
//         }
//     }
// }

// transact to gas.forever pending ...
// transact to gas.forever errored: Error occurred: out of gas. (gas耗尽)
// out of gas
// The transaction ran out of gas. Please increase the Gas Limit.
// You may want to cautiously increase the gas limit if the transaction went out of gas.

contract Gas1 {
    uint256 public i = 0;
    uint256 public remained;

    function forever() public {
        while (true) {
            if (i > 100) {
                return;
            }
            if (i == 20) {
                remained = gasleft(); // 记录剩余gas
            }
            i += 1;
        }
    }
}

// contract GasCaller {
//     Gas1 gas;

//     constructor(Gas1 _gas) {
//         gas = _gas;
//     }

//     function callForever() public {
//         gas.forever{gas: 200000}();
//     }
// }

// contract GasCaller1 {
//     address gas;

//     constructor(address _gas) {
//         gas = _gas;
//     }

//     function callForever() public {
//         bytes memory cd = abi.encodeWithSignature("forever()");
//          (bool success, ) = gas.call{gas: 100000}(cd);
//          require(success, "Call to gas.forever() failed");
//         // transact to GasCaller1.callForever errored: Error occurred: revert.
//         // revert
//         // 	The transaction has been reverted to the initial state.
//         // Reason provided by the contract: "Call to gas.forever() failed".
//         // If the transaction failed for not having enough gas, try increasing the gas limit gently.
//     }
// }

contract GasCaller2 {
    address gas;

    constructor(address _gas) {
        gas = _gas;
    }

    function callForever() public {
        bytes memory cd = abi.encodeWithSignature("forever()");
        (bool success, ) = gas.call{gas: gasleft() - 1000}(cd);
        require(success, "Call to gas.forever() failed");
    // transact to GasCaller2.callForever errored: Error occurred: revert.
    // revert
	// The transaction has been reverted to the initial state.
    // Reason provided by the contract: "Call to gas.forever() success".
    // If the transaction failed for not having enough gas, try increasing the gas limit gently.
    }
}