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
