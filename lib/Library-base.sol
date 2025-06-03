// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 所有 internal 的库函数在编译时会被嵌入使用它的合约中，因此不需要部署库。
 
// 如果你想让库函数在多个合约间共享，可以将函数标记为 public 或 external
// ，但这通常需要显式部署库并链接（不推荐，除非你要复用部署好的库）。
library MathLib {
    function addOne(uint256 x) internal pure returns (uint256) {
        return x + 1;
    }

    function square(uint256 x) internal pure returns (uint256) {
        return x * x;
    }
}
