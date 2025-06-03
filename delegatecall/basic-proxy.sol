// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 负责业务逻辑（功能实现）
contract LogicV1 {
    address public logic; // 虽然定义了这个变量，但实际上没用到（通常这是用在代理合约中的，这里是冗余的）。
    uint256 public count; // 存储一个计数器。

    // 外部调用函数，每调用一次 count + 1。
    function inc() external {
        count += 1;
    }
}


// 负责业务逻辑（功能实现）
contract LogicV2 {
    address public logic; // 虽然定义了这个变量，但实际上没用到（通常这是用在代理合约中的，这里是冗余的）。
    uint256 public count; // 存储一个计数器。

    // 外部调用函数，每调用一次 count + 1。
    function inc() external {
        count += 2;
    }
}

interface LogicInterce {
    function inc() external;
}

contract Proxy {
    // Proxy 合约中定义了 logic 和 count，顺序和 Logic 一致，这是 delegatecall 成功工作的前提。
    // delegatecall 会把执行上下文转到 Logic，但使用 Proxy 合约的存储，因此它们的变量布局必须一致！
    address public logic;
    uint256 public count;
    // 事件 DelegateCallResult 用于记录 delegatecall 的执行状态，方便调试。
    event DelegateCallResult(bool success, bytes data); // event表示事件

    constructor(address _logic) {
        logic = _logic;
    }

    // 是一个特殊函数，在未匹配到其他函数签名时调用（比如调用 inc()）
    // 使用 delegatecall 将函数调用转发到 Logic。
    fallback() external {
        // delegatecall(msg.data) 的含义是：把当前调用的数据原封不动地传给 logic 合约执行
        // ，但上下文（msg.sender 和 storage）仍然是 Proxy 合约。
        // 所以调用 proxy.inc() 实际上执行的是 Logic.inc()，但改变的是 Proxy.count。
        (bool ok, bytes memory res) = logic.delegatecall(msg.data);
        emit DelegateCallResult(ok, res); // emit表示触发事件
        require(ok, "delegatecall failed");
    }

    // 添加升级函数
    function updateTo(address newVersion) external {
        logic = newVersion;
    }
}
