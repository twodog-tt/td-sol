// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 定义接口合约,接口是不能部署的。
interface ICallee {
    function setx(uint256 _x) external;
}
