// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.17;

import "../libraries/AppStorage.sol";

contract PriceFeedFacet {
    AppStorage s;

    // mapping(address => uint) public tokenPrice;

    function setPrice(address _token, uint _price) external {
        s.tokenPrice[_token] = _price;
    }

    function getPrice(address _token) external view returns (uint price) {
        price = s.tokenPrice[_token];
    }
}
