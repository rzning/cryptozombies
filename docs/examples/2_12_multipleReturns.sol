// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

/**
 * @notice 处理函数的多返回值示例
 */
contract MyContract {
    function multipleReturns()
        internal
        pure
        returns (
            uint256 a,
            uint256 b,
            uint256 c
        )
    {
        return (1, 2, 3);
    }

    function processMultipleReturns() external pure {
        uint256 a;
        uint256 b;
        uint256 c;

        // 以此种方式实现批量赋值
        (a, b, c) = multipleReturns();
    }

    /**
     * @notice 返回其中一个变量
     */
    function getLastReturnValue() external pure {
        uint256 c;

        // 可以对其他字段留空
        (, , c) = multipleReturns();
    }
}
