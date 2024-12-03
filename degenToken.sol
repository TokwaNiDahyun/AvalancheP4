// SPDX-License-Identifier: MIT
// FEU TECH - Joshua Renniel Pineda - 202111212
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract degenToken is ERC20, Ownable {
    struct Item {
        string name;
        uint price;
        uint stock;
    }

    Item[3] public items;

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
        _mint(msg.sender, 1000);
        // name, price, stock
        items[0] = Item("Excalibur Sword", 50, 5);
        items[1] = Item("Shield of Achilles", 75, 5);
        items[2] = Item("Potion of Undying", 25, 5);
    }

    function mint(address to, uint amount) external onlyOwner {
        _mint(to, amount);
    }

    function transferTokens(address to, uint amount) external {
        transfer(to, amount);
    }

    function redeem(uint itemId) external {
        require(itemId > 0 && itemId <= items.length, "Input valid Item ID");
        Item storage item = items[itemId - 1];
        require(item.stock > 0, "Out of stock");
        require(balanceOf(msg.sender) >= item.price, "Insufficient tokens");

        _burn(msg.sender, item.price);
        item.stock--; 
    }

    function burn(uint amount) external {
        require(balanceOf(msg.sender) >= amount, "Not enough tokens to burn");
        _burn(msg.sender, amount);
    }

    function checkTokenBalance() external view returns (uint) {
        return balanceOf(msg.sender);
    }

    function getItemInfo(uint itemId) external view returns (string memory, uint, uint) {
        require(itemId > 0 && itemId <= items.length, "Input valid Item ID");
        Item memory item = items[itemId - 1];
        return (item.name, item.price, item.stock);
    }
}
