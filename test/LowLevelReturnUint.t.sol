// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity 0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {LowLevelReturnUint} from "../src/LowLevelReturnUint.sol";

contract Bar1 {
    function bar() public returns (uint256 x) {
        x = 1234;
    }
}

contract Bar2 {
    function bar() public returns (uint256 x) {
        x = 1010;
    }
}

contract LowLevelReturnUintTest is Test {
    LowLevelReturnUint c;

    function setUp() public {
        c = new LowLevelReturnUint();
    }

    function test_LowLevelReturn1() public {
        Bar1 b1 = new Bar1();
        uint256 result = c.main(address(b1));
        assertEq(result, 1234);
    }

    function test_LowLevelReturn2() public {
        Bar2 b2 = new Bar2();
        uint256 result = c.main(address(b2));
        assertEq(result, 1010);
    }
}
