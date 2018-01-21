
/* This is Development of the Cross-Domain multi-stakeholder decision making 
 * It is implemented  using Distributed Ledger/contracts for P2P Bussinesses activities  
 * These Contracts are created by each Business unit  and it is distributed across etherium VMs/nodes
 *
 * 1.	Records are not communicated by a central authority and each node will be creating and distributing in ether-network 
 * 2.	The copies of each node is handled, processed independently.
 * 3.	Ledger/contract s are altered by each node independently in a Large Network. 
 * 4.	Distribution/sharing is unique. All Changes to Ledger/contract  happens and Verified in all the nodes 
 *  
 *  Miner in ethereum network verify each transaction 
 *  Mata-data of the 
 *  
 * We are proposing naval idea of "Proactive Big data analyzer as ethereum miner not to varify , But 
 * to Evaluate transaction history and Suggest Government" to do the proactive analysis to identify 
 *  1> Number of fraudulent behavior/Invalid accesses in project.
 *  1> Hotness association with department based on who's data is wrongly attempted 
 *   
 */


 
pragma solidity ^0.4.16;

/* Permissioned blochk chain */
contract LandRecordLedger {
    address public LandRecordCreator;
    uint LandRecordLedgerID;
    uint numOfLandRecordOwners;
    uint globalpropertyId;

    struct LandRecordOwner {
        /* Private key generate for each land owner as a process of blockchain
           mining */
        uint privatekey;
        uint AdharNumber;
        uint propertyId;
        uint sitenumber;
        uint areaSize;

    }

    // This declares a state variable that
    // stores a `LandRecord` struct for each possible address.
    mapping(address => LandRecordOwner) public LandRecords;

    function LandRecordLedger() public {
        LandRecordCreator = msg.sender;
        LandRecordLedgerID = LandRecordLedgerID + 1;
    }
    function addLandRecord(address landOwner) public {
        LandRecordOwner storage sender = LandRecords[msg.sender];
        LandRecords[landOwner].privatekey = sender.privatekey;
        LandRecords[landOwner].AdharNumber = sender.AdharNumber;
        LandRecords[landOwner].propertyId = globalpropertyId + 1;
        LandRecords[landOwner].sitenumber = sender.sitenumber;
        LandRecords[landOwner].areaSize = sender.areaSize;
        numOfLandRecordOwners = numOfLandRecordOwners + 1;
    }
    function getLandRecord(address landOwner) public returns
(LandRecordOwner land)
    {
        land.privatekey = LandRecords[landOwner].privatekey;
        land.AdharNumber = LandRecords[landOwner].AdharNumber;
        land.propertyId = LandRecords[landOwner].propertyId;
        land.sitenumber = LandRecords[landOwner].sitenumber;
        land.areaSize = LandRecords[landOwner].areaSize;
    }

    function getNumberoflandRecordOwners() public returns(uint)
    {
        return numOfLandRecordOwners;
    }

    function verifyPropertyDetail(uint AdharNumber, uint propertyId,
address landOwner) public returns (bool)
    {
        if (LandRecords[landOwner].propertyId == propertyId){
             if(LandRecords[landOwner].AdharNumber == AdharNumber){
                 return true;
                 }
                 else
                 {
                     return false;
                 }
            }

    }
}

contract surveyDept {
    uint  propertyId;
    uint numberOfProperties;
    address public addrLandRecordLedger;

    struct propertySurvey {
        uint propertyId;
        uint numAssest;
        uint numTrees;
    }
    mapping(uint  => propertySurvey) public propertySurveyArr;

    function surveyDept() public{
        LandRecordLedger landRecLed = LandRecordLedger(addrLandRecordLedger);
        numberOfProperties = landRecLed.getNumberoflandRecordOwners();
    }

    function getnumTrees(uint) returns (uint) {
        return 100;
    }

    function getnumAsset(uint) returns (uint) {
        return 10;
    }

    function mapperOfPropertyIdToPropertySurvey() public {
       for (uint i = 1; i<= numberOfProperties; i++) {
           propertySurveyArr[i].propertyId = i;
           // propertySurveyArr[i].numAsset =
getnumAsset(propertySurveyArr[i].propertyId);
           propertySurveyArr[i].numTrees =
getnumTrees(propertySurveyArr[i].propertyId);
       }

    }
}


contract Farmer{
    uint[] propertyId;
    uint numOfRequest;
    uint applicationId;
    uint AdharNumber;
    address public farmerAddress;
    struct treeCutRequest {
        uint propertyId;
        uint numOfTreesToBeCut;

    }
    mapping(uint  => treeCutRequest) public treeCutRequestArr;

    function Farmer() public {
        farmerAddress = msg.sender;
        AdharNumber = 12;
        applicationId = AdharNumber + 1;
        numOfRequest = 3;
    }


    function mapNumOfRequestToTreeCutRequest() public {
        for (uint i = 1; i<=numOfRequest; i++) {
            treeCutRequestArr[i].propertyId = 100 + i;
            treeCutRequestArr[i].numOfTreesToBeCut = 5 + i;

        }

    }

    function getFarmeraddress() returns(address) {
        return farmerAddress;

    }
    function getApplicationId() returns(uint) {
        return applicationId;
    }
    function getAdharNumber() returns(uint){
        return AdharNumber;
    }
    function getFirstProperty() returns(uint) {
        return treeCutRequestArr[0].propertyId;
    }
    function getSecondProperty() returns(uint) {
        return treeCutRequestArr[1].propertyId;
    }
    function getThirdProperty() returns(uint) {
        return treeCutRequestArr[2].propertyId;
    }

    /*Forest.sent.watch({}, '', function(error, result) {
        if(!error){
            return 1;
        }
    })*/
}

contract Forest {
    address public addressInfo;
    address public addrFarmer;
    address public addrLandRecordLedger;
    address public ForestContractCreator;
    address public addrBescom;
    uint numberOfFarmerRequest;
    uint applicationId;
    uint AdharNumber;
    uint[] propertyId;

    struct applicationRequest{
        uint applicationId;
        /**
         * status could be in one of the three states
         * In-progress, accept, reject
         * Application can get rejected due to the following reason
         * 1. property details specified by the farmer in application
         * doesn't belongs to him
         * 2. False information provided on no. of trees, treeType, etc..'
         **/
        uint status;
    }

    struct approvalandTransportData {
        uint applicationId; // application iD for which approval had happened.
        uint approvalId; //is created based on Time stamp and farmer Adhar Number.
        uint treeFallschedule;
        uint treeFallObservedimpacts; // - Bhuvan Sattelite pictures
// observed impacts (power line passed trugh that land)

        uint vehicleRegistrationNumber;
        string SawmillRouteMap;
        uint permitfor_transit;
    }

    struct woodLotDetails {
         uint woodlotId;
        /*
         * Each Tree to be fallen needs to be analyzed for its quality
         * like weight of the Log,Age of the tree and
         * string.
         */

        uint typeOftree;

        /* It contins AGE,Moister content,len,weight of the each log
// from the woodlot */
        uint woodqualityString;

        }

    mapping(uint => woodLotDetails) public woodLotDetailsArr;
    mapping(uint  => applicationRequest) public applicationRequestArr;
    event sent(address toAddress, uint status);

    function Forest() public {

        ForestContractCreator = msg.sender;
        Farmer farmerInfo = Farmer(addrFarmer);
        addressInfo = farmerInfo.getFarmeraddress();
        applicationId = farmerInfo.getApplicationId();
        AdharNumber = farmerInfo.getAdharNumber();

        LandRecordLedger landrecledg = LandRecordLedger(addrLandRecordLedger);
        Bescom bescomobj = Bescom(addrBescom);
        numberOfFarmerRequest = 1;

        for (uint i = 0; i < numberOfFarmerRequest; i++) {
            applicationRequestArr[i].applicationId = applicationId;
        }

        propertyId[0] = farmerInfo.getFirstProperty();
        propertyId[1] = farmerInfo.getSecondProperty();
        propertyId[3] = farmerInfo.getThirdProperty();

        bool verify =
landrecledg.verifyPropertyDetail(AdharNumber,propertyId[0],addressInfo);
        bool verify1 =
landrecledg.verifyPropertyDetail(AdharNumber,propertyId[1],addressInfo);
        bool verify2 =
landrecledg.verifyPropertyDetail(AdharNumber,propertyId[2],addressInfo);
        bool verify3 = bescomobj.verifyBescomImpact(applicationId);
        if (!verify || !verify1 || !verify2 || !verify3) {
            applicationRequestArr[0].status = 1; // 1 for Rejected, 0
// for accepted
        }
        else
        {
            applicationRequestArr[0].status = 0;

        }

        sent(addressInfo, applicationRequestArr[0].status);
    }
    function setapprovalandTransportData() {
        approvalandTransportData  altransData;
        altransData.applicationId = applicationId;
        altransData.approvalId = AdharNumber + 1000; //1000 seconds time stamp
        altransData.vehicleRegistrationNumber = 10; //get it from RTO
// contract present in block chain.
        altransData.SawmillRouteMap = "XYZ"; // Get this Direction
// from Google contracts in the block chain.
        altransData.permitfor_transit = 1; //Permin Trasit from RTO.

    }

    function setWoodLogDetails() {
        woodLotDetails woodDetails;
        uint numberOfWoodLots = 3;
        for (uint i = 0; i < numberOfWoodLots; i++ ) {
            woodDetails.woodlotId = i;
            woodDetails.typeOftree = 2; //Type of tree
            woodDetails.woodqualityString = 2;
        }

    }

    function getWoodLogDetails(uint woodlotID) returns (uint) {
        return woodLotDetailsArr[woodlotID].woodqualityString;
    }

}

contract sawmill {
    uint woodlotID;
    uint woodquality;
    address public addrForest;
    address public sawmillContractCreator;
    function sawmill() public {
        sawmillContractCreator = msg.sender;
        Forest forestInfo = Forest(addrForest);
        woodquality = forestInfo.getWoodLogDetails(1);

    }

}

contract Bescom {
    uint applicationId;
    uint percentageOfPowerDisruptionImpact;
    uint bescomApprovalStatus;

    function verifyBescomImpact(uint applicationId) returns(bool) {
        /*
         * Impact observed by the forest department needs to be Anayzed
         * wrt to power disruption.
         */
    }
}
 

