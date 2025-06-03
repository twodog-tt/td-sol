// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library CounterLib {
    struct Counter {
        uint256 value;
    }

    function increment(Counter storage c) internal {
        c.value += 1;
    }

    function current(Counter storage c) internal view returns (uint256) {
        return c.value;
    }
}

contract MyCounter {
    using CounterLib for CounterLib.Counter;
    CounterLib.Counter private counter;

    function inc() public {
        counter.increment(); // 使用库函数
    }

    function current() public view returns (uint256) {
        return counter.current();
    }
}
