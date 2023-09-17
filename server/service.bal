import ballerina/http;

type Lecturer record{
    readonly int Staff_No;
    string Staff_Name;
    int Office_No;
    string CoursesName;
};

type Course readonly & record{
    int CourseCode;
    string CourseName;
    int NQF;
};

table <Lecturer>key(Staff_No) staffRecordsTable=table[
    {Staff_No: 1,Staff_Name: "Talo",Office_No: 23,CoursesName: "Programming"},
    {Staff_No: 2,Staff_Name: "Olat",Office_No: 24,CoursesName: "Data Structures"},
    {Staff_No: 3,Staff_Name: "Lolina",Office_No: 26,CoursesName: "Intro to Computing"},
    {Staff_No: 4,Staff_Name: "John",Office_No: 27,CoursesName: "Archaetecture"}
];
service /Staff on new http:Listener(9090) {
    resource function post staffRecord(Lecturer staffRecord) returns Lecturer{
        staffRecordsTable.add(staffRecord);
        return staffRecord;
    }
    resource function get getStaffMembers() returns Lecturer[]{
        return staffRecordsTable.toArray();
    }
}
