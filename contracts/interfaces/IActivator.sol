// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

interface IActivator {
    struct UpgradeActivatorAccount {
        // The owner address whose account will be modified
        address user;
        // The amount to change the account's unexchanged balance by
        int256 unexchangedBalance;
        // The amount to change the account's exchanged balance by
        int256 exchangedBalance;
    }
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

    function setPause(bool pauseState) external;

    function depositSynthetic(uint256 amount) external;

    function withdrawSynthetic(uint256 amount) external;

    function claimUnderlying(uint256 amount) external;

    function exchange(uint256 amount) external;

    function _updateAccount(UpgradeActivatorAccount memory param) external;

    function getSyntheticToken() external view returns (address);

    function UnderlyingToken() external view returns (address);

    function getUserData(address user) external view returns (uint256, uint256);
}
