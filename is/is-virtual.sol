// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Animal {
    // virtual: 表示函数可以被子合约重写。
    function speak() public pure virtual returns (string memory) {
        return "Animal speaks";
    }
}

contract Dog is Animal {
    // override 表示重写父类函数
    function speak() public pure override returns (string memory) {
        return "Dog barks";
    }
}
