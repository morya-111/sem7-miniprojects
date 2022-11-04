pragma solidity ^0.4.18;

contract Owned {
    address owner;
    
    function Owned() public {
        owner = msg.sender;
    }
    
   modifier onlyOwner {
       require(msg.sender == owner);
       _;
   }
}

contract LogSheet is Owned {
    
    struct Employee {
        uint grade;
        string fName;
        string lName;
        uint attendanceValue;
    }
    
    mapping (uint => Employee) employeeList;
    uint[] public empDelList;
    
    event employeeCreationEvent(
       string fName,
       string lName,
       uint grade
    );
    
    function createEmployee(uint _empId, uint _grade, string _firstName, string _lastName) onlyOwner public {
        var employee = employeeList[_empId];
        
        employee.grade = _grade;
        employee.fName = _firstName;
        employee.lName = _lastName;
        employee.attendanceValue = 0;
        empDelList.push(_empId) -1;
        employeeCreationEvent(_firstName, _lastName, _grade);
    }
    
    function increaseLog(uint _empId) onlyOwner public {
        employeeList[_empId].attendanceValue = employeeList[_empId].attendanceValue+1;
    }
    
    function getEmployees() view public returns(uint[]) {
        return empDelList;
    }
    
    function getParticularEmployee(uint _empId) public view returns (string, string, uint, uint) {
        return (employeeList[_empId].fName, employeeList[_empId].lName, employeeList[_empId].grade, employeeList[_empId].attendanceValue);
    }

    function countEmployees() view public returns (uint) {
        return empDelList.length;
    }
    
}