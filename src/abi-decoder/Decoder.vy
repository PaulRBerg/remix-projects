# @version ^0.4.1

@external
def __default__():
    pass

@external
@view
def test(a: uint256, b: Bytes[1024]):
    # For uint256 (32 bytes) + Bytes[32] (32 bytes) with ABI encoding overhead
    callData: Bytes[128] = slice(msg.data, 4, 128)

    # Create the encoded data - need to use larger buffer
    # encoded: Bytes[128] = abi_encode(a, b)
    encoded: Bytes[128] = abi_encode(a, slice(b, 0, 32))

    # Check assertions
    assert len(b) == 32  # 32 bytes = 1 EVM word
    assert keccak256(callData) == keccak256(encoded)
