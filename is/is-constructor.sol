// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 父合约 A，有构造函数
contract A {
    string public nameA;

    constructor(string memory _nameA) {
        nameA = _nameA;
    }
}

// 父合约 B，有构造函数
contract B {
    string public nameB;

    constructor(string memory _nameB) {
        nameB = _nameB;
    }
}

// 子合约 C，继承 A 和 B
contract C is A, B {
    // 所有父合约的构造函数都必须显式调用
    // 构造顺序是按继承列表从左到右调用的，与构造函数中调用顺序无关。当前函数 先A后B
    constructor(string memory _nameA, string memory _nameB)
        A(_nameA)        // 显式调用 A 的构造函数
        B(_nameB)        // 显式调用 B 的构造函数
    {}

    // 方便测试
    function getNames() external view returns (string memory, string memory) {
        return (nameA, nameB);
    }
}
