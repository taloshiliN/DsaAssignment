import ballerina/http;
import ballerina/io;

type Lecturer record{
    readonly string Staff_No;
    string Staff_Name;
    string Office_No;
    string CoursesName;
};

type Course readonly & record{
    int CourseCode;
    string CourseName;
    int NQF;
};
//Value for searches
type staff_num string;
type OfficeNo string;
type CourseName string;
table <Lecturer>key(Staff_No) staffRecordsTable=table[
    {Staff_No: "1",Staff_Name: "Talo",Office_No: "23",CoursesName: "Programming"},
    {Staff_No: "2",Staff_Name: "Olat",Office_No: "24",CoursesName: "Data Structures"},
    {Staff_No: "3",Staff_Name: "Lolina",Office_No: "26",CoursesName: "Intro to Computing"},
    {Staff_No: "4",Staff_Name: "John",Office_No: "27",CoursesName: "Archaetecture"}
];
service /Staff on new http:Listener(9090) {
    resource function get getStaffMembers() returns table <Lecturer>key(Staff_No){
        return staffRecordsTable;
    }
    resource function post addstaffRecord(Lecturer staffRecord) returns string{
        io:println(staffRecord);
        error? err=staffRecordsTable.add(staffRecord);
        if (err is error){
            return string `error, ${err.message()}`;
        }
        return string `${staffRecord.Staff_No} saved successfully`;
    }
    resource function delete ByStaffNo/[string staff_num]() returns string{
        staffRecordsTable=<table<Lecturer>key(Staff_No)>staffRecordsTable.filter((staffRecord)=>staffRecord.Staff_No != staff_num);
        table<Lecturer> staffRecordsTable2=table[];
        if (staffRecordsTable.length()===staffRecordsTable2.length()){
                    return staff_num + " not found.";
        }
        return staff_num + " successfuly deleted";
    }
    //get staff members by staffNo
    resource function get ByStaffNo/[string staff_num]() returns Lecturer|string{
        foreach Lecturer lecturer in staffRecordsTable{
            if(lecturer.Staff_No===staff_num){
                return lecturer;
            }
        }
        return staff_num + "Does not exist";
    }
    //get staff members by coursename
    resource function get ByCourseName(string CoursesName) returns Lecturer|string{
        foreach Lecturer lecturer in staffRecordsTable{
            if(lecturer.CoursesName===CoursesName){
                return lecturer;
            }
        }
        return CoursesName + "Does not exist";
    }
    //get staff members by officeno
    resource function get ByOfficeNo(string OfficeNo) returns Lecturer|string{
        foreach Lecturer lecturer in staffRecordsTable{
            if(lecturer.Office_No===OfficeNo){
                return lecturer;
            }
        }
        return OfficeNo + "Does not exist";
    }
    //update staff members record
    resource function put updateStaffMembers(Lecturer lecturer)returns string{
        io:println(lecturer);
        error? err=staffRecordsTable.put(lecturer);
        if(err is error){
            return string `Error,${err.message()}`;
        }
        return string `Error,${lecturer.Staff_No} saved successfully`;
    }
}
