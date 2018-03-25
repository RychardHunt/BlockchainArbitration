pragma solidity ^0.4.17;

import "./ownable.sol";
import "./safemath.sol";

/**
 * @title BlockchainArbitration
 * @dev The BlockchainArbitration contract contains the arguments and arbitration fee for arbitration.
 * The contract presents the highest voted solution as the final arbitration solution. There is a time
 * restriction to a week total for the contract. 2 days maximum for solutions and 3 days maximum for voting.
 * Solution providers and voters are arbitrarily chosen from a pool of addresses who holds our ARB token by
 * means of Proof of Stake.
 */
contract BlockchainArbitration is Ownable {

  using SafeMath for uint256;

  /**
  * @dev Displays winning solution on the blockchain.
  */
  string public finalSolution;

  /**
  * @dev String A represents the viewpoint and argument of side A;
  *      String B represents the viewpoint and argument of side B;
  */
  string A;
  string B;

  /**
  * @dev Arbitration Fee as a percentage of the total balance of the contract. Base fee is 5%.
  */
  uint256 feePercentage = 5;

  /**
  * @dev solutionToSender stores solutions and addresses of solutions providers.
  *      indexToVoters stores a dynamic array of voter addresses.
  */
  mapping (string => address) private solutionToSender;
  mapping (uint8 => address[]) private indexToVoters;

  /*
  * @dev Solutions stores the solutions at the index of the order they are received.
  *      Solutions ID keeps track of how many solutions have been submitted.
  */
  string[10] private solutions;
  uint256 private solutionsId = 0;

  /*
  * @dev votes for solutions of the same index
  *      totalVotes keeps track of total amount of votes. Capped at 101 votes.
  */
  uint256[10] private votes;
  uint256 totalVotes = 0;

  /**
  * @dev Constructor initiates String A and String B with the parameters.
  */
  function BlockchainArbitration(string _A, string _B) public {
    A = _A;
    B = _B;
  }

  /**
  * @dev Modifier for approved solutions senders.
  */
  modifier approveSolutionsSenders() {
    _;
  }

  /**
  * @dev Modifier for approved solutions voters.
  */
  modifier approveSolutionsVoters() {
    _;
  }

  /**
  * @dev Increase Fees by numbers of percentage points.
  */
  /* function increaseFees(uint256 percent) public onlyOwner {
    require(feePercentage.add(percent) <= 100);
    feePercentage = feePercentage.add(percent);
  } */

  /**
  * @dev Adds a solution to the dispute. Capped at 10 solutions.
  */
  function sendSolution(string _solution) public approveSolutionsSenders() {
    require(solutionsId != 9);
    solutions[solutionsId] = _solution;
    solutionsId = solutionsId.add(1);
    solutionToSender[_solution] = msg.sender;
  }

  /**
  * @dev Increases votes for the index of the solution being voted. Capped at 100 votes.
  */
  function vote(uint256 _solutionsIndex) public approveSolutionsVoters() {
    require(totalVotes < 100);
    votes[_solutionsIndex] = votes[_solutionsIndex].add(1);
    totalVotes = totalVotes.add(1);
  }

  /**
  * @dev Pays out the arbitration fee to the address of the highest voted solution.
  */
  function payArbitrationFees() public onlyOwner payable {
    uint256 indexMax = 0;
    uint256 maxVotes = votes[indexMax];
    for (uint i = 1; i < 10; i++) {
      if (votes[i] > maxVotes) {
        indexMax = i;
        maxVotes = votes[i];
        // Doesn't deal with ties yet. Edge case.
      }
    }
    finalSolution =  solutions[indexMax];
    solutionToSender[finalSolution].transfer(this.balance);
  }

  /**
  * @dev Restricts solutions sending time to 2 days.
  */
  function solutionsTime() private {

  }

  /**
  * @dev Restricts voting time to 3 days.
  */
  function voteTime() private view {

  }


}
