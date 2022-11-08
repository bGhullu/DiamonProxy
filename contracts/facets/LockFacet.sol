// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract LockFacet is Initializable {
    uint public unlockTime;
    address payable public _owner;

    event Withdrawal(uint amount, uint when);

    // constructor(uint _unlockTime) payable {
    //     require(
    //         block.timestamp < _unlockTime,
    //         "Unlock time should be in the future"
    //     );

    //     unlockTime = _unlockTime;
    //     owner = payable(msg.sender);
    // }
    constructor() {}

    function initialize(uint _unlockTime) external payable initializer {
        require(
            block.timestamp < _unlockTime,
            "Unlock time should be in the future"
        );

        unlockTime = _unlockTime;
        _owner = payable(msg.sender);
    }

    // function initialize(uint _unlockTime) external payable initializer {
    //     BlockTimeStamp.checkTimeStamp(_unlockTime);
    //     unlockTime = _unlockTime;
    //     user = payable(msg.sender);
    // }

    function withdraw() public {
        // Uncomment this line, and the import of "hardhat/console.sol", to print a log in your terminal
        // console.log("Unlock time is %o and block timestamp is %o", unlockTime, block.timestamp);

        require(block.timestamp >= unlockTime, "You can't withdraw yet");
        require(msg.sender == _owner, "You aren't the owner");

        emit Withdrawal(address(this).balance, block.timestamp);

        _owner.transfer(address(this).balance);
    }
}
