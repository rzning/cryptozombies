// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract SandwichFactory {
    struct Sandwich {
        string name;
        string status;
    }

    Sandwich[] sandwiches;

    function eatSandwich(uint256 _index) public {
        /// @notice storage ->
        Sandwich storage mySandwich = sandwiches[_index];
        // mySandwich 是指向 sandwiches[_index] 的指针。

        // 对它操作将会写入区块链的存储。
        mySandwich.status = "Eaten!";

        /// @notice memory ->
        Sandwich memory anotherSandwich = sandwiches[_index + 1];
        // anotherSandwich 只是内存里的一个副本。

        // 这将仅仅修改临时变量，对 sandwiches[_index + 1] 没有任何影响
        anotherSandwich.status = "Eaten!";

        // 若想把副本的改动存回区块链存储，可以这样操作：
        sandwiches[_index + 1] = anotherSandwich;
    }
}
