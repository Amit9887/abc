#!/usr/bin/env bash

export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/../consortium/crypto-config-ca/ordererOrganizations/amit.com/orderers/orderer0.amit.com/msp/tlscacerts/tlsca.amit.com-cert.pem
export PEER0_ORG1_CA=${PWD}/../consortium/crypto-config-ca/peerOrganizations/org1.amit.com/peers/peer0.org1.amit.com/tls/ca.crt
export FABRIC_CFG_PATH=${PWD}/../config

export CHANNEL_NAME=mychannel

setGlobalsForPeer0Org1() {
  export CORE_PEER_LOCALMSPID="Org1MSP"
  export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG1_CA
  export CORE_PEER_MSPCONFIGPATH=${PWD}/../consortium/crypto-config-ca/peerOrganizations/org1.amit.com/users/Admin@org1.amit.com/msp
  export CORE_PEER_ADDRESS=localhost:7051
}

setGlobalsForPeer1Org1() {
  export CORE_PEER_LOCALMSPID="Org1MSP"
  export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG1_CA
  export CORE_PEER_MSPCONFIGPATH=${PWD}/../consortium/crypto-config-ca/peerOrganizations/org1.amit.com/users/Admin@org1.amit.com/msp
  export CORE_PEER_ADDRESS=localhost:8051

}

createChannel() {

  setGlobalsForPeer0Org1

  peer channel create -o localhost:7050 -c $CHANNEL_NAME \
    --ordererTLSHostnameOverride orderer0.amit.com \
    -f ../${CHANNEL_NAME}.tx --outputBlock ../${CHANNEL_NAME}.block \
    --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

}

joinChannel() {
  setGlobalsForPeer0Org1
  peer channel join -b ../$CHANNEL_NAME.block

  setGlobalsForPeer1Org1
  peer channel join -b ../$CHANNEL_NAME.block
}

updateAnchorPeers() {
  setGlobalsForPeer0Org1
  peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer0.amit.com -c $CHANNEL_NAME -f ./${CORE_PEER_LOCALMSPID}anchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

}
setGlobalsForPeer0Org1
sleep 2
setGlobalsForPeer1Org1
sleep 2
createChannel
sleep 2
joinChannel
sleep 2
updateAnchorPeers
