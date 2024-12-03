# Degen Token (DGN)

The **Degen Token (DGN)** is an ERC20-compliant cryptocurrency built on the Avalanche blockchain. It powers the Degen Gaming in-game ecosystem, enabling:
- Player rewards
- Item redemption in the in-game store
- Trading among players

This smart contract includes features to mint tokens, transfer tokens, burn tokens, and redeem predefined items in the store.

---

## Getting Started

### Installing

1. Ensure you have **Remix**, an online Solidity IDE, installed or accessible at [Remix](https://remix.ethereum.org).
2. Install **MetaMask** to interact with the Ethereum blockchain (testnets recommended).
3. Import the OpenZeppelin library by adding the following imports in your contract:
   ```solidity
    import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
    import "@openzeppelin/contracts/access/Ownable.sol";
   ```
   
---

## Executing Program

1. Copy the code into Remix and compile it using the Solidity compiler (pragma solidity ^0.8.26).
   ```solidity
      // SPDX-License-Identifier: MIT
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
   ```
  Deploy the contract to a test blockchain (e.g., using a local Ethereum node or the Remix JavaScript VM).
  
2. Interact with the Contract
  - Mint Tokens:
    As the owner, mint tokens for any address using the mint(address to, uint amount) function.
  - Transfer Tokens:
    Transfer tokens to another address using the transferTokens(address to, uint amount) function.
  - Redeem Items:
    Redeem items using the redeem(uint itemId) function, where:
    - 1 = Excalibur Sword
    - 2 = Shield of Achilles
    - 3 = Potion of Undying
  - Burn Tokens:
    Burn tokens from your account using the burn(uint amount) function.
  - Check Balance:
    View your token balance with the checkTokenBalance() function.
  - Get Item Info:
    View item details with the getItemInfo(uint itemId) function.
  
3. Item Redemption Example
  - Ensure you have sufficient tokens to redeem an item.
  - Call redeem(1) to redeem the Excalibur Sword (cost: 50 tokens).
  - The stock decreases by 1, and 50 tokens are burned from your account.

## Authors
Metacrafters Joshua Renniel Pineda

## License
This project is licensed under the MIT License - see the LICENSE.md file for details
