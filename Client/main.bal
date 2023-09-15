import ballerina/io;
import ballerina/http;

type Lecturer record{
    readonly int Staff_No;
    string Staff_Name;
    int Office_No;
    string[] CoursesName;
};

type Course readonly & record{
    int CourseCode;
    string CourseName;
    int NQF;
};

public function main()returns error? {
    http:Client UserClient=check new("localhost:9090/Staff");
    Lecturer staffRecord = check UserClient ->/staffRecordTable.post(io:readln(Lecturer));
    io:println("Lecturer Has been add"+staffRecord.toJsonString());
    
    Lecturer[] staffRecords = check UserClient ->/staffRecordTable.get;
    io:println("Get All Lecturers" + staffRecords.toJsonString());

    io:println("Hello, World!");
}
