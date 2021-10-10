from scripts.helpful_scripts import get_account, fund_with_link, get_contract
from brownie import EmojiCollectible, config, network

def deploy_and_create():
    account = get_account()
    emoji_collectible = EmojiCollectible.deploy(
        get_contract("vrf_coordinator"),
        get_contract("link_token"),
        config["networks"][network.show_active()]["keyhash"], 
        {"from": account}
    )
    fund_with_link(emoji_collectible.address)
    creating_tx = emoji_collectible.createCollectible({"from": account})
    creating_tx.wait(1)
    return emoji_collectible

def main():
    deploy_and_create()