#!/bin/bash

# System channel
SYS_CHANNEL="sys-channel"

# channel name defaults to "mychannel"
CHANNEL_NAME="mychannel"

echo $CHANNEL_NAME

# Generate System Genesis block
configtxgen -profile OrdererGenesis -configPath ../configtx -channelID $SYS_CHANNEL -outputBlock ../genesis.block

# Generate channel configuration block
configtxgen -profile BasicChannel -configPath ../configtx -outputCreateChannelTx ../$CHANNEL_NAME.tx -channelID $CHANNEL_NAME

echo "#######    Generating anchor peer update for Org1MSP  ##########"
configtxgen -profile BasicChannel -configPath ../configtx -outputAnchorPeersUpdate ../org1/Org1MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org1MSP

echo "#######    Generating anchor peer update for Org2MSP  ##########"
configtxgen -profile BasicChannel -configPath ../configtx -outputAnchorPeersUpdate ../org2/Org2MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org2MSP

sleep 2
