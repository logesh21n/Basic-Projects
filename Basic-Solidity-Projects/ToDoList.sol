// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;

contract ToDoList {
    // Event emitted when a task is added
    event AddTask(address indexed recipient, uint256 indexed taskId);
    // Event emitted when a task is deleted
    event DeleteTask(uint256 indexed taskId, bool isDeleted);

    // Struct to represent a task
    struct Task {
        uint id; // Unique identifier for the task
        string taskText; // Text content of the task
        bool isDeleted; // Flag indicating if the task is marked as deleted
    }

    // Array to store all tasks
    Task[] private tasks;

    // Mapping to track owner of each task
    mapping(uint => address) taskToOwner;

    /**
     * @dev Add a new task to the to-do list
     * @param taskText The text content of the task
     * @param isDeleted Flag indicating if the task is marked as deleted
     */
    function addTask(string calldata taskText, bool isDeleted) external {
        uint taskId = tasks.length; // Assign the new task ID
        tasks.push(Task(taskId, taskText, isDeleted)); // Create a new task and add it to the array
        taskToOwner[taskId] = msg.sender; // Record the owner of the task
        emit AddTask(msg.sender, taskId); // Emit an event to indicate that a task has been added
    }

    /**
     * @dev Retrieve tasks owned by the caller
     * @return An array of tasks belonging to the caller
     */
    function getTask() external view returns (Task[] memory) {
        // Create a temporary array to store tasks
        Task[] memory temporary = new Task[](tasks.length);
        uint counter = 0;
        // Loop through all tasks
        for (uint i = 0; i < tasks.length; i++) {
            // Check if the task belongs to the caller and is not marked as deleted
            if (taskToOwner[i] == msg.sender && tasks[i].isDeleted == false) {
                temporary[counter] = tasks[i]; // Add the task to the temporary array
                counter++; // Increment the counter
            }
        }
        // Create a new array to store the filtered tasks
        Task[] memory result = new Task[](counter);
        // Copy tasks from the temporary array to the result array
        for (uint i = 0; i < counter; i++) {
            result[i] = temporary[i];
        }
        return result; // Return the filtered tasks
    }

    /**
     * @dev Mark a task as deleted
     * @param taskId The ID of the task to be deleted
     * @param isDeleted Flag indicating if the task is marked as deleted
     */
    function deleteTask(uint taskId, bool isDeleted) external {
        // Check if the caller is the owner of the task
        if (taskToOwner[taskId] == msg.sender) {
            tasks[taskId].isDeleted = isDeleted; // Mark the task as deleted
            emit DeleteTask(taskId, isDeleted); // Emit an event to indicate that a task has been deleted
        }
    }
}
