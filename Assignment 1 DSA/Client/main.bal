import ballerina/io;
import ballerina/http;

type Lecturer record{
    string Staff_No?;
    string Staff_Name?;
    string Office_No?;
    string CoursesName?;
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
        check CreateStaff(UserClient,lecturer);
    } else if keyword == "showall"{
        check getAllStaff(UserClient);
    } else if keyword == "update"{
        Lecturer lecturer={Office_No: "", Staff_No: "", Staff_Name: "", CoursesName: ""};
        lecturer.Staff_No=io:readln("enter Staff_No: ");
        lecturer.Staff_Name=io:readln("enter Staff_Name: ");
        lecturer.Office_No=io:readln("enter Office_No: ");
        lecturer.CoursesName=io:readln("enter CourseName: ");
        check updateStaff(UserClient,lecturer);
    } else if keyword == "delete"{
        string Staff_No=io:readln("Which Staff Member Do you want to delete: ");
        check DeleteStaff(UserClient,Staff_No);
    } else if keyword == "retrievebyStaffNo"{

    } else if keyword == "retrievebyCourse"{
        string Course_Name=io:readln("Which Course: ");
        check getByCourseName(UserClient,Course_Name);
    } else if keyword == "retrievebyOffice"{
        string Office_No=io:readln("Office Number? ");
        check getByOfficeNo(UserClient,Office_No);
    } else {
    io:println("That is not a Keyword:");
    string back=io:readln("To go back just type back: ");
    if(back=="back"){
    error? MainMenu=main();
        if MainMenu is error{
            io:println("Yeah... Thats not a command");
        }
    }
    }
};
//Get all the staff Members
public function getAllStaff(http:Client http) returns error?{
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
//To add a lecturer
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
public function updateStaff(http:Client http,Lecturer update_Staff)returns error?{
    io:println(update_Staff);
}
public function DeleteStaff(http:Client http,string|string[] delete_Staff) returns error?{
    if(http is http:Client){
        string message=check http->/DeleteByStaffNo.get({delete_Staff});
    }
}
public function getByCourseName(http:Client http,string CourseName) returns error?{
    if (http is http:Client){
        Lecturer lecturer=check http->/ByCourseName(CoursesName=CourseName);
    }
}
public function getByOfficeNo(http:Client http, string OfficeNo) returns error?{
    if(http is http:Client){
        Lecturer lecturer=check http->/ByOfficeNo;
    }
}