// SPDX-License-Identifier: MIT
pragma solidity >=0.8.29;

contract Decoder {
    fallback() external { }

    function test1(uint256 a, bytes calldata z) external pure {
        assert(z.length == 32); // 32 bytes = 1 EVM word
        uint256 end = 4 + 32 + z.length + 64; // 1 EVM word for a, 3 EVM words for z
        bytes memory callData = msg.data[4:end]; // calldata without selector
        bytes memory encoded = abi.encode(a, z);
        assert(keccak256(callData) == keccak256(encoded));
    }

    function test2(uint256 a, uint256 b, bytes calldata z) external pure {
        assert(z.length == 64); // 32 bytes = 1 EVM word
        uint256 end = 4 + 32 + z.length + 96; // 1 EVM word for a and b, 4 EVM words for z
        bytes memory callData = msg.data[4:end]; // calldata without selector
        bytes memory encoded = abi.encode(a, b, z);
        assert(keccak256(callData) == keccak256(encoded));
    }

    function test3(uint256 a, uint256 b, uint256 c, bytes calldata z) external pure {
        assert(z.length == 64); // 32 bytes = 1 EVM word
        uint256 end = 4 + 32 + z.length + 128; // 1 EVM word for a, b, and c, 5 EVM words for z
        bytes memory callData = msg.data[4:end]; // calldata without selector
        bytes memory encoded = abi.encode(a, b, c, z);
        assert(keccak256(callData) == keccak256(encoded));
    }
}
