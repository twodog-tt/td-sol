// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

// ✅ 反转字符串 (Reverse String),
// 题目描述：反转一个字符串。输入 "abcde"，输出 "edcba"

contract Reverse {

    // 主函数：反转输入字符串
    
    /*
    string 是 Solidity 中的动态 UTF-8 字符串；

    不能直接使用下标访问 string，必须先转换为 bytes；

    bytes 数组可以逐个访问、赋值、拷贝；

    函数使用 pure 修饰，因为它不读取或修改区块链状态。
    */
    function reverseString(string memory input) public pure returns (string memory) {
        bytes memory inputBytes = bytes(input); // 转为 bytes 便于操作
        uint length = inputBytes.length;
        bytes memory reversed = new bytes(length); // 新建空的 bytes 数组

        for (uint i = 0; i < length; i++) {
            reversed[i] = inputBytes[length - 1 - i]; // 从后往前赋值
        }

        return string(reversed); // 转回 string 返回
    }


}