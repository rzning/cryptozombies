# Lesson 2: Zombies Attack Their Victims

僵尸攻击它们的受害者

- <https://cryptozombies.io/zh/lesson/2>

## Chapter 7: Storage vs Memory (Data location)

> 2.7 数据位置：存储和内存

在 Solidity 中变量有两个两个存储位置：

- `storage` 变量将永久存储在区块链上。状态变量默认在 `storage` 位置。
- `memory` 变量则是临时的。函数内部声明的变量默认在 `memory` 位置，函数调用完成后消失。

在有些形况下需要手动声明存储类型，比如处理函数内的结构体和数组时：

- 示例代码 [SandwichFactory.sol](./examples/2_7_SandwichFactory.sol)

## Chapter 9: More on Function Visibility

> 2.9 更多关于函数的可见性： internal 和 external

- `internal` 与 `private` 类似，一个合约可以调用父合约定义的 `internal` 方法。
- `external` 与 `public` 类似，只是使用 `external` 声明的函数只能在合约外部调用，不能被合约内其他函数调用。

## Chapter 10: Interacting with other contracts

> 2.10 与其他合约交互

如果合约需要和区块链上的其他合约会话，则需要先定义一个接口 ( Interface ) 。

比如区块链上的一个合约：

```solidity
contract LuckyNumber {
  mapping(address => uint256) numbers;

  function setNum(uint256 _num) public {
    numbers[msg.sender] = _num;
  }

  function getNum(address _myAddress) public view returns (uint256) {
    return numbers[_myAddress];
  }
}

```

定义 LuckyNumber 合约的接口：

```solidity
interface NumberInterface {
  function getNum(address _myAddress) external view returns (uint256);
}

```

> 2.11 使用接口

```solidity
contract MyContract {
  address NumberInterfaceAddress = 0xab38...;
  // ^ 这是 LuckyNumber 合约在以太坊上的地址
  NumberInterface numberContract = NumberInterface(NumberInterfaceAddress);

  // 现在变量 `numberContract` 指向另一个合约对象

  function someFunction() public {
    // 现在我们可以调用在那个合约中声明的 `getNum`函数:
    uint256 num = numberContract.getNum(msg.sender);
    // ...在这儿使用 `num` 变量做些什么
  }
}

```

只要将合约的可见性设置为 `public` 或 `external` 的，它们就可以与以太坊区块链上的其他任何合约进行交互。

## Chapter 12: Handling Multiple Return Values

> 2.12 处理多返回值

- 示例代码 [multipleReturns.sol](./examples/2_12_multipleReturns.sol)

## Chapter 14: Wrapping It Up

> 2.14 使用 JavaScript 和 web3.js 与部署的 ZombieFeeding 合约进行交互：

- 示例代码 [2_14_interact.js](./examples/2_14_interact.js)
