#/usr/bin/env bash

chaincodeInfo() {
  export CHANNEL_NAME="mychannel"
  export CC_RUNTIME_LANGUAGE="golang"
  export CC_VERSION="1"
  export CC_SRC_PATH=../Chaincode/ndmc_bnd/NDMC-chaincode
  export CC_NAME="ndmc-bnd"
  export CC_SEQUENCE="1"

}
preSetupGO() {
  echo Vendoring Go dependencies ...
  pushd ../Chaincode/ndmc_bnd/NDMC-chaincode
  GO111MODULE=on go mod vendor
  popd
  echo Finished vendoring Go dependencies
}

export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/../consortium/crypto-config-ca/ordererOrganizations/amit.com/orderers/orderer0.amit.com/msp/tlscacerts/tlsca.amit.com-cert.pem
export PEER0_ORG1_CA=${PWD}/../consortium/crypto-config-ca/peerOrganizations/org1.amit.com/peers/peer0.org1.amit.com/tls/ca.crt
export FABRIC_CFG_PATH=${PWD}/../config

setGlobalsForPeer0Org1() {
  export CORE_PEER_LOCALMSPID="Org1MSP"
  export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG1_CA
  export CORE_PEER_MSPCONFIGPATH=${PWD}/../consortium/crypto-config-ca/peerOrganizations/org1.amit.com/users/Admin@org1.amit.com/msp
  export CORE_PEER_ADDRESS=localhost:7051
}

packageChaincode() {

  rm -rf ${CC_NAME}.tar.gz

  peer lifecycle chaincode package ${CC_NAME}.tar.gz --path ${CC_SRC_PATH} --lang ${CC_RUNTIME_LANGUAGE} --label ${CC_NAME}_${CC_VERSION}

}

installChaincode() {

  peer lifecycle chaincode install ${CC_NAME}.tar.gz

}

queryInstalled() {

  peer lifecycle chaincode queryinstalled >&log.txt

  cat log.txt

  PACKAGE_ID=$(sed -n "/${CC_NAME}_${CC_VERSION}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)

  echo PackageID is ${PACKAGE_ID}
}
approveForMyOrg1() {

  setGlobalsForPeer0Org1

  peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer0.amit.com --tls --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name ${CC_NAME} --version ${CC_VERSION} --package-id ${PACKAGE_ID} --sequence ${CC_SEQUENCE} --init-required

}

getblock() {
  peer channel getinfo -c mychannel -o localhost:7050 --ordererTLSHostnameOverride orderer0.amit.com --tls --cafile $ORDERER_CA
}

checkCommitReadyness() {

  peer lifecycle chaincode checkcommitreadiness --channelID $CHANNEL_NAME --name ${CC_NAME} --sequence ${CC_SEQUENCE} --version ${CC_VERSION} --init-required --output json

}
commitChaincodeDefination() {

  peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer0.amit.com --tls --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name ${CC_NAME} --peerAddresses localhost:7051 --tlsRootCertFiles $PEER0_ORG1_CA --sequence ${CC_SEQUENCE} --version ${CC_VERSION} --init-required

}

queryCommitted() {

  peer lifecycle chaincode querycommitted --channelID $CHANNEL_NAME --name ${CC_NAME} --output json

}
#chaincodeInvokeInit() 
{

  peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer0.amit.com --tls --cafile $ORDERER_CA --channelID $CHANNEL_NAME -n ${CC_NAME} --peerAddresses localhost:7051 --tlsRootCertFiles $PEER0_ORG1_CA --isInit -c '{"function": "initLedger","Args":[]}'

}

#insertTransaction()
 {

  peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer0.amit.com --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C $CHANNEL_NAME -n ${CC_NAME} --peerAddresses localhost:7051 --tlsRootCertFiles $PEER0_ORG1_CA -c '{"function": "createCar", "Args":["CAR101","Maruti","City","White", "Ammy"]}'

  sleep 2
}
#readTransaction() 
{
  echo "Reading a transaction"

  # Query all cars

  peer chaincode query -C $CHANNEL_NAME -n ${CC_NAME} -c '{"Args":["queryAllCars"]}'

  # Query Car by Id
  peer chaincode query -C $CHANNEL_NAME -n ${CC_NAME} -c '{"function": "queryCar","Args":["CAR101"]}'
}

lifecycleCommands() {
  packageChaincode
  sleep 2
  installChaincode
  sleep 2
  queryInstalled
  sleep 2
  approveForMyOrg1
  sleep 2
  getblock
  sleep 2
  checkCommitReadyness
  sleep 2
  commitChaincodeDefination
  sleep 2
  queryCommitted
  sleep 2
  chaincodeInvokeInit
  sleep 10
}
getInstallChaincodes() {

  peer lifecycle chaincode queryinstalled

}

preSetupGO
chaincodeInfo
setGlobalsForPeer0Org1
lifecycleCommands
insertTransaction
readTransaction
getInstallChaincodes
