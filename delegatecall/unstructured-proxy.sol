// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 非结构化代理实现

contract Logic {
    uint public count;

    function inc() external {
        count += 1;
    }
}

contract UnStructuredProxy {
    // 用于存储逻辑合约地址的 slot 逻辑合约地址的存储位置 (logicPosition)：
    bytes32 private constant logicPosition = keccak256("org.zeppelinos.proxy.implementation");

    // 升级逻辑合约地址
    function upgradeTo(address newLogic) public {
        setLogic(newLogic);
    }

    // 获取当前逻辑合约地址
    function logic() public view returns (address impl) {
        bytes32 position = logicPosition;
        assembly {
            impl := sload(position)
        }
    }

    // 设置逻辑合约地址（内部方法）
    function setLogic(address newLogic) internal {
        bytes32 position = logicPosition;
        assembly {
            sstore(position, newLogic)
        }
    }

    // fallback 函数：将调用委托给逻辑合约(所有不匹配函数签名的调用都通过 fallback() 被代理到逻辑合约)
    fallback() external payable {
        address impl = logic();
        require(impl != address(0), "Logic contract address is not set");

        assembly {
            // 将 calldata 复制到内存中
            calldatacopy(0, 0, calldatasize())

            // 使用 delegatecall 调用逻辑合约 实现代理
            let result := delegatecall(gas(), impl, 0, calldatasize(), 0, 0)

            // 复制返回数据到内存
            returndatacopy(0, 0, returndatasize())

            // 根据调用结果决定是 revert 还是 return
            switch result
            case 0 { revert(0, returndatasize()) }
            default { return(0, returndatasize()) }
        }
    }

    receive() external payable {} // 接收ETH
}
