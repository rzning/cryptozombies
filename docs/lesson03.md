# Lesson 3: Advanced Solidity Concepts

高级 Solidity 概念

- <https://cryptozombies.io/en/lesson/3>

## Chapter 1: Immutability of Contracts

> 3.1 智能合约的永固性

- 部署到以太坊的智能合约将不可更改 ( immutable ) ，这意味着其代码永远不能再被修改或更新。
- 你部署到合约中的初始代码将永久保留在区块链上，这就是为什么安全问题是一个非常重要的问题。
- 一旦你的合约代码中有一个漏洞，你也不可能在后续修补它。
  你必须告诉你的用户放弃当前合约，然后转移到一个新的修复后的合约地址。
- 这也是智能合约的一个特点。代码说明一切，一旦函数确定下来，
  每次调用都回严格按照原有的逻辑执行，不必担心被人篡改得到意外结果。

外部依赖关系：

- 在上一课中我们将 CryptoKitties 合约的地址硬编码到 DApp 中了。
  如果 CryptoKitties 出了点儿问题，访问不到小猫信息了，我们的 DApp 也会随之失效。
- 因此对于外部依赖，我们尽量使其参数化，并可以通过函数去修改。

## Chapter 2: Ownable Contracts

> 3.2 合约所有权

- 上一章添加的修改 CryptoKitties 合约地址方法为外部函数，任意账户都可以调用，存在安全隐患。
- 引入 OpenZeppelin 的 Ownable 合约，给函数添加所有权修饰符，使其只有所有者才能调用。

## Chapter 3: onlyOwner Function Modifier

> 3.3 函数修饰符

- 使用 `modifier` 关键字定义函数修饰符
- 修饰符中的 `_;` 语句用于调用被修饰函数内容。

示例代码 [3_3_modifier.sol](./examples/3_3_modifier.sol)

## Chapter 4: Gas

> 3.4 Gas

- Gas 是以太坊 DApps 得以运行的燃料。
- 在以太坊中，用户每次想要执行你的 DApps 都需要支付一定的 Gas 。
- Gas 需要使用以太币 ( Ether ) 购买，因此用户每次运行 DApps 中的函数，都必须付费以太币。
- 执行一个函数需要多少 Gas 取决于该函数的逻辑复杂度。
- 由于运行函数对用户来说要花费真金白银，所以为避免给用户带来不必要的开销，代码优化在以太坊中显得非常重要。

为什么要用 Gas 来驱动：

- 以太坊就像一台大型、运行缓慢、但非常安全的计算机。
- 当你运行一个函数时，网络上的每个节点都需要执行相同的函数来验证其输出，
  这就是所谓的去中心化，可以确保数据不被监控，或者刻意篡改。
- 为确保不会有人用无限循环堵塞网络，或者使用密集运算独占所有网络资源，
  以太坊设计者为以太坊上的资源定制了价格，用户必须为计算时间和存储空间付费。
- 有些侧链不一定需要付费。

使用结构封装 ( Struct Packing ) 节省 Gas 消耗：

- `uint` 有 `uint8` , `uint16` , `uint32` 等变种。
- 直接使用这些子类型没有什么好处，因为无论 `uint` 的大小如何定义， Solidity 都为其保留 256 位的存储空间。
- 例如，使用 `uint8` 来代替 `uint256` 并不会节省任何 Gas 消耗。
- 除非，把 `uint8` 绑定到 `struct` 里面。
- 如果在一个 `struct` 中有多个 `uint` ，在可能的情况下尽量使用较小尺寸的 `uint` ，
  Solidity 会将这些变量打包在一起，以占用更少的存储空间。

示例代码 [3_4_gas.sol](./examples/3_4_gas.sol)

- 当 `uint` 定义在一个 `struct` 中时，尽量使用最小的整数子类型以节省空间。
- 并且尽量把同一类型的变量放在一起（ Solidity 会将结构体中的变量依次放置），这样可以将存储空间最小化。
- 例如包含下面字段的两个结构体，前者比后者消耗更少的 Gas ：
  - `uint c; uint32 a; uint32 b;`
  - `uint32 a; uint c; uint32 b;`

## Chapter 5: Time Units

> 3.5 时间单位

- Solidity 使用变量 `block.timestamp` 返回当前 Unix 时间戳。

  - Unix 时间传统使用一个 32 位整数进行存储，这将导致 2038 年问题。
  - 也可以使用 64 位整数表示时间，但为此我们的用户不得不效果更多的 Gas 来使用 DApps 。

- Solidity 包含以下时间单位，它们都会转换为对应的秒数存放到 `uint` 中：

  - `seconds` - 秒
  - `minutes` - 分钟 `1 minutes = 60`
  - `hours` - 小时 `1 hours = 3600` （60 × 60）
  - `days` - 天 `1 days = 86400` （24 × 60 × 60）
  - `weeks` - 周
  - `years` - 年

示例代码 [3_5_timeUnits.sol](./examples/3_5_timeUnits.sol)
