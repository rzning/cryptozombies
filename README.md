# cryptozombies

Learn Solidity @ <https://cryptozombies.io/>

加密僵尸 CryptoZombies 学习记录。

## Timeline

- 2021-05-25 - 使用 Truffle 初始化项目 : `npx truffle init`
- 2021-05-30 - 完成第 1 课，创建 ZombieFactory 僵尸工厂智能合约。
- 2021-06-20 - 完成第 2 课，创建 ZombieFeeding 僵尸猎食智能合约。

## Truffle

> - [Truffle Quickstart - Truffle Suite Documentation](https://www.trufflesuite.com/docs/truffle/quickstart)
> - [Truffle Commands - Truffle Suite Documentation](https://www.trufflesuite.com/docs/truffle/reference/truffle-commands)

```sh
# 初始化新项目
$ npx truffle init
$ npx truffle init --force

# 下载指定的 Truffle Box
$ npx truffle unbox <box-name>

# 编译合约
$ truffle compile

# 部署合约
$ truffle migrate

# 启动基本交互式控制台，可以连接到任意指定的以太坊网路
$ truffle console

# 启动开发交互式控制台，默认在本地启动一个模拟以太坊环境
$ truffle develop
```
