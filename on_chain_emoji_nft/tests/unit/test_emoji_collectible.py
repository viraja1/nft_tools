import pytest
from brownie import network, EmojiCollectible
from scripts.helpful_scripts import (
    get_account,
    get_contract,
    LOCAL_BLOCKCHAIN_ENVIRONMENTS,
)

def test_can_create_emoji_collectible(
    get_keyhash,
    chainlink_fee,
):
    # Arrange
    if network.show_active() not in LOCAL_BLOCKCHAIN_ENVIRONMENTS:
        pytest.skip("Only for local testing")
    emoji_collectible = EmojiCollectible.deploy(
        get_contract("vrf_coordinator").address,
        get_contract("link_token").address,
        get_keyhash,
        {"from": get_account()},
    )
    get_contract("link_token").transfer(
        emoji_collectible.address, chainlink_fee * 3, {"from": get_account()}
    )
    # Act
    transaction_receipt = emoji_collectible.createCollectible(
       {"from": get_account()}
    )
    requestId = transaction_receipt.events["requestedCollectible"]["requestId"]
    assert isinstance(transaction_receipt.txid, str)
    get_contract("vrf_coordinator").callBackWithRandomness(
        requestId, 777, emoji_collectible.address, {"from": get_account()}
    )
    assert emoji_collectible.ownerOf(21) == get_account()
