// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

interface IActivatorBuffer {
    function setTransmuter(address underlyingToken, address newTransmuter)
        external;

    function setFlowRate(
        address underlyingToken,
        uint256 _flowRate // override
    ) external;

    function _updateFlow(address underlyingToken) external returns (uint256);

    function _exchange(address underlyingToken) external;

    function withdraw(
        address underlyingToken,
        uint256 amount,
        address recipient
    ) external;
}
