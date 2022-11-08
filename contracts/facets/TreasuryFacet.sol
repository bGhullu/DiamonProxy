// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/**
 * @title Stoa Treasury Contract
 * @author The Stoa Corporation Ltd.
 * @notice
 *  Collects protocol revenue and engages in market operations
 *  to achieve strategic goals.
 */

import "hardhat/console.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {LibDiamond} from "../libraries/LibDiamond.sol";
import "../interfaces/IERC4626.sol";
import "../interfaces/IActivated.sol";
import "../interfaces/IUnactivated.sol";
import "../utils/Common.sol";
import "../utils/RebaseOpt.sol";
import "../libraries/AppStorage.sol";

// contract TreasuryFacet is Ownable, Common, RebaseOpt {
contract TreasuryFacet {
    AppStorage s;
    // mapping(address => mapping(address => int)) public backingReserve;

    // /**
    //  * @notice Amount of apTokens of a given ActivePool owned by the Treasury.
    //  */
    // mapping(address => uint) public apTokens;

    uint controllerBuffer;

    // Provide approval for Controller spend in constructor.

    // function distribute(
    //     address _target,
    //     address _token,
    //     uint _amount
    // ) external onlyOwner {}

    // // Requires knowing targetController of activeTokens.
    // function redeemActiveTokens() external {}

    // function adjustAPTokenBal(address _activePool, uint _amount) external {
    //     apTokens[_activePool] += _amount;
    // }

    function adjustBackingReserve(
        address _wildToken,
        address _backingToken,
        int _amount // onlyController
    ) external {
        s.backingReserve[_wildToken][_backingToken] += _amount;
    }

    /**
     * @dev Required to call when withdrawing activeTokens, for e.g.
     * @notice _spender should only be Controller.
     */
    function _approveToken(address _token, address _spender) external {
        // IERC20 token = IERC20(_token);
        IERC20(_token).approve(_spender, type(uint).max);
    }
}
