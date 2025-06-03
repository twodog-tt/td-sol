// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "lib/Library-base.sol";

contract UseLibraryV1 {

    // 此时为全局绑定
    using MathLib for uint256; // 让 uint256 类型拥有 MathLib 中定义的函数，调用语法变成 x.addOne()。

    function testAddOne(uint256 x) public pure returns (uint256) {
        return x.addOne(); // 相当于 MathLib.addOne(x)
    }

    function testSquare(uint256 x) public pure returns (uint256) {
        return x.square(); // 相当于 MathLib.square(x)
    }
}

