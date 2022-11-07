// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "../interfaces/IERC4626.sol";
import "../interfaces/ITreasury.sol";
import "../interfaces/IActivated.sol";
import "../interfaces/IUnactivated.sol";
import "../interfaces/ISafeManager.sol";

struct ActivatorAccount {
    // The total number of unexchanged tokens that an account has deposited into the system
    uint256 unexchangedBalance;
    // The total number of exchanged tokens that an account has had credited
    uint256 exchangedBalance;
}

// struct UpgradeActivatorAccount {
//     // The owner address whose account will be modified
//     address user;
//     // The amount to change the account's unexchanged balance by
//     int256 unexchangedBalance;
//     // The amount to change the account's exchanged balance by
//     int256 exchangedBalance;
// }

struct AppStorage {
    //Activator Facet
    // @dev the synthetic token to be exchanged
    address syntheticToken;
    // @dev the underlyinToken token to be received
    address underlyingToken;
    // @dev contract pause state
    bool isPaused;
    mapping(address => ActivatorAccount) accounts;

    // // ControllerFacet
    // address safeManager;
    // /**
    //  * @notice
    //  *  Collects fees, backing tokens (+ yield) and
    //  *  liquidation gains.
    //  *  Allocates as necessary (e.g., depositing USDST backing
    //  *  tokens into the Curve USDST AcivePool).
    //  */
    // address treasury;
    // address activeToken;
    // address unactiveToken;
    // address inputToken;
    // /**
    //  * @dev
    //  *  Only accept one inputToken to begin with.
    //  *  Need to later adapt.
    //  */
    // IERC20 inputTokenContract;
    // IERC20 activeTokenContractERC20;
    // IERC20 unactiveTokenContractERC20;
    // /**
    //  * @dev
    //  *  Only accept one yield venue per Controller to begin with.
    //  *  For integrations that are not ERC4626-compatible (e.g., Aave), need to point to
    //  *  a ERC4626 wrapper.
    //  */
    // IERC4626 vault;
    // ITreasury treasuryContract;
    // /**
    //  * @dev Only one activeToken per Controller (this contract).
    //  * @notice Rebasing (activated) Stoa token.
    //  */
    // IActivated activeTokenContract;
    // IUnactivated unactiveTokenContract;
    // ISafeManager safeManagerContract;
    // /**
    //  * @dev Boolean to pause receiving deposits.
    //  */
    // bool isReceivingInputs;
    // mapping(address => uint) unactiveRedemptionAllowance;
    // /**
    //  * @notice Stat collection.
    //  */
    // uint amountDeposited;
    // uint amountWithdrawn;
    // uint accruedYield;
    // uint yieldAccrued;
    // uint holderYieldAccrued;
    // uint stoaYieldAccrued;
}
