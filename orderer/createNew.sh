createcertificatesOrderer(){ 
  echo
  echo "Enroll the CA admin"
  echo

  mkdir -p ../consortium/newcert/ordererOrganizations/amit.com
  export FABRIC_CA_CLIENT_HOME=${PWD}/../consortium/newcert/ordererOrganizations/amit.com

  fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname ca-orderer --tls.certfiles ${PWD}/../consortium/fabric-ca/ordererOrg/tls-cert.pem
  sleep 2


# ----------------------------------------------------------------------------------------------------

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../consortium/newcert/ordererOrganizations/amit.com/msp/config.yaml
  sleep 2

}

orderer0MSP() {

  mkdir -p ../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer0.amit.com

  echo
  echo "## Generate the orderer0 msp"
  echo

  fabric-ca-client enroll -u https://orderer0:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer0.amit.com/msp --csr.hosts orderer0.amit.com --csr.hosts localhost --tls.certfiles ${PWD}/../consortium/fabric-ca/ordererOrg/tls-cert.pem

  sleep 2

  cp ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/msp/config.yaml ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer0.amit.com/msp/config.yaml

  echo
  echo "## Generate the orderer0-tls certificates"
  echo

  fabric-ca-client enroll -u https://orderer0:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer0.amit.com/tls --enrollment.profile tls --csr.hosts orderer0.amit.com --csr.hosts localhost --tls.certfiles ${PWD}/../consortium/fabric-ca/ordererOrg/tls-cert.pem

  sleep 2

  cp ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer0.amit.com/tls/tlscacerts/* ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer0.amit.com/tls/ca.crt
  cp ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer0.amit.com/tls/signcerts/* ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer0.amit.com/tls/server.crt
  cp ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer0.amit.com/tls/keystore/* ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer0.amit.com/tls/server.key

  mkdir -p ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer0.amit.com/msp/tlscacerts
  cp ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer0.amit.com/tls/tlscacerts/* ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer0.amit.com/msp/tlscacerts/tlsca.amit.com-cert.pem

  mkdir -p ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/msp/tlscacerts
  cp ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer0.amit.com/tls/tlscacerts/* ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/msp/tlscacerts/tlsca.amit.com-cert.pem

}

orderer1MSP() {

  mkdir -p ../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer1.amit.com

  echo
  echo "## Generate the orderer1 msp"
  echo

  fabric-ca-client enroll -u https://orderer1:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer1.amit.com/msp --csr.hosts orderer1.amit.com --csr.hosts localhost --tls.certfiles ${PWD}/../consortium/fabric-ca/ordererOrg/tls-cert.pem

  sleep 2

  cp ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/msp/config.yaml ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer1.amit.com/msp/config.yaml

  echo
  echo "## Generate the orderer1-tls certificates"
  echo

  fabric-ca-client enroll -u https://orderer1:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer1.amit.com/tls --enrollment.profile tls --csr.hosts orderer1.amit.com --csr.hosts localhost --tls.certfiles ${PWD}/../consortium/fabric-ca/ordererOrg/tls-cert.pem

  sleep 2

  cp ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer1.amit.com/tls/tlscacerts/* ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer1.amit.com/tls/ca.crt
  cp ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer1.amit.com/tls/signcerts/* ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer1.amit.com/tls/server.crt
  cp ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer1.amit.com/tls/keystore/* ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer1.amit.com/tls/server.key

  mkdir -p ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer1.amit.com/msp/tlscacerts
  cp ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer1.amit.com/tls/tlscacerts/* ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer1.amit.com/msp/tlscacerts/tlsca.amit.com-cert.pem

  mkdir -p ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/msp/tlscacerts
  cp ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer1.amit.com/tls/tlscacerts/* ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/msp/tlscacerts/tlsca.amit.com-cert.pem

}

orderer2MSP() {

  mkdir -p ../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer2.amit.com

  echo
  echo "## Generate the orderer2 msp"
  echo

  fabric-ca-client enroll -u https://orderer2:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer2.amit.com/msp --csr.hosts orderer2.amit.com --csr.hosts localhost --tls.certfiles ${PWD}/../consortium/fabric-ca/ordererOrg/tls-cert.pem

  sleep 2

  cp ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/msp/config.yaml ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer2.amit.com/msp/config.yaml

  echo
  echo "## Generate the orderer2-tls certificates"
  echo

  fabric-ca-client enroll -u https://orderer2:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer2.amit.com/tls --enrollment.profile tls --csr.hosts orderer2.amit.com --csr.hosts localhost --tls.certfiles ${PWD}/../consortium/fabric-ca/ordererOrg/tls-cert.pem

  sleep 2

  cp ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer2.amit.com/tls/tlscacerts/* ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer2.amit.com/tls/ca.crt
  cp ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer2.amit.com/tls/signcerts/* ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer2.amit.com/tls/server.crt
  cp ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer2.amit.com/tls/keystore/* ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer2.amit.com/tls/server.key

  mkdir -p ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer2.amit.com/msp/tlscacerts
  cp ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer2.amit.com/tls/tlscacerts/* ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer2.amit.com/msp/tlscacerts/tlsca.amit.com-cert.pem

  mkdir -p ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/msp/tlscacerts
  cp ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/orderers/orderer2.amit.com/tls/tlscacerts/* ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/msp/tlscacerts/tlsca.amit.com-cert.pem

}

adminMSP() {
  mkdir -p ../consortium/newcert/ordererOrganizations/amit.com/users
  mkdir -p ../consortium/newcert/ordererOrganizations/amit.com/users/Admin@amit.com

  echo
  echo "## Generate the admin msp"
  echo

  fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:9054 --caname ca-orderer -M ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/users/Admin@amit.com/msp --tls.certfiles ${PWD}/../consortium/fabric-ca/ordererOrg/tls-cert.pem

  sleep 2
  cp ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/msp/config.yaml ${PWD}/../consortium/newcert/ordererOrganizations/amit.com/users/Admin@amit.com/msp/config.yaml

}

createcertificatesOrderer
orderer0MSP
orderer1MSP
orderer2MSP
adminMSP
