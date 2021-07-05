// SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

/**
 * @notice 函数修饰符示例
 */

contract Ownable {
    address private _owner;

    constructor() {
        _owner = msg.sender;
    }

    /**
     * @notice 只允许所有者调用
     * @dev 使用 modifier 关键字定义函数修饰符
     */
    modifier onlyOwner() {
        require(msg.sender == _owner);
        _;
    }
}

contract MyContract is Ownable {
    event Laugh(string laugher);

    /**
     * @dev 使用函数修饰符
     */
    function victory() external onlyOwner {
        emit Laugh("hero");
    }
}
