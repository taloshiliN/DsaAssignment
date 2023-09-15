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

table <Lecturer>key(Staff_No) staffRecordsTable=table[];
service /Staff on new http:Listener(9090) {
    resource function post staffRecord(Lecturer staffRecord) returns Lecturer{
        staffRecordsTable.add(staffRecord);
        return staffRecord;
    }
    resource function get staffRecord() returns Lecturer[]{
        return staffRecordsTable.toArray();
    }
}
