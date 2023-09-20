import ballerina/io;
import ballerina/http;

type Lecturer record{
    string Staff_No;
    string Staff_Name;
    string Office_No;
    string CoursesName;
};

type Course readonly & record{
    int CourseCode;
    string CourseName;
    int NQF;
};

public function main()returns error? {
    http:Client UserClient=check new ("localhost:9090/Staff");

    //user input
    io:println("Welcome to the management system");
    io:println("KeyWords:");
    io:println("add       -To Add a lecturer");
    io:println("showall   -To show all staff records:");
    io:println("update    -To update a staff records:");
    io:println("delete    -To Delete a staff record :");
    io:println("retrievebyStaffNo  -To retrieve lecturer by StaffNo   :");
    io:println("retrievebyCourse   -To retrieve lecturer by CourseName:");
    io:println("retrievebyOffice   -To retrieve lecturer by OfficeNo  :");
    string keyword=io:readln("Enter a Keyword: ");

    if keyword=="add"{
        Lecturer lecturer={Office_No: "", Staff_No: "", Staff_Name: "", CoursesName: ""};
        lecturer.Staff_No=io:readln("enter Staff_No: ");
        lecturer.Staff_Name=io:readln("enter Staff_Name: ");
        lecturer.Office_No=io:readln("enter Office_No: ");
        lecturer.CoursesName=io:readln("enter CourseName: ");
        string staff=AddStaff();
        lecturer=[staff];
        check CreateStaff(UserClient,lecturer);
    } else if keyword == "showall"{
        check getStaff(UserClient);
    } else if keyword == "update"{

    } else if keyword == "delete"{

    } else if keyword == "retrievebyStaffNo"{

    } else if keyword == "retrievebyCourse"{

    } else if keyword == "retrievebyOffice"{

    } else {

    }
};
public function getStaff(http:Client http) returns error?{
    if (http is http:Client){
        Lecturer[] lecturer=check http->/getStaffMembers;
        foreach Lecturer item in lecturer{
            io:println("Staff No:",item.Staff_No,", Staff Name:",item.Staff_Name,", Office No:",item.Office_No,", CourseName:",item.CoursesName);
        }
    }
    string back=io:readln("To go back just type back: ");
    if(back=="back"){
    error? MainMenu=main();
        if MainMenu is error{
            io:println("Yeah... Thats not a command");
        }
    }
}
public function CreateStaff(http:Client http, Lecturer lecturer) returns error?{
    if(http is http:Client){
        string message=check http->/addstaffRecord.post(lecturer);
        io:print(message);
    }
}
public function AddStaff()returns string{
    string lecturerName=io:readln("Enter a Lecturer Name: ");
    return lecturerName;
}