// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract mycontract {
    address public partyA;
    address public partyB;
    uint256 public depositAmount;
    bool public isFundsReleased;

    event Deposit(address indexed depositor, uint256 amount);
    event FundsReleased(address indexed receiver, uint256 amount);

    modifier onlyPartyB() {
        require(msg.sender == partyB, "Only Party B can call this function");
        _;
    }

    constructor(address _partyB) payable {
        partyA = msg.sender;
        partyB = _partyB;
        depositAmount = msg.value;
        isFundsReleased = false;

        emit Deposit(msg.sender, msg.value);
    }

    function releaseFunds() external payable  onlyPartyB {
        require(!isFundsReleased, "Funds have already been released");
        isFundsReleased = true;
        payable(partyB).transfer(depositAmount);
        emit FundsReleased(partyB, depositAmount);
    }

    function getDepositAmount() external view returns (uint256) {
        return depositAmount;
    }

    
}
