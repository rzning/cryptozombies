// SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

import "./ZombieFactory.sol";
import "./KittyInterface.sol";

// 2.5 继承 ( Inheritance )

/**
 * @title 僵尸猎食
 * @notice 实现僵尸的“猎食”和“繁殖”。
 */
contract ZombieFeeding is ZombieFactory {
    // 2.11 使用接口
    /// @dev CryptoKitties 合约的地址
    // address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    /// @dev 指向 CryptoKitties 合约
    // KittyInterface kittyContract = KittyInterface(ckAddress);
    // 3.1 将外部合约地址参数化
    KittyInterface kittyContract;

    /**
     * @notice 设置 CryptoKitties 合约地址
     * @dev 3.3 添加 onlyOwner 修饰符，使其只有所有者才能调用
     */
    function setKittyContractAddress(address _address) external onlyOwner {
        kittyContract = KittyInterface(_address);
    }

    constructor() {
        // 初始化 CryptoKitties 合约地址
        address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
        kittyContract = KittyInterface(ckAddress);
    }

    // 2.7 Storage 和 Memory
    /// @notice 在 Solidity 中，变量存储在两个地方： storage 和 memory
    // - 存储 ( storage ) 变量是指永久存储在区块链中的变量。
    // - 内存 ( memory ) 变量是临时的，在外部函数对合约调用完成时，内存型变量即被移除。
    // 状态变量默认为 storage 并永久写入区块链，
    // 而在函数内部声明的变量默认是 memory 类型，在函数调用结束后消失。

    /**
     * @notice 猎食和繁殖
     * @dev 当一个僵尸猎食其他生物时，将自身 DNA 与猎食生物 DNA 结合起来生成新的僵尸 DNA 。
     * @dev 2.13 添加第三个参数 _species 来区分僵尸种类
     * @param _zombieId - 当前僵尸 ID
     * @param _targetDna - 目标猎物 DNA
     * @param _species - 僵尸品类
     */
    function feedAndMultiply(
        uint256 _zombieId,
        uint256 _targetDna,
        string memory _species
    ) public {
        // 确保只有当前僵尸的所有者才能发起猎食操作
        require(msg.sender == zombieToOwner[_zombieId]);

        /// @dev 定义 storage 类型指针，指向当前僵尸
        Zombie storage myZombie = zombies[_zombieId];

        // 2.8 生成新僵尸 DNA
        /// @dev 要确保 _targetDna 的长度不长于 16 位
        uint256 newDna = (myZombie.dna + (_targetDna % dnaModulus)) / 2;

        // 2.13 我们目前只使用了 16 位 DNA 的前 12 位数字，
        // 现在可以使用最后两位数字来处理特殊的特征。
        // 这里将最后两位数字设定为 99 来代表这个僵尸是从 Kitty 变来的。
        if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
            newDna = newDna - (newDna % 100) + 99;
        }

        // 生成新僵尸
        _createZombie("Anonym", newDna);
    }

    // 2.12 与 CryptoKitties 合约交互

    /**
     * @notice 猎食 Kitty 生成新的僵尸
     */
    function feedOnKitty(uint256 _zombieId, uint256 _kittyId) public {
        uint256 kittyDna;

        // 从 Kitty 合约中获取它的基因
        (, , , , , , , , , kittyDna) = kittyContract.getKitty(_kittyId);

        feedAndMultiply(_zombieId, kittyDna, "kitty");
    }
}
