createCertificatesForOrg2() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p ../consortium/newcert/peerOrganizations/org2.amit.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/

   
  fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca.org2.amit.com --tls.certfiles ${PWD}/../consortium/fabric-ca/org2/tls-cert.pem
   
    echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2-amit-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2-amit-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2-amit-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-org2-amit-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/msp/config.yaml

  mkdir -p ../consortium/newcert/peerOrganizations/org2.amit.com/peers
  mkdir -p ../consortium/newcert/peerOrganizations/org2.amit.com/peers/peer0.org2.amit.com

  # --------------------------------------------------------------
  # Peer 0
  echo
  echo "## Generate the peer0 msp"
  echo
   
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.org2.amit.com -M ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/peers/peer0.org2.amit.com/msp --csr.hosts peer0.org2.amit.com --tls.certfiles ${PWD}/../consortium/fabric-ca/org2/tls-cert.pem
   

  cp ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/msp/config.yaml ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/peers/peer0.org2.amit.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo
   
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.org2.amit.com -M ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/peers/peer0.org2.amit.com/tls --enrollment.profile tls --csr.hosts peer0.org2.amit.com --csr.hosts localhost --tls.certfiles ${PWD}/../consortium/fabric-ca/org2/tls-cert.pem
   

  cp ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/peers/peer0.org2.amit.com/tls/tlscacerts/* ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/peers/peer0.org2.amit.com/tls/ca.crt
  cp ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/peers/peer0.org2.amit.com/tls/signcerts/* ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/peers/peer0.org2.amit.com/tls/server.crt
  cp ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/peers/peer0.org2.amit.com/tls/keystore/* ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/peers/peer0.org2.amit.com/tls/server.key

  mkdir ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/msp/tlscacerts
  cp ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/peers/peer0.org2.amit.com/tls/tlscacerts/* ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/tlsca
  cp ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/peers/peer0.org2.amit.com/tls/tlscacerts/* ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/tlsca/tlsca.org2.amit.com-cert.pem

  mkdir ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/ca
  cp ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/peers/peer0.org2.amit.com/msp/cacerts/* ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/ca/ca.org2.amit.com-cert.pem

  # --------------------------------------------------------------------------------
  #  Peer 1
  echo
  echo "## Generate the peer1 msp"
  echo

  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.org2.amit.com -M ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/peers/peer1.org2.amit.com/msp --csr.hosts peer1.org2.amit.com --tls.certfiles ${PWD}/../consortium/fabric-ca/org2/tls-cert.pem

  sleep 2
  cp ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/msp/config.yaml ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/peers/peer1.org2.amit.com/msp/config.yaml

  echo
  echo "## Generate the peer1-tls certificates"
  echo

  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:8054 --caname ca.org2.amit.com -M ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/peers/peer1.org2.amit.com/tls --enrollment.profile tls --csr.hosts peer1.org2.amit.com --csr.hosts localhost --tls.certfiles ${PWD}/../consortium/fabric-ca/org2/tls-cert.pem
  sleep 2

  cp ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/peers/peer1.org2.amit.com/tls/tlscacerts/* ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/peers/peer1.org2.amit.com/tls/ca.crt
  cp ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/peers/peer1.org2.amit.com/tls/signcerts/* ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/peers/peer1.org2.amit.com/tls/server.crt
  cp ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/peers/peer1.org2.amit.com/tls/keystore/* ${PWD}/../consortium/newcert/peerOrganizations/org2.amit.com/peers/peer1.org2.amit.com/tls/server.key

  # -------------------------------------------------------------------------------------------------
}

createCertificatesForOrg2
