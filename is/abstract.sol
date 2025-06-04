// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract Shape {
    function area() public view virtual returns (uint256);
}

contract Square is Shape {
    uint256 side;

    constructor(uint256 _side) {
        side = _side;
    }

    function area() public view override returns (uint256) {
        return side * side;
    }
}
