pragma solidity ^0.4.17;

import "./ownable.sol";
import "./safemath.sol";

/**
 * @title BlockchainArbitration
 * @dev The BlockchainArbitration contract contains the arguments and arbitration fee for arbitration.
 * The contract presents the highest voted solution as the final arbitration solution. There is a time
 * restriction to a week total for the contract. 2 days maximum for solutions and 5 days maximum for voting.
 * Solution providers and voters are arbitrarily chosen from a pool of addresses who holds our ARB token by
 * means of Proof of Stake.
 */
contract BlockchainArbitration is Ownable {

  using SafeMath for uint8;

  /**
  * @dev String A represents the viewpoint and argument of side A;
  *      String B represents the viewpoint and argument of side B;
  */
  string A;
  string B;

  /**
  * @dev Arbitration Fee as a percentage of the total balance of the contract. Base fee is 5%.
  */
  uint8 feePercentage = 5;

  /**
  * @dev Stores solutions and addresses of solutions providers.
  */
  mapping (string => address) private solutionToSender;

  /*
  * @dev Caps the total number of solutions to 10 solutions or 2 days after the creation of the contract.
  */
  address[] private solutions;

  /*
  * @dev Votes for solutions of the same index
  */
  address[] private votes;

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
  function increaseFees(uint8 percent) public onlyOwner {
    require(feePercentage.add(percent) <= 100);
    feePercentage = feePercentage.add(percent);
  }

  /**
  * @dev Adds a solution to the dispute.
  */
  function sendSolution() public approveSolutionsSenders() {

  }

  /**
  * @dev Increases votes for the index of the solution being voted
  */
  function vote() public approveSolutionsVoters() {

  }

  /**
  * @dev Pays out the arbitration fee to the address of the highest voted solution.
  */
  function payArbitrationFees() private {

  }

  /**
  * @dev Restricts solutions sending time to 2 days.
  */
  function solutionsTime() private {

  }

  /**
  * @dev Restricts voting time to 5 days.
  */
  function voteTime() private view {

  }


}
