// SPDX-License-Identifier: MIT
//
// Copyright (c) 2023 Furychain Foundation
//
// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following
// conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.

pragma solidity >=0.8.4;

import {IERC20} from "../../lib/IERC20.sol";
import {IERC20Module} from "../cosmos/precompile/ERC20Module.sol";

// An example of calling a precompile from the contract's constructor.
contract PrecompileConstructor {
    IERC20Module public immutable erc20Module = IERC20Module(0x0000000000000000000000000000000000696969);
    IERC20 public afury;
    string public denom;

    constructor() {
        bool success = erc20Module.transferCoinToERC20From("afury", msg.sender, msg.sender, 123456789);
        require(success, "failed to transfer afury");
        afury = erc20Module.erc20AddressForCoinDenom("afury");
        denom = erc20Module.coinDenomForERC20Address(afury);
        require(keccak256(abi.encodePacked(denom)) == keccak256(abi.encodePacked("afury")), "returned the wrong denom");
    }
}