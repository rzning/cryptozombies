// SPDX-License-Identifier: MIT
pragma solidity ^0.8.5;

/**
 * @title 僵尸工厂
 * @notice 创建工厂函数用来生成僵尸，并将它们放入区块链上的僵尸数据库中。
 */
contract ZombieFactory {
    // 1.13 事件
    /// @notice 事件是合约和区块链通信的一种机制。
    // 前端应用可以监听指定事件，并作出反应。

    /// @dev 新增僵尸事件，创建新僵尸时触发
    event NewZombie(uint256 zombieId, string name, uint256 dna);

    // 1.3 状态变量和整数
    /// @notice 状态变量将被永久保存在合约中。
    // 也就是说它们被写入以太坊区块链中，可以类比成写入一个数据库。

    /// @dev 定义一个无符号整数，代表僵尸 DNA 的位数
    uint256 dnaDigits = 16;
    /// @dev 僵尸 DNA 位数模量
    uint256 dnaModulus = 10**dnaDigits;

    // 1.5 定义结构体
    /// @notice 字符串 string 类型用于保存任意长度的 UTF-8 编码数据。

    /// @dev 定义僵尸结构体
    struct Zombie {
        // 僵尸名字
        string name;
        // 僵尸基因
        uint256 dna;
    }

    // 1.6 数组
    /// @notice 如果项想建立一个集合，可以使用 数组 数据类型。
    // Solidity 支持两种数组：静态数组和动态数组。
    // uint[2] fixedArray; // 固定长度为 2 的静态数组
    // string[5] stringArray; // 固定长度为 5 的 string 类型的静态数组
    // uint[] dynamicArray; // 动态数组，长度不固定，可以动态添加元素

    /// @notice 变量声明 public 类型， Solidity 会自动创建 getter 方法。
    // 其他合约可以读取 public 变量，但不能写入修改数据。

    /// @dev 定义一个僵尸结构体数组，用于存放僵尸部队
    Zombie[] public zombies;

    // 2.2 映射 ( Mapping ) 和地址 ( Address )
    /// @notice 以太坊区块链使用地址指向于特定的用户或智能合约。
    // 映射表示存储和查找数据所用的键值对。

    // 通过给数据库中的僵尸指定“主人”，来支持“多玩家”模式。
    // 为存储僵尸的所有权，定义两个映射：
    /// @dev 记录僵尸拥有者的地址
    mapping(uint256 => address) public zombieToOwner;
    /// @dev 记录指定地址所拥有的僵尸数量
    mapping(address => uint256) ownerZombieCount;

    // 1.7 定义函数
    /// @notice 习惯上函数内部变量使用下划线 _ 开头，以区别全局变量。
    // 1.9 私有/公共函数
    /// @notice Solidity 定义的函数默认为 public 公共的。
    // 将内部函数定义为 private 私有的是一个好的编程习惯。

    // 2.9 更多关于函数的可见性： internal 和 external
    /// @dev 将 _createZombie 方法改为 internal 的，以供子合约调用。

    /**
     * @dev 创建僵尸
     */
    function _createZombie(string memory _name, uint256 _dna) internal {
        // 1.8 使用结构体和数组
        /// @dev 创建一个 Zombie 僵尸实例，并加入 zombies 数组中
        zombies.push(Zombie(_name, _dna));

        /// @dev 取新增僵尸在数组中的索引作为 ID 标识。
        uint256 id = zombies.length - 1;

        // 2.3 Solidity 全局变量 msg.sender
        /// @notice Solidity 中的全局变量可以被所有函数调用。
        // 其中 msg.sender 表示当前调用者的 address 。
        // 合约函数的执行始终需要从外部调用者发起，所以 msg.sender 总是存在的。

        /// @dev 记录僵尸拥有者
        zombieToOwner[id] = msg.sender;
        /// @dev 拥有者的僵尸数量加 1
        ownerZombieCount[msg.sender]++;

        /// @dev 触发新增僵尸事件
        emit NewZombie(id, _name, _dna);
    }

    // 1.10 函数的返回值和修饰符
    /// @notice view 修饰符标识函数只能读取数据不能写入数据。
    // pure 修饰符标识函数既不能写入也不能读取状态变量，它的返回值完全取决于入参。

    /**
     * @dev 根据指定字符串随机生成一个 DNA 数据
     */
    function _generateRandomDna(string memory _str) private view returns (uint256) {
        // 1.11 散列函数
        /// @notice Ethereum 内部散列函数 keccak256(x) 将一个字符串转换为一个 256 位的 16 进制数。
        // 有时需要对数据进行强制类型转换： uint8 b = unit8(a);

        /// @dev 生成伪随机十六进制数
        uint256 rand = uint256(keccak256(abi.encode(_str)));
        return rand % dnaModulus;
    }

    // 1.12 工厂函数
    /**
     * @dev 传入名字创建随机僵尸
     */
    function createRandomZombie(string memory _name) public {
        // 2.4 Require
        /// @notice Solidity 不支持原生字符串比较，只能通过比较两个字符串的 keccak256 哈希值来进行判断：
        // require(keccak256(_name) == keccak256("Vitalik"));
        /// @notice mapping 中值为 uint 类型时，未找到对应条目将返回 0 值。

        /// @dev 限制每个用户只能自主创建一个僵尸
        require(ownerZombieCount[msg.sender] == 0);

        uint256 randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
}
