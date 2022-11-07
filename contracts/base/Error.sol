// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

/**
 *  @notice An error used to indicate that an action could not be completed because either the `msg.sender` or
 *  `msg.origin` is not authorized.
 */
error Activator__Unauthorized();

// @notice An error used to indicate that an action could not be completed because of invalid amount zero entered.
error Activator__NotAllowedZeroValue();

// @notice An error used to indicate that an action could not be completed because of invalid amount entered.
error Activator__InvalidAmount();

/**
 * @notice An error used to indicate that an action could not be completed because the contract either already existed
 * or entered an illegal condition which is not recoverable from.
 */
error IllegalState();

error IllegalArgument();

error InValidUnlockTime();

//  {
//     facetAddress: '0xCaB046675853E2e69D4014690AE585d778a63E0B',
//     action: 0,
//     functionSelectors: [
//       '0xcdffacc6',
//       '0x52ef6b2c',
//       '0xadfca15e',
//       '0x7a0ed627',
//       '0x01ffc9a7',
//       contract: [Contract],
//       remove: [Function: remove],
//       get: [Function: get]
//     ]
//   },
//   {
//     // OwnershipFacet
//     facetAddress: '0x71dad5B6FDcA7814628c70BA1E09dE70408B3689',
//     action: 0,
//     functionSelectors: [
//       '0x8da5cb5b', ideal_warn_timed(uint256,uint128) owner()
//       '0xf2fde38b',
//       contract: [Contract],
//       remove: [Function: remove],
//       get: [Function: get]
//     ]
//   },
//   {
//     facetAddress: '0xfec5967FC85Bb039F1B352fCbAce2B014B312BE5',
//     action: 0,
//     functionSelectors: [
//       '0xc5e2d2a6',
//       '0x602631ef',
//       '0x3087944c',
//       '0x81d62ec9',
//       '0xee719bc8',
//       '0xffc9896b',
//       '0x485cc955',
//       '0xbedb86fb',
//       '0xb8b4e9fb',
//       contract: [Contract],
//       remove: [Function: remove],
//       get: [Function: get]
//     ]
//   },
//   {

//     // ControllerFacet
//     facetAddress: '0x10A9aEceec8B4b0777b45B1aaC82445F85dF2B49',
//     action: 0,
//     functionSelectors: [
//       '0x4019fb33',
//       '0x505398eb',
//       '0x8796d43d',
//       '0xe73264b4',
//       '0xf6371fb4',
//       '0xb93a5f3c',
//       '0xe6ad0a38',
//       '0x017123d0',
//       '0xf86ccd41',
//       '0x0d662a1f',
//       '0x03105b04', approveToken(address,address)
//       '0x7878d768',
//       '0x1f1e5ba5',
//       '0x3edd1128',
//       '0xc957352f',
//       '0xe52e43da',
//       '0x9ec89bad',
//       '0xcc2a9a5b',
//       '0x01b60ef2',
//       '0x7c32afe6',
//       '0x65ce1c8d',
//       '0x9be9afa8',
//       '0x13966db5',
//       '0xaf14052c',
//       '0x5d907379', rebaseOptIn(address)
//       '0xe6260307', rebaseOptOut(address)
//       '0x458f5815',
//       '0x57c90441', //
//       '0xfa00f36f',
//       '0x821b22c5', //
//       '0x91b32b32',
//       '0xdf12d2d9', //
//       '0x426be0e9',
//       '0xd4c3eea0',
//       '0x61d027b3', treasury()
//       '0x45b16a22',
//       '0xafef3b10',
//       '0x92545ca9',
//       '0x11c4b9cb',
//       '0xfbfa77cf',
//       '0xf3fef3a3',
//       '0x7dff0a6d',
//       '0xca092ce8',
//       contract: [Contract],
//       remove: [Function: remove],
//       get: [Function: get]
//     ]
//   },
//   {
//     // LockFacet
//     facetAddress: '0x8Acf72DD5Fd7F8b21998887735A4e6D4aA65636C',
//     action: 0,
//     functionSelectors: [
//       '0xfe4b84df',
//       '0x8da5cb5b', ideal_warn_timed(uint256,uint128) owner()
//       '0x251c1aa3',
//       '0x3ccfd60b',
//       contract: [Contract],
//       remove: [Function: remove],
//       get: [Function: get]
//     ]
//   },
//   {

//     facetAddress: '0xeca36a4D7D776C6106d13e245102C23e3b18434c',
//     action: 0,
//     functionSelectors: [
//       '0x41976e09',
//       '0x00e4768b',
//       '0x84ba3f69',
//       contract: [Contract],
//       remove: [Function: remove],
//       get: [Function: get]
//     ]
//   },
//   {
//     // SafeManagerFacet
//     facetAddress: '0x3A1693d5Ae55Dce45f20898E0435D2161859D6FC',
//     action: 0,
//     functionSelectors: [
//       '0xbc8acacf',
//       '0x298c4ef1',
//       '0xda52aa88',
//       '0xddb3c25a',
//       '0x35b7bb47',
//       '0xf2c0dfd4',
//       '0x55d12f03',
//       '0x992ff970',
//       '0x91d19e5c',
//       '0xb5d5d0d6',
//       '0x05632798',
//       '0x9ba45648',
//       '0xc4d66de8',
//       '0xdf800ccc',
//       '0x466d4d50',
//       '0x70aa44c9',
//       '0x741bef1a', priceFeed()
//       '0x5d907379', rebaseOptIn(address)
//       '0xe6260307', rebaseOptOut(address)
//       '0x457d1f2d',
//       '0x821b22c5', //
//       '0x9dda6348',
//       '0x1a48a6a1',
//       '0xdf12d2d9', //
//       '0x23c3cf14',
//       '0xdcda439b',
//       '0xf3466f96',
//       contract: [Contract],
//       remove: [Function: remove],
//       get: [Function: get]
//     ]
//   },
//   {
//     // SafeOperationsFacet
//     facetAddress: '0xf17fdC05CD1230fDe30802C395B09Fb931814FeF',
//     action: 0,
//     functionSelectors: [
//       '0x9da2a903',
//       '0x0be3cfb7',
//       '0x10f29204',
//       '0xc3108081',
//       '0x4448d486',
//       '0x1c228377',
//       '0x88c662aa',
//       '0xc0c53b8b',
//       '0x575c51c2',
//       '0x2fac0266',
//       '0xc0970c36',
//       '0xb8bb5c42',
//       '0x24cb725d',
//       '0x741bef1a',	priceFeed()
//       '0xd8aed145',
//       '0x57c90441', //
//       '0x821b22c5',
//       '0x7b7d6c68',
//       '0xdf12d2d9',//
//       '0xf0f44260',
//       '0x520082e0',
//       '0xf82bd179',
//       '0x01cc2a00',
//       '0x61d027b3', treasury()
//       '0x246adc8f',
//       contract: [Contract],
//       remove: [Function: remove],
//       get: [Function: get]
//     ]
//   },
//   {
//     // TreasuryFacet
//     facetAddress: '0x9296c108Ab39a43c3E78516618383687b1b6CeAb',
//     action: 0,
//     functionSelectors: [
//       '0xb864594e',
//       '0xe1d27d96',
//       '0x03105b04', approveToken(address,address)
//       '0xfd0aa031',
//       '0x8da5cb5b', ideal_warn_timed(uint256,uint128) owner()
//       '0x5d907379',rebaseOptIn(address)
//       '0xe6260307',rebaseOptOut(address)
//       '0x715018a6',
//       '0x821b22c5', //
//       '0xdf12d2d9', //
//       '0xf2fde38b',  transferOwnership(address)
//       contract: [Contract],
//       remove: [Function: remove],
//       get: [Function: get]
//     ]
//   }
// ]
