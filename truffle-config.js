/**
 *
 * 有关 Truffle 配置信息，可参考：
 *
 * https://www.trufflesuite.com/docs/truffle/reference/configuration
 *
 * 想要通过 Infura 部署，你需要在你的交易发送到远程公共节点之前，
 * 使用一个钱包供应商（比如 `@truffle/hdwallet-provider` ）对其进行签名。
 * 可免费获取 Infura 账号： https://infura.io/register
 *
 * 你还需要提供一个包含 12 个单词短语的助记符 ( mnemonic ) -- 钱包用它来生成公钥/私钥对。
 * 若你要将代码上传到 GitHub 上，请确保将助记符文件添加到 `.gitignore` 防止被意外公开。
 */

// const HDWalletProvider = require('@truffle/hdwallet-provider');
// const infuraKey = "fj4jll3k.....";
//
// const fs = require('fs');
// const mnemonic = fs.readFileSync(".secret").toString().trim();

module.exports = {
  /**
   * Networks 定义如何连接到以太坊客户端。
   * 若未设定，当你运行 `develop` 或 `test` 时将默认在 9545 端口启动一个开发区块链。
   * 你可以在执行 truffle 命令时指定使用哪个网络：
   *
   * $ truffle test --network <network-name>
   */
  networks: {
    // 用于测试。名为 `development` 的网络是特殊的，
    // 在命令行中未指定其他网路时 truffle 默认使用它。
    // 若要使用 development 网路，你需要另起一个命令行来运行一个客户端，
    // 如 ganache-cli, geth 或 parity 。
    // 你还需要将下面 `host` , `post` 和 `network_id` 指定具体的值：
    // development: {
    //  host: "127.0.0.1",     // Localhost (default: none)
    //  port: 8545,            // Standard Ethereum port (default: none)
    //  network_id: "*",       // Any network (default: none)
    // },
    //
    // 另一个有更高级选项的网路配置：
    // advanced: {
    // port: 8777,             // Custom port
    // network_id: 1342,       // Custom network
    // gas: 8500000,           // 每笔交易所需的 Gas (default: ~6700000)
    // gasPrice: 20000000000,  // 20 gwei (in wei) (default: 100 gwei)
    // from: <address>,        // 发送 txs 的账户 (default: accounts[0])
    // websocket: true        // 是否启用 web3 的 EventEmitter 接口 (default: false)
    // },
    //
    // 用于部署到一个公共网路：
    // NB: 将提供者 ( provider ) 包装为函数是很重要的。
    // ropsten: {
    // provider: () => new HDWalletProvider(mnemonic, `https://ropsten.infura.io/v3/YOUR-PROJECT-ID`),
    // network_id: 3,       // Ropsten's id
    // gas: 5500000,        // Ropsten 的区块限制比 mainnet 低
    // confirmations: 2,    // # of confs to wait between deployments. (default: 0)
    // timeoutBlocks: 200,  // # of blocks before a deployment times out  (minimum/default: 50)
    // skipDryRun: true     // Skip dry run before migrations? (default: false for public nets )
    // },
    //
    // 使用一个私有网路：
    // private: {
    // provider: () => new HDWalletProvider(mnemonic, `https://network.io`),
    // network_id: 2111,   // This network is yours, in the cloud.
    // production: true    // Treats this network as if it was a public net. (default: false)
    // }
  },

  // 设置默认的 mocha 选项，使用指定的 reporters 等。
  mocha: {
    // timeout: 100000
  },

  // 编译器选项
  compilers: {
    solc: {
      version: '0.8.5' // 从 solc-bin 中获取准确版本 (default: truffle's version)
      // docker: true,        // 使用你通过 docker 本地安装的 "0.5.1" (default: false)
      // settings: {          // 关于优化和 evmVersion 的建议，请参考 Solidity 文档
      //  optimizer: {
      //    enabled: false,
      //    runs: 200
      //  },
      //  evmVersion: "byzantium"
      // }
    }
  },

  /**
   * Truffle DB
   *
   * Note: 如果在你的 Truffle 项目中启用这个字段之前部署 ( migrated ) 了你的智能合约，
   * 并且想要那些之前部署的合约在 .db 目录可用，你需要执行下面命令：
   * `$ truffle migrate --reset --compile-all`
   */
  db: {
    enabled: false
  }
}
