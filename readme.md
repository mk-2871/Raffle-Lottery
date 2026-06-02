# Raffle-Lottery

## What is this?
A provably fair decentralized lottery system built in Solidity where 
users enter by paying an entrance fee and a random winner is 
automatically selected after a set time interval.

## How it works
1. Users call `enterRaffle()` by paying the entrance fee in ETH
2. Chainlink Automation monitors the contract and triggers winner 
   selection when the time interval has passed, the contract has 
   balance, the raffle is open, and players are present
3. `performUpkeep()` requests a random number from Chainlink VRF V2 
   Plus and sets raffle state to CALCULATING to prevent new entries
4. Chainlink VRF returns a verifiable random number to 
   `fulfillRandomWords()` which selects the winner using modulo, 
   sends the entire contract balance as prize, and resets the raffle 
   for the next round

## Technologies Used
- Solidity
- Foundry (testing and deployment)
- Chainlink VRF V2 Plus (verifiable randomness)
- Chainlink Automation (automated upkeep)
- Sepolia Testnet

## How to Run

### Install dependencies
forge install

### Run tests
forge test

### Deploy
forge script script/DeployRaffle.s.sol --rpc-url $SEPOLIA_RPC_URL 
--private-key $PRIVATE_KEY --broadcast

## Deployed on
Sepolia Testnet
