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
    string[] public candidateNames; // Array of candidate names
    mapping(string => uint) public candidateVotes; // Mapping to store votes of each candidate
    mapping(address => bool) public hasVoted; // Mapping to keep track of who has voted

    // Constructor to initialise candidates list
    constructor(string[] memory candidates) {
        candidateNames = candidates;
    }

    // Function to cast a vote
    function castVote(string memory _candidateName) public {
        require(!hasVoted[msg.sender], "Has voted"); // Check if one has already voted

        require(checkCandidateExists(_candidateName), "Invalid candidate"); // Check if the candidate exists

        candidateVotes[_candidateName]++; // Increment the vote for the candidate
        hasVoted[msg.sender] = true; // Updates the status of voter and noting that the person has voted
    }

    // Funcction to declare winner
    function declareWinner() public view returns (string memory) {
        // Find the candidate with the highest number of votes
        uint maxVotes = candidateVotes[candidateNames[0]];
        string memory winner = candidateNames[0];

        // Find the candidate with the highest number of votes
        for (uint i = 0; i < candidateNames.length; i++) {
            if (candidateVotes[candidateNames[i]] > maxVotes) {
                maxVotes = candidateVotes[candidateNames[i]];
                winner = candidateNames[i];
            }
        }

        // Return the winner
        return winner;
    }

    function checkCandidateExists(
        string memory candidateName
    ) private view returns (bool) {
        for (uint i = 0; i < candidateNames.length; i++) {
            if (
                keccak256(abi.encodePacked(candidateNames[i])) ==
                keccak256(abi.encodePacked(candidateName))
            ) {
                return true;
            }
        }
        return false;
    }
}
