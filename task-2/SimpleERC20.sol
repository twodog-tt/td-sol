// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleERC20 {
    // 代币基本信息
    string public name; // 代币名称
    string public symbol; // 代币符号
    uint8 public constant decimals = 18; // 小数位数，通常为18
    uint256 public totalSupply; // 总供应量
    
    // 合约所有者
    address public owner;
    
    // 余额和授权存储
    mapping(address => uint256) private _balances; // 地址到余额的映射
    mapping(address => mapping(address => uint256)) private _allowances; // 嵌套映射，记录一个地址授权给另一个地址的额度（owner => (spender => amount)）
    
    // 事件定义
    event Transfer(address indexed from, address indexed to, uint256 value); // 在转账（包括铸造和转账）时触发
    event Approval(address indexed owner, address indexed spender, uint256 value); // 在授权时触发
    
    // 权限修饰器  使用 onlyOwner 修饰器，确保只有所有者可以调用mint
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }
    
    // 构造函数：初始化代币(代币名称、符号、小数位)
    constructor(string memory _name, string memory _symbol, uint256 initialSupply) {
        name = _name;
        symbol = _symbol;
        owner = msg.sender;
        _mint(msg.sender, initialSupply * (10 ** uint256(decimals)));
    }
    
    // 查询余额
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }
    
    // 转账功能
    function transfer(address to, uint256 amount) public returns (bool) {
        require(to != address(0), "Transfer to zero address");
        require(_balances[msg.sender] >= amount, "Insufficient balance");
        
        _balances[msg.sender] -= amount;
        _balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }
    
    // 授权功能
    function approve(address spender, uint256 amount) public returns (bool) {
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }
    
    // 查询授权额度
    function allowance(address _owner, address spender) public view returns (uint256) {
        return _allowances[_owner][spender];
    }
    
    // 代扣转账
    function transferFrom(address from, address to, uint256 amount) public returns (bool) {
        require(_allowances[from][msg.sender] >= amount, "Allowance exceeded");
        require(_balances[from] >= amount, "Insufficient balance");
        
        _allowances[from][msg.sender] -= amount;
        _balances[from] -= amount;
        _balances[to] += amount;
        emit Transfer(from, to, amount);
        return true;
    }
    
    // 代币增发（仅所有者）
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
    
    // 内部铸造函数
    function _mint(address to, uint256 amount) private {
        require(to != address(0), "Mint to zero address");
        totalSupply += amount;
        _balances[to] += amount;
        emit Transfer(address(0), to, amount);
    }
}