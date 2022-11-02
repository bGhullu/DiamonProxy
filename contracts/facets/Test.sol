// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {ReentrancyGuardUpgradeable} from "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
import {AccessControlUpgradeable} from "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "../libraries/TokenUtils.sol";
import "../base/Error.sol";
import "../libraries/SafeCast.sol";

contract Test is
    Initializable,
    ReentrancyGuardUpgradeable,
    AccessControlUpgradeable
{
    event Paused(bool flag);

    event Deposit(address indexed user, uint256 unexchangedBalance);

    event Withdraw(
        address indexed user,
        uint256 unexchangedBalance,
        uint256 exchangedBalance
    );

    event Claim(
        address indexed user,
        uint256 unexchangedBalance,
        uint256 exchangedBalance
    );

    struct Account {
        // The total number of unexchanged tokens that an account has deposited into the system
        uint256 unexchangedBalance;
        // The total number of exchanged tokens that an account has had credited
        uint256 exchangedBalance;
    }

    struct UpdateAccount {
        // The owner address whose account will be modified
        address user;
        // The amount to change the account's unexchanged balance by
        int256 unexchangedBalance;
        // The amount to change the account's exchanged balance by
        int256 exchangedBalance;
    }
    // @dev The identifier of the role which maintains other roles.
    bytes32 public constant ADMIN = keccak256("ADMIN");

    // @dev The identifier of the sentinel role
    bytes32 public constant SENTINEL = keccak256("SENTINEL");

    // @dev the synthetic token to be exchanged
    address public syntheticToken;

    // @dev the underlyinToken token to be received
    address public underlyingToken;

    mapping(address => Account) private accounts;

    constructor() {}

    function initialize(address _syntheticToken, address _underlyingToken)
        external
        initializer
    {
        // _setupRole(ADMIN, msg.sender);
        // _setRoleAdmin(ADMIN, ADMIN);
        // _setRoleAdmin(SENTINEL, ADMIN);
        syntheticToken = _syntheticToken;
        underlyingToken = _underlyingToken;
    }

    function depositSynthetic(uint256 amount) external {
        _updateAccount(
            UpdateAccount({
                user: msg.sender,
                unexchangedBalance: SafeCast.toInt256(amount),
                exchangedBalance: 0
            })
        );
        TokenUtils.safeTransferFrom(
            syntheticToken,
            msg.sender,
            address(this),
            amount
        );
        emit Deposit(msg.sender, amount);
    }

    function withdraw(uint256 amount) external {
        _updateAccount(
            UpdateAccount({
                user: msg.sender,
                unexchangedBalance: -SafeCast.toInt256(amount),
                exchangedBalance: 0
            })
        );
        TokenUtils.safeTransfer(syntheticToken, msg.sender, amount);
        emit Withdraw(
            msg.sender,
            accounts[msg.sender].unexchangedBalance,
            accounts[msg.sender].exchangedBalance
        );
    }

    function claim(uint256 amount) external {
        _updateAccount(
            UpdateAccount({
                user: msg.sender,
                unexchangedBalance: -SafeCast.toInt256(amount),
                exchangedBalance: SafeCast.toInt256(amount)
            })
        );
        TokenUtils.safeTransfer(underlyingToken, msg.sender, amount);
        TokenUtils.safeBurn(syntheticToken, amount);
        emit Claim(
            msg.sender,
            accounts[msg.sender].unexchangedBalance,
            accounts[msg.sender].exchangedBalance
        );
    }

    function _updateAccount(UpdateAccount memory param) internal {
        Account storage _account = accounts[param.user];
        int256 updateUnexchange = int256(_account.unexchangedBalance) +
            param.unexchangedBalance;
        int256 updateExchange = int256(_account.exchangedBalance) +
            param.exchangedBalance;
        if (updateUnexchange < 0 || updateExchange < 0) {
            revert IllegalState();
        }
        _account.unexchangedBalance = uint256(updateUnexchange);
        _account.exchangedBalance = uint256(updateExchange);
    }
}
