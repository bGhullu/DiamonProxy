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
    address buffer;
    mapping(address => uint256) flowRate;
    /// @notice The last update timestamp gor the flowRate for each address.
    mapping(address => uint256) lastFlowrateUpdate;
    /// @notice The amount of flow available per ERC20.
    mapping(address => uint256) flowAvailable;
    mapping(address => address) activator;
    mapping(address => uint256) currentExchanged;
    // @dev contract pause state
    bool isPaused;
    mapping(address => ActivatorAccount) accounts;
    // ControllerFacet
    address safeManager;
    // /**
    //  * @notice
    //  *  Collects fees, backing tokens (+ yield) and
    //  *  liquidation gains.
    //  *  Allocates as necessary (e.g., depositing USDST backing
    //  *  tokens into the Curve USDST AcivePool).
    //  */
    address treasury;
    address activeToken;
    address unactiveToken;
    address inputToken;
    // PriceFeedFacet
    mapping(address => uint) tokenPrice;
    // SafeOperationsFacet

    mapping(address => address) tokenToController;
    /**
     * @dev
     *  Later use for self-repaying loan logic.
     */
    mapping(address => bool) isActiveToken;
    mapping(address => address) activeToInputToken;
    mapping(address => uint) originationFeesCollected;
    // TreasuryFacet

    /**
     * @notice Amount of apTokens of a given ActivePool owned by the Treasury.
     */
    mapping(address => mapping(address => int)) backingReserve;
    mapping(address => uint) apTokens;
}
