# 🗳️ Simple Blockchain Voting DApp

A beginner-friendly **Solidity Voting DApp** that lets users vote for their favorite candidates on the blockchain securely and transparently.  
This project is designed for those who are **new to blockchain development** and want to understand how **smart contracts**, **ownership control**, and **on-chain voting** work.

---
    ## 🚀 Deployed Smart Contract
   **Network:** Sepolia Testnet 
   <br>
  **Contract Address:** [0x1b1ecC57eF84c6e58A896BDE9454688B83C2E86E](https://celo-sepolia.blockscout.com/address/0x1b1ecC57eF84c6e58A896BDE9454688B83C2E86E)
  
<img width="1872" height="912" alt="image" src="https://github.com/user-attachments/assets/ca2368c3-7bd6-4169-a60d-a92937987e61" />

---
## 🚀 Project Description

The **SimpleVoting** smart contract provides a decentralized and tamper-proof voting mechanism built on the Ethereum blockchain.  
It allows the contract **owner** to add candidates, and **voters** (unique wallet addresses) to cast one vote per account.  

This project is ideal for learning:
- Solidity fundamentals  
- Smart contract deployment using Remix IDE  
- Blockchain voting logic (without a centralized database)

---

## 💡 What It Does

- The **owner** (deployer) creates an election by adding candidates.  
- Each **voter** can cast a single vote for any candidate.  
- Votes are **recorded immutably** on the blockchain.  
- The contract keeps track of **who has voted** and **how many votes each candidate received**.  
- Anyone can **view results** transparently at any time.  

---

## ✨ Features

✅ **One-person-one-vote** system — ensures fairness.  
✅ **Transparent voting results** — no hidden data.  
✅ **Owner-controlled candidate creation** — prevents spam or misuse.  
✅ **Gas-efficient design** — simple and cost-effective smart contract.  
✅ **Beginner-friendly structure** — easy to understand and extend.  

---

## 🧠 Smart Contract Code

```solidity

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SimpleVoting {
    // Struct to store candidate details
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Mapping from candidate ID to Candidate
    mapping(uint => Candidate) public candidates;

    // Mapping to check if an address has already voted
    mapping(address => bool) public hasVoted;

    // Number of candidates
    uint public candidatesCount;

    // Owner (the person who deploys the contract)
    address public owner;

    // Constructor runs only once during deployment
    constructor() {
        owner = msg.sender; // deployer becomes contract owner
    }

    // Modifier to restrict functions to only the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }

    // Function to add a new candidate (only owner can add)
    function addCandidate(string memory _name) public onlyOwner {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    // Function to vote for a candidate
    function vote(uint _candidateId) public {
        require(!hasVoted[msg.sender], "You have already voted!");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID!");

        hasVoted[msg.sender] = true;
        candidates[_candidateId].voteCount++;
    }

    // Function to get total votes for a candidate
    function getVotes(uint _candidateId) public view returns (uint) {
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID!");
        return candidates[_candidateId].voteCount;
    }
}

