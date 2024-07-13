// SPDX-License-Identifier: MIT
//Neste contrato permite que os membros proponham e votem em propostas. As propostas são executadas se receberem votos suficientes.
pragma solidity ^0.8.0;

contract Governance {
    struct Proposal {
        uint id;
        string description;
        uint voteCount;
        bool executed;
        mapping(address => bool) voters;
    }

    mapping(uint => Proposal) public proposals;
    uint public proposalCount;
    address public owner;

    event ProposalCreated(uint id, string description);
    event Voted(uint proposalId, address voter);
    event ProposalExecuted(uint id);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier onlyMember() {
        require(balanceOf(msg.sender) > 0, "Only members can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function createProposal(string memory _description) public onlyMember {
        proposalCount++;
        Proposal storage proposal = proposals[proposalCount];
        proposal.id = proposalCount;
        proposal.description = _description;
        proposal.voteCount = 0;
        proposal.executed = false;
        emit ProposalCreated(proposalCount, _description);
    }

    function vote(uint _proposalId) public onlyMember {
        Proposal storage proposal = proposals[_proposalId];
        require(!proposal.voters[msg.sender], "You have already voted");
        proposal.voters[msg.sender] = true;
        proposal.voteCount++;
        emit Voted(_proposalId, msg.sender);
    }

    function executeProposal(uint _proposalId) public onlyOwner {
        Proposal storage proposal = proposals[_proposalId];
        require(!proposal.executed, "Proposal already executed");
        require(proposal.voteCount > 1, "Not enough votes"); // Example threshold
        proposal.executed = true;
        // Implement proposal execution logic here
        emit ProposalExecuted(_proposalId);
    }

    // Example function to return balance of an address (for simplicity, assume each member has 1 token)
    function balanceOf(address _member) public view returns (uint) {
        // Replace with actual token balance logic
        return 1;
    }
}


//Neste contrato define um token ERC20 que será usado para governança.
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract GovernanceToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("GovernanceToken", "GTN") {
        _mint(msg.sender, initialSupply);
    }
}
