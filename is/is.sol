// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract A {
    function sayHello() public pure virtual returns (string memory) {
        return "Hello from A";
    }
}

contract B {
    function sayHello() public pure virtual returns (string memory) {
        return "Hello from B";
    }
}

contract C is A, B {
    // 需要重写 sayHello()，并指明使用哪个父合约的实现
    // 当多个父合约中有同名函数时，子合约必须使用 override(A, B) 显式说明要重写，并指定优先顺序。
    function sayHello() public pure override(A, B) returns (string memory) {
        return A.sayHello(); // 显式指定使用 A 的实现
    }
}
