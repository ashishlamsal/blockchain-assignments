//SPDX-License-Identifier:MIT
pragma solidity ^0.8.4;

contract Todo {
    address owner;

    /*
    Create struct called task
    The struct has 3 fields : id,title,Completed
    Choose the appropriate variable type for each field.
    */
    struct Task {
        uint256 id;
        string title;
        bool completed;
    }

    // Create a counter to keep track of added tasks
    uint256 counter;

    /*
    create a mapping that maps the counter created above with the struct taskcount
    key should of type integer
    */
    mapping(uint256 => Task) tasks;

    /*
    Define a constructor
    the constructor takes no arguments
    Set the owner to the creator of the contract
    Set the counter to  zero
    */
    constructor() {
        owner = msg.sender;
        counter = 0;
    }

    /*
    Define 2 events
    taskadded should provide information about the title of the task and the id of the task
    taskcompleted should provide information about task status and the id of the task
    */
    event taskadded(string title, uint256 id);
    event taskcompleted(bool status, uint256 id);

    /*
        Create a modifier that throws an error if the msg.sender is not the owner.
    */
    modifier checkowner() {
        require(owner == msg.sender, "Only creator can access this function");
        _;
    }

    /*
    Define a function called addTask()
    This function allows anyone to add task
    This function takes one argument , title of the task
    Be sure to check :
    taskadded event is emitted
     */
    function addTask(string memory title) public checkowner {
        tasks[counter] = Task(counter, title, false);
        emit taskadded(title, counter);
        counter++;
    }

    /*Define a function  to get total number of task added in this contract*/
    function getTotal() public view returns (uint256) {
        return counter;
    }

    /**
    Define a function gettask()
    This function takes 1 argument ,task id and
    returns the task name ,task id and status of the task
    */
    function getTask(uint256 id)
        public
        view
        returns (
            string memory,
            uint256,
            bool
        )
    {
        require(id < counter, "Task does not exist");
        return (tasks[id].title, tasks[id].id, tasks[id].completed);
    }

    /**Define a function marktaskcompleted()
    This function takes 1 argument , task id and
    set the status of the task to completed
    Be sure to check:
    taskcompleted event is emitted
    */
    function markTaskCompleted(uint256 id) public checkowner {
        require(id < counter, "Task does not exist");
        tasks[id].completed = true;
        emit taskcompleted(true, id);
    }
}
