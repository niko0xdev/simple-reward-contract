// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SimpleReward is ERC20, Ownable {
    constructor(uint256 initialSupply) ERC20("SimpleReward", "SRC20") {
        _mint(_msgSender(), initialSupply);
        _transferOwnership(_msgSender());
    }

    function withdrawApprove(
        address spender,
        uint256 amount
    ) public onlyOwner returns (bool) {
        address owner = owner();

        require(
            spender != address(0),
            "SimpleReward: approve to the zero address"
        );

        uint256 ownerBalance = balanceOf(owner);
        require(
            ownerBalance >= amount,
            "SimpleReward: transfer amount exceeds balance"
        );

        _approve(owner, spender, amount);
        return true;
    }

    function rewardWithdraw(uint256 amount) public returns (uint256) {
        address spender = _msgSender();
        address owner = owner();
        uint256 currentAllowance = allowance(owner, spender);

        if (currentAllowance != type(uint256).max) {
            require(
                currentAllowance >= amount,
                "SimpleReward: insufficient allowance"
            );

            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }

        _transfer(owner, spender, amount);

        return amount;
    }
}
