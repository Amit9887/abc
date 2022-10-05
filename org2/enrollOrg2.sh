#!/bin/bash


mkdir -p ../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/peers/peer0.org2.amit.com
createMSPPeer0() {
  # --------------------------------------------------------------
  # Peer 0
  echo
  echo "## Generate the peer0 msp"
  echo

  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.org2.amit.com -M ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/peers/peer0.org2.amit.com/msp --csr.hosts peer0.org2.amit.com --tls.certfiles ${PWD}/../consortium/fabric-ca/org2/tls-cert.pem
  sleep 2

  cp ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/msp/config.yaml ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/peers/peer0.org2.amit.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo

  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.org2.amit.com -M ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/peers/peer0.org2.amit.com/tls --enrollment.profile tls --csr.hosts peer0.org2.amit.com --csr.hosts localhost --tls.certfiles ${PWD}/../consortium/fabric-ca/org2/tls-cert.pem

  sleep 2
  cp ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/peers/peer0.org2.amit.com/tls/tlscacerts/* ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/peers/peer0.org2.amit.com/tls/ca.crt
  cp ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/peers/peer0.org2.amit.com/tls/signcerts/* ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/peers/peer0.org2.amit.com/tls/server.crt
  cp ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/peers/peer0.org2.amit.com/tls/keystore/* ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/peers/peer0.org2.amit.com/tls/server.key

  mkdir ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/msp/tlscacerts
  cp ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/peers/peer0.org2.amit.com/tls/tlscacerts/* ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/tlsca
  cp ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/peers/peer0.org2.amit.com/tls/tlscacerts/* ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/tlsca/tlsca.org2.amit.com-cert.pem

  mkdir ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/ca
  cp ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/peers/peer0.org2.amit.com/msp/cacerts/* ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/ca/ca.org2.amit.com-cert.pem

}
createMSPPeer1() {
  # --------------------------------------------------------------------------------
  #  Peer 1
  echo
  echo "## Generate the peer1 msp"
  echo

  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.org2.amit.com -M ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/peers/peer1.org2.amit.com/msp --csr.hosts peer1.org2.amit.com --tls.certfiles ${PWD}/../consortium/fabric-ca/org2/tls-cert.pem

  sleep 2
  cp ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/msp/config.yaml ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/peers/peer1.org2.amit.com/msp/config.yaml

  echo
  echo "## Generate the peer1-tls certificates"
  echo

  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.org2.amit.com -M ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/peers/peer1.org2.amit.com/tls --enrollment.profile tls --csr.hosts peer1.org2.amit.com --csr.hosts localhost --tls.certfiles ${PWD}/../consortium/fabric-ca/org2/tls-cert.pem
  sleep 2

  cp ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/peers/peer1.org2.amit.com/tls/tlscacerts/* ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/peers/peer1.org2.amit.com/tls/ca.crt
  cp ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/peers/peer1.org2.amit.com/tls/signcerts/* ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/peers/peer1.org2.amit.com/tls/server.crt
  cp ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/peers/peer1.org2.amit.com/tls/keystore/* ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/peers/peer1.org2.amit.com/tls/server.key
}
generateUserMSP() {
  mkdir -p ../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/users
  mkdir -p ../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/users/User1@org2.amit.com

  echo
  echo "## Generate the user msp"
  echo

  fabric-ca-client enroll -u https://user1:user1pw@localhost:8054 --caname ca.org2.amit.com -M ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/users/User1@org2.amit.com/msp --tls.certfiles ${PWD}/../consortium/fabric-ca/org2/tls-cert.pem
  sleep 2

  mkdir -p ../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/users/Admin@org2.amit.com

}
generateAdminMSP() {
  echo
  echo "## Generate the org admin msp"
  echo

  fabric-ca-client enroll -u https://org2admin:org2adminpw@localhost:8054 --caname ca.org2.amit.com -M ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/users/Admin@org2.amit.com/msp --tls.certfiles ${PWD}/../consortium/fabric-ca/org2/tls-cert.pem

  cp ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/msp/config.yaml ${PWD}/../consortium/crypto-config-ca/peerOrganizations/org2.amit.com/users/Admin@org2.amit.com/msp/config.yaml
}
createMSPPeer0
createMSPPeer1
generateUserMSP
generateAdminMSP
