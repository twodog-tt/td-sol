// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

// ✅ 创建一个名为Voting的合约，包含以下功能：,
// 一个mapping来存储候选人的得票数,
// 一个vote函数，允许用户投票给某个候选人,
// 一个getVotes函数，返回某个候选人的得票数,
// 一个resetVotes函数，重置所有候选人的得票数.

contract voliting{
    // 候选人票数映射
    mapping(string => uint256) private votes;
    // 候选人列表
    string[] private candidates;
    // 管理员地址（只有管理员可以重置票数）
    address public owner;

    // 构造函数，在部署时自动执行
    // string[] memory _candidates 部署时传入候选人名称列表，放在内存中处理（memory）。
    // owner = msg.sender;: 设置合约的管理员为部署者的地址。

    constructor(string[] memory _candidates) {
        owner = msg.sender; // msg 是 Solidity 内建的环境对象，由 EVM 提供；
        candidates = _candidates;
        for (uint i = 0; i < _candidates.length; i++) {
            votes[_candidates[i]] = 0; // 初始化每位候选人的票数为 0。
        }
    }

    // 投票给指定候选人
    function vote(string memory candidate) public {
        require(validCandidate(candidate), "Invalid candidate"); // 条件检查，如果候选人非法，则终止执行并返回错误消息。
        votes[candidate]++;
    }

    // 查询指定候选人的得票数
    // public view: 表示这个函数不会修改区块链状态，因此是只读的。
    function getVotes(string memory candidate) public view returns (uint256) {
        require(validCandidate(candidate), "Invalid candidate"); // require(...): 确保传入的是合法候选人
        return votes[candidate];
    }

    // 重置所有候选人的得票数（仅管理员）
    function resetVotes() public {
        require(msg.sender == owner, "Only owner can reset votes"); // require(msg.sender == owner, ...): 只有部署者（管理员）可以执行此函数。
        for (uint i = 0; i < candidates.length; i++) {
            votes[candidates[i]] = 0;
        }
    }

    // 判断候选人是否合法
    // internal view: 只能在合约内部调用，且不修改状态。
    function validCandidate(string memory name) internal view returns (bool) {
        for (uint i = 0; i < candidates.length; i++) {
            if (keccak256(bytes(candidates[i])) == keccak256(bytes(name))) {
                return true;
            }
        }
        return false;
    }

    // 获取所有候选人（便于前端使用）
    function getAllCandidates() public view returns (string[] memory) {
        return candidates;
    }
}