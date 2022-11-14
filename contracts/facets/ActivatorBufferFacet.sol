// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {LibDiamond} from "../libraries/LibDiamond.sol";
import "../libraries/TokenUtils.sol";
import "../interfaces/IActivator.sol";
import "../base/Error.sol";
import "../libraries/AppStorage.sol";

contract ActivatorBufferFacet {
    AppStorage s;

    modifier onlyActivator(address underlyingToken) {
        if (msg.sender != s.activator[underlyingToken]) {
            revert Activator__Unauthorized();
        }
        _;
    }

    function setActivator(address underlyingToken, address newActivator)
        external
    {
        LibDiamond.enforceIsContractOwner();
        if (IActivator(newActivator).UnderlyingToken() != underlyingToken) {
            revert IllegalArgument();
        }
        s.activator[underlyingToken] = newActivator;
    }

    function setFlowRate(
        address underlyingToken,
        uint256 _flowRate // override
    ) external {
        _exchange(underlyingToken);

        s.flowRate[underlyingToken] = _flowRate;
    }

    function _updateFlow(address underlyingToken) internal returns (uint256) {
        // additional flow to be allocated based on flow rate
        uint256 marginalFlow = (block.timestamp -
            s.lastFlowrateUpdate[underlyingToken]) *
            s.flowRate[underlyingToken];
        s.flowAvailable[underlyingToken] += marginalFlow;
        s.lastFlowrateUpdate[underlyingToken] = block.timestamp;
        return marginalFlow;
    }

    function getBlockTime() public view returns (uint256) {
        return block.timestamp;
    }

    function _exchange(address underlyingToken) internal {
        _updateFlow(underlyingToken);

        uint256 initialLocalBalance = TokenUtils.safeBalanceOf(
            underlyingToken,
            address(this)
        );
        uint256 want = 0;

        if (initialLocalBalance < s.flowAvailable[underlyingToken]) {
            want = s.flowAvailable[underlyingToken] - initialLocalBalance;
        }

        if (want > 0) {
            TokenUtils.safeTransferFrom(
                underlyingToken,
                s.treasury,
                address(this),
                want
            );
        }

        uint256 localBalance = TokenUtils.safeBalanceOf(
            underlyingToken,
            address(this)
        );
        uint256 exchangeDelta = 0;
        if (localBalance > s.flowAvailable[underlyingToken]) {
            exchangeDelta =
                s.flowAvailable[underlyingToken] -
                s.currentExchanged[underlyingToken];
        } else {
            exchangeDelta = localBalance - s.currentExchanged[underlyingToken];
        }

        if (exchangeDelta > 0) {
            s.currentExchanged[underlyingToken] += exchangeDelta;
            IActivator(s.activator[underlyingToken]).exchange(exchangeDelta);
        }
    }

    function withdraw(
        address underlyingToken,
        uint256 amount,
        address recipient
    ) external onlyActivator(underlyingToken) {
        if (amount > s.flowAvailable[underlyingToken]) {
            revert IllegalArgument();
        }

        uint256 localBalance = TokenUtils.safeBalanceOf(
            underlyingToken,
            address(this)
        );
        if (amount > localBalance) {
            revert IllegalArgument();
        }

        s.flowAvailable[underlyingToken] -= amount;
        s.currentExchanged[underlyingToken] -= amount;

        TokenUtils.safeTransfer(underlyingToken, recipient, amount);
    }
}
