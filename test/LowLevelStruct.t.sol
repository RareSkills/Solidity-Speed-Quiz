// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {LowLevelStruct} from "../src/LowLevelStruct.sol";

contract P {

    struct Point {
        uint256 x;
        uint256 y;
    }

    Point p;
    bool shouldRevert;

    constructor(uint256 x, uint256 y, bool _shouldRevert) {
        p = Point({x: x, y: y});
        shouldRevert = _shouldRevert;
    }

    function point() public view returns (Point memory) {
        if (shouldRevert) {
            revert();
        }
        return p;
    }
}

contract LowLevelStructTest is Test {
    LowLevelStruct c;

    function setUp() public {
        c = new LowLevelStruct();
    }

    function test_LowLevelStruct(uint256 x, uint256 y) public {
        P p = new P(x, y, false);
        (uint256 x1, uint256 y1) = c.main(address(p));
        assertEq(x1, x);
        assertEq(y1, y);
    }

    function test_LowLevelStruct_revert() public {
        P p = new P(1, 2, true);
        vm.expectRevert();
        c.main(address(p));
    }
} 
