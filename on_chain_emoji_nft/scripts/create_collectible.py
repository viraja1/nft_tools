#!/usr/bin/python3
from brownie import EmojiCollectible
from scripts.helpful_scripts import fund_with_link, get_account
import time


def main():
    account = get_account()
    emoji_collectible = EmojiCollectible[len(EmojiCollectible,) - 1]
    fund_with_link(emoji_collectible.address)
    transaction = emoji_collectible.createCollectible({"from": account})
    print("Waiting on second transaction...")
    # wait for the 2nd transaction
    transaction.wait(1)
    time.sleep(45)

