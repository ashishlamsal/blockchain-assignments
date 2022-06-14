pragma solidity ^0.6.4;

contract cityPoll {
    struct City {
        string cityName;
        uint256 vote;
    }

    // mapping city Id with the City struct - cityId should be uint256
    mapping(uint256 => City) city;

    // mapping to check if the address/account has voted or not
    mapping(address => bool) hasVoted;

    address owner;
    uint256 public cityCount = 0; // number of city added

    constructor() public {
        // set contract caller as owner
        owner = msg.sender;

        //set some intitial cities.
        addCity("Kathmandu");
        addCity("Pokhara");
        addCity("Chitwan");
        addCity("Bhaktapur");
        addCity("Lalitpur");
    }

    function addCity(string memory _cityName) public {
        city[cityCount] = City({cityName: _cityName, vote: 0});
        cityCount++;
    }

    function vote(uint256 _cityID) public {
        //check if the city exists
        require(_cityID < cityCount, "City does not exist");

        //check if the address has voted
        require(!hasVoted[msg.sender], "You have already voted");

        //increment the vote count
        city[_cityID].vote++;

        //set the address has voted
        hasVoted[msg.sender] = true;
    }

    // get the city details through cityID
    function getCity(uint256 _cityID)
        public
        view
        returns (string memory, uint256)
    {
        //check if the city exists
        require(_cityID < cityCount, "City does not exist");

        return (city[_cityID].cityName, city[_cityID].vote);
    }

    // get the vote of the city with its ID
    function getVote(uint256 _cityID) public view returns (uint256) {
        //check if the city exists
        require(_cityID < cityCount, "City does not exist");

        return city[_cityID].vote;
    }
}
