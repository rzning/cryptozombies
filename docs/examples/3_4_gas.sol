// SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

/**
 * @notice 结构封装示例
 * @dev 使用 Struct Packing 减少 Gas 消耗
 */

contract StructPackingExample {
    /**
     * @notice 普通结构
     */
    struct NormalStruct {
        uint256 a;
        uint256 b;
        uint256 c;
    }

    /**
     * @notice 迷你结构
     */
    struct MiniStruct {
        uint32 a;
        uint32 b;
        uint256 c;
    }

    // `mini` will cost less gas than `normal` because of struct packing
    // 由于使用了结构封装，因此 mini 比 mormal 消耗更少的 Gas
    NormalStruct normal = NormalStruct(10, 20, 30);
    MiniStruct mini = MiniStruct(10, 20, 30);
}
