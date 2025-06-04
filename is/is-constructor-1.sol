// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract A {
    function who() public pure virtual returns (string memory) {
        return "A";
    }
}

contract B is A {
    function who() public pure virtual override returns (string memory) {
        return "B";
    }
}

contract C is A {
    function who() public pure virtual override returns (string memory) {
        return "C";
    }
}

contract D is B, C {
    function who() public pure override(B, C) returns (string memory) {
        return "D";
    }
}
