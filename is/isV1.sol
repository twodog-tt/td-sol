// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract A {
    function getValue() public pure virtual returns (string memory) {
        return "A";
    }
}

contract B is A {
    function getValue() public pure virtual override returns (string memory) {
        return "B";
    }
}

contract C is A {
    function getValue() public pure virtual override returns (string memory) {
        return "C";
    }
}

contract D is B, C {
    function getValue() public pure override(B, C) returns (string memory) {
        return super.getValue(); // 会调用 C 的 getValue，因为 C 在继承列表中靠后
        // 遵循继承顺序 D -> C -> B -> A，优先调用靠后的 C。
    }
}
