/** 编译合约得到的 ABI */
const abi = require('../../build/contracts/ZombieFactory.json').abi
/** 合约抽象 */
const ZombieFactoryContract = web3.eth.contract(abi)
/** 在以太坊上发布后生成的合约地址 */
const contractAddress = '...'
/** 合约实例 */
const ZombieFactory = ZombieFactoryContract.at(contractAddress)

$('#submitButton').click((event) => {
  const name = $('#nameInput').val()
  // 调用合约函数生成僵尸
  ZombieFactory.createRandomZombie(name)
})

// 监听合约事件，并更新界面
const event = ZombieFactory.NewZombie((error, result) => {
  if (error) return
  generateZombie(result.zombieId, result.name, result.dna)
})

/**
 * 获取 Zombie 的 DNA 更新图像
 */
function generateZombie(id, name, dna) {
  let dnaStr = String(dna)
  // 如果 DNA 少于 16 位，则在前面补零
  while (dnaStr.length < 16) {
    dnaStr = '0' + dnaStr
  }

  /**
   * 僵尸详情信息
   *
   * ZombieDNA = [头部7种, 眼睛11种, 衣着6种，肤色, 眼睛颜色, 服饰颜色, 其他信息]
   */
  const zombieDetails = {
    headChoice: (dnaStr.substring(0, 2) % 7) + 1,
    eyeChoice: (dnaStr.substring(2, 4) % 11) + 1,
    shirtChoice: (dnaStr.substring(4, 6) % 6) + 1,
    skinColorChoice: parseInt((dnaStr.substring(6, 8) / 100) * 360),
    eyeColorChoice: parseInt((dnaStr.substring(8, 10) / 100) * 360),
    clothesColorChoice: parseInt((dnaStr.substring(10, 12) / 100) * 360),
    zombieId: id,
    zombieName: name,
    zombieDescription: 'A Level 1 CryptoZombie'
  }

  return zombieDetails
}
