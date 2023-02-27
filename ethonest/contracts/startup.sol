
pragma solidity ^0.8.0;

contract Crowdfunding {
    // Struct to store information about a campaign
    struct Campaign {
        address payable owner; // Campaign owner
        uint256 targetAmount; // Target amount of Ether
        uint256 deadline; // Deadline for the campaign
        uint256 amountRaised; // Current amount of Ether raised
        mapping(address => uint256) contributions; // Contributions by address
        bool closed; // Flag to indicate if the campaign is closed
        Milestone[] milestones; // Array of campaign milestones
    }

    // Struct to store information about a campaign milestone
    struct Milestone {
        uint256 targetAmount; // Target amount of Ether for the milestone
        uint256 deadline; // Deadline for the milestone
        bool reached; // Flag to indicate if the milestone has been reached
    }

    // Array to store all campaigns
    Campaign[] public campaigns;

    // Function to create a new campaign
    function createCampaign(uint256 _targetAmount, uint256 _duration) public {
        Campaign memory newCampaign = Campaign({
            owner: payable(msg.sender),
            targetAmount: _targetAmount,
            deadline: block.timestamp + _duration,
            amountRaised: 0,
            closed: false,
            milestones: new Milestone[](0)
        });
        campaigns.push(newCampaign);
    }

    // Function to create a new milestone for a campaign
    function createMilestone(uint256 _campaignIndex, uint256 _targetAmount, uint256 _duration) public {
        Campaign storage campaign = campaigns[_campaignIndex];
        require(msg.sender == campaign.owner, "Only the campaign owner can create milestones");
        require(!campaign.closed, "Campaign is closed");
        Milestone memory newMilestone = Milestone({
            targetAmount: _targetAmount,
            deadline: block.timestamp + _duration,
            reached: false
        });
        campaign.milestones.push(newMilestone);
    }

    // Function to contribute to a campaign
    function contribute(uint256 _campaignIndex) public payable {
        Campaign storage campaign = campaigns[_campaignIndex];
        require(!campaign.closed, "Campaign is closed");
        require(block.timestamp < campaign.deadline, "Campaign deadline has passed");
        campaign.contributions[msg.sender] += msg.value;
        campaign.amountRaised += msg.value;
        checkMilestones(_campaignIndex);
    }

    // Function to check if a milestone has been reached
    function checkMilestones(uint256 _campaignIndex) internal {
        Campaign storage campaign = campaigns[_campaignIndex];
        for (uint i = 0; i < campaign.milestones.length; i++) {
            Milestone storage milestone = campaign.milestones[i];
            if (!milestone.reached && campaign.amountRaised >= milestone.targetAmount && block.timestamp < milestone.deadline) {
                milestone.reached = true;
                campaign.owner.transfer(milestone.targetAmount);
            }
        }
    }

    // Function to close a campaign and transfer funds to the owner if successful
    function closeCampaign(uint256 _campaignIndex) public {
Campaign storage campaign = campaigns[_campaignIndex];
require(!campaign.closed, "Campaign is already closed");
campaign.closed = true;
if (campaign.amountRaised >= campaign.targetAmount) {
campaign.owner.transfer(campaign.amountRaised);
}
}
// Function to get information about a campaign
function getCampaign(uint256 _campaignIndex) public view returns (
    address owner,
    uint256 targetAmount,
    uint256 deadline,
    uint256 amountRaised,
    bool closed,
    uint256 numMilestones
) {
    Campaign storage campaign = campaigns[_campaignIndex];
    owner = campaign.owner;
    targetAmount = campaign.targetAmount;
    deadline = campaign.deadline;
    amountRaised = campaign.amountRaised;
    closed = campaign.closed;
    numMilestones = campaign.milestones.length;
}

// Function to get information about a milestone
function getMilestone(uint256 _campaignIndex, uint256 _milestoneIndex) public view returns (
    uint256 targetAmount,
    uint256 deadline,
    bool reached
) {
    Milestone storage milestone = campaigns[_campaignIndex].milestones[_milestoneIndex];
    targetAmount = milestone.targetAmount;
    deadline = milestone.deadline;
    reached = milestone.reached;
}


// Import the required Ethereum libraries
pragma solidity ^0.8.0;

contract Crowdfunding {
    // Struct to store information about a campaign
    struct Campaign {
        address payable owner; // Campaign owner
        uint256 targetAmount; // Target amount of Ether
        uint256 deadline; // Deadline for the campaign
        uint256 amountRaised; // Current amount of Ether raised
        mapping(address => uint256) contributions; // Contributions by address
        bool closed; // Flag to indicate if the campaign is closed
        Milestone[] milestones; // Array of campaign milestones
    }

    // Struct to store information about a campaign milestone
    struct Milestone {
        uint256 targetAmount; // Target amount of Ether for the milestone
        uint256 deadline; // Deadline for the milestone
        bool reached; // Flag to indicate if the milestone has been reached
    }

    // Array to store all campaigns
    Campaign[] public campaigns;

    // Function to create a new campaign
    function createCampaign(uint256 _targetAmount, uint256 _duration) public {
        Campaign memory newCampaign = Campaign({
            owner: payable(msg.sender),
            targetAmount: _targetAmount,
            deadline: block.timestamp + _duration,
            amountRaised: 0,
            closed: false,
            milestones: new Milestone[](0)
        });
        campaigns.push(newCampaign);
    }

    // Function to create a new milestone for a campaign
    function createMilestone(uint256 _campaignIndex, uint256 _targetAmount, uint256 _duration) public {
        Campaign storage campaign = campaigns[_campaignIndex];
        require(msg.sender == campaign.owner, "Only the campaign owner can create milestones");
        require(!campaign.closed, "Campaign is closed");
        Milestone memory newMilestone = Milestone({
            targetAmount: _targetAmount,
            deadline: block.timestamp + _duration,
            reached: false
        });
        campaign.milestones.push(newMilestone);
    }

    // Function to contribute to a campaign
    function contribute(uint256 _campaignIndex) public payable {
        Campaign storage campaign = campaigns[_campaignIndex];
        require(!campaign.closed, "Campaign is closed");
        require(block.timestamp < campaign.deadline, "Campaign deadline has passed");
        campaign.contributions[msg.sender] += msg.value;
        campaign.amountRaised += msg.value;
        checkMilestones(_campaignIndex);
    }

    // Function to check if a milestone has been reached
    function checkMilestones(uint256 _campaignIndex) internal {
        Campaign storage campaign = campaigns[_campaignIndex];
        for (uint i = 0; i < campaign.milestones.length; i++) {
            Milestone storage milestone = campaign.milestones[i];
            if (!milestone.reached && campaign.amountRaised >= milestone.targetAmount && block.timestamp < milestone.deadline) {
                milestone.reached = true;
                campaign.owner.transfer(milestone.targetAmount);
            }
        }
    }

    // Function to close a campaign and transfer funds to the owner if successful
    function closeCampaign(uint256 _campaignIndex) public {
Campaign storage campaign = campaigns[_campaignIndex];
require(!campaign.closed, "Campaign is already closed");
campaign.closed = true;
if (campaign.amountRaised >= campaign.targetAmount) {
campaign.owner.transfer(campaign.amountRaised);
}
}
// Function to get information about a campaign
function getCampaign(uint256 _campaignIndex) public view returns (
    address owner,
    uint256 targetAmount,
    uint256 deadline,
    uint256 amountRaised,
    bool closed,
    uint256 numMilestones
) {
    Campaign storage campaign = campaigns[_campaignIndex];
    owner = campaign.owner;
    targetAmount = campaign.targetAmount;
    deadline = campaign.deadline;
    amountRaised = campaign.amountRaised;
    closed = campaign.closed;
    numMilestones = campaign.milestones.length;
}

// Function to get information about a milestone
function getMilestone(uint256 _campaignIndex, uint256 _milestoneIndex) public view returns (
    uint256 targetAmount,
    uint256 deadline,
    bool reached
) {
    Milestone storage milestone = campaigns[_campaignIndex].milestones[_milestoneIndex];
    targetAmount = milestone.targetAmount;
    deadline = milestone.deadline;
    reached = milestone.reached;
}


// Import the required Ethereum libraries
pragma solidity ^0.8.0;

contract Crowdfunding {
    // Struct to store information about a campaign
    struct Campaign {
        address payable owner; // Campaign owner
        uint256 targetAmount; // Target amount of Ether
        uint256 deadline; // Deadline for the campaign
        uint256 amountRaised; // Current amount of Ether raised
        mapping(address => uint256) contributions; // Contributions by address
        bool closed; // Flag to indicate if the campaign is closed
        Milestone[] milestones; // Array of campaign milestones
    }

    // Struct to store information about a campaign milestone
    struct Milestone {
        uint256 targetAmount; // Target amount of Ether for the milestone
        uint256 deadline; // Deadline for the milestone
        bool reached; // Flag to indicate if the milestone has been reached
    }

    // Array to store all campaigns
    Campaign[] public campaigns;

    // Function to create a new campaign
    function createCampaign(uint256 _targetAmount, uint256 _duration) public {
        Campaign memory newCampaign = Campaign({
            owner: payable(msg.sender),
            targetAmount: _targetAmount,
            deadline: block.timestamp + _duration,
            amountRaised: 0,
            closed: false,
            milestones: new Milestone[](0)
        });
        campaigns.push(newCampaign);
    }

    // Function to create a new milestone for a campaign
    function createMilestone(uint256 _campaignIndex, uint256 _targetAmount, uint256 _duration) public {
        Campaign storage campaign = campaigns[_campaignIndex];
        require(msg.sender == campaign.owner, "Only the campaign owner can create milestones");
        require(!campaign.closed, "Campaign is closed");
        Milestone memory newMilestone = Milestone({
            targetAmount: _targetAmount,
            deadline: block.timestamp + _duration,
            reached: false
        });
        campaign.milestones.push(newMilestone);
    }

    // Function to contribute to a campaign
    function contribute(uint256 _campaignIndex) public payable {
        Campaign storage campaign = campaigns[_campaignIndex];
        require(!campaign.closed, "Campaign is closed");
        require(block.timestamp < campaign.deadline, "Campaign deadline has passed");
        campaign.contributions[msg.sender] += msg.value;
        campaign.amountRaised += msg.value;
        checkMilestones(_campaignIndex);
    }

    // Function to check if a milestone has been reached
    function checkMilestones(uint256 _campaignIndex) internal {
        Campaign storage campaign = campaigns[_campaignIndex];
        for (uint i = 0; i < campaign.milestones.length; i++) {
            Milestone storage milestone = campaign.milestones[i];
            if (!milestone.reached && campaign.amountRaised >= milestone.targetAmount && block.timestamp < milestone.deadline) {
                milestone.reached = true;
                campaign.owner.transfer(milestone.targetAmount);
            }
        }
    }

    // Function to close a campaign and transfer funds to the owner if successful
    function closeCampaign(uint256 _campaignIndex) public {
Campaign storage campaign = campaigns[_campaignIndex];
require(!campaign.closed, "Campaign is already closed");
campaign.closed = true;
if (campaign.amountRaised >= campaign.targetAmount) {
campaign.owner.transfer(campaign.amountRaised);
}
}
// Function to get information about a campaign
function getCampaign(uint256 _campaignIndex) public view returns (
    address owner,
    uint256 targetAmount,
    uint256 deadline,
    uint256 amountRaised,
    bool closed,
    uint256 numMilestones
) {
    Campaign storage campaign = campaigns[_campaignIndex];
    owner = campaign.owner;
    targetAmount = campaign.targetAmount;
    deadline = campaign.deadline;
    amountRaised = campaign.amountRaised;
    closed = campaign.closed;
    numMilestones = campaign.milestones.length;
}

// Function to get information about a milestone
function getMilestone(uint256 _campaignIndex, uint256 _milestoneIndex) public view returns (
    uint256 targetAmount,
    uint256 deadline,
    bool reached
) {
    Milestone storage milestone = campaigns[_campaignIndex].milestones[_milestoneIndex];
    targetAmount = milestone.targetAmount;
    deadline = milestone.deadline;
    reached = milestone.reached;
}


