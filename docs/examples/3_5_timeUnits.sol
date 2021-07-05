// SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

/**
 * @notice 时间操作示例
 */

contract TimeUnitsExample {
    uint256 lastUpdated;

    /**
     * @notice 更新最后更新时间
     * @dev 将 lastUpdated 更新为当前时间
     * @dev 通过 block.timestamp 返回当前时间，变量 now 已经弃用。
     */
    function updateTimestamp() public {
        lastUpdated = block.timestamp;
    }

    /**
     * @notice 距离上次更新是否超过 5 分钟
     */
    function fiveMinutesHavePassed() public view returns (bool) {
        return (block.timestamp >= (lastUpdated + 5 minutes));
    }
}
