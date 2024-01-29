// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.21;

// Challenge: This is part of a 15 day smart contract writing challenge, with 5 days for each level of difficulty, basic, intermediate and advanced.

/*
Basic 3: 
Write a smart contract that can implement a simple voting system.
The contract should have an array that stores the candidates’ names. 
The contract should also have a mapping that stores the votes for each candidate.
The contract should also have a function to allow voters to cast their votes, only once per address.
The contract should also have a function to declare the winner, based on the highest number of votes.
*/

contract Voting {
    // Public array holding names of candidates
    string[] public candidateNames;

    // Mapping to store the number of votes for each candidate
    mapping(string => uint) public candidateVotes;

    // Mapping to track whether an address (person) has already voted or not
    mapping(address => bool) public hasVoted;

    // Constructor to initialize the candidates list when a contract is deployed
    constructor(string[] memory candidates) {
        candidateNames = candidates;
    }

    // Function to cast a vote for a candidate
    function castVote(string memory _candidateName) public {
        // Check that the sender hasn't voted already
        require(!hasVoted[msg.sender], "Has voted");

        // Check that the candidate exists
        require(checkCandidateExists(_candidateName), "Invalid candidate");

        // Increment the vote count for the candidate
        candidateVotes[_candidateName]++;

        // Record that the sender has voted
        hasVoted[msg.sender] = true;
    }

    // Function to declare the winner of the election based on the highest votes
    function declareWinner() public view returns (string memory) {
        // Assuming the first candidate has the max number of votes initially
        uint maxVotes = candidateVotes[candidateNames[0]];
        string memory winner = candidateNames[0];

        // Loop through all candidates to find the one with the most votes
        for (uint i = 0; i < candidateNames.length; i++) {
            if (candidateVotes[candidateNames[i]] > maxVotes) {
                maxVotes = candidateVotes[candidateNames[i]];
                winner = candidateNames[i];
            }
        }

        // Return the name of the candidate with the most votes
        return winner;
    }

    // Private helper function to check if a candidate exists in the candidate list
    function checkCandidateExists(string memory candidateName) private view returns (bool) {
        for (uint i = 0; i < candidateNames.length; i++) {
            // Compare hashed strings to see if the candidate's name exists
            if (keccak256(abi.encodePacked(candidateNames[i])) == keccak256(abi.encodePacked(candidateName))) {
                // Candidate exists
                return true;
            }
        }
        // Candidate doesn't exist
        return false;
    }
}
