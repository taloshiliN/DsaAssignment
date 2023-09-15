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

Lecturer[] staffRecords=[];
service /Staff on new http:Listener(9090) {
    resource function post addLecturer(Lecturer lecturer) returns Lecturer|error {
        return lecturer;   
    }
    resource function get allLecturer()returns Lecturer|error{
        Lecturer lecturer={Staff_No: 1,Staff_Name: "Thomas Kenedy",Office_No: 32,CoursesName: ["Data Structures"]};
        return lecturer; //Part is fine for now
    }
    resource function put updateLecturerRecord(int Staff_No, Lecturer updatedRecords) returns string|error{
        int UpdatedRow=updateLecturerRecord(Staff_No,updatedRecords);

        if (UpdatedRow==1){
            return "Lecturer was updated";
        } else{
            return error ("Failed to update");
        } //Part is find for now
    }
    resource function get LecturerRecordsBy(int Staff_No) returns Lecturer|error{
        Lecturer lecturer={Staff_No: 2,Staff_Name: "William Conor",Office_No: 34,CoursesName: ["Mathematics"]};
        return lecturer; //re-do this part
    }
    resource function delete LecturerRecordsBy(int Staff_No) returns string|error{
        int index=FindLecturerBystaffno(Staff_No);

        if(index==-1){
            return error ("Lecturer Not Found");
        }
        staffRecords.remove(index);

        return "Employee Deleted Successfully";
    }
    resource function get LecturerByCourseName(string[] CourseName) returns Lecturer|error{
        Lecturer lecturer={Staff_No: 3,Staff_Name:"Johnson Jon",Office_No: 32,CoursesName: ["Programming"]};
        return lecturer;
    }
    resource function get LecturerByOfficeNo(int Office_No) returns Lecturer|error{
        Lecturer lecturer={Staff_No: 4,Staff_Name:"Ross Lynch",Office_No: 67,CoursesName: ["intro to Computing"]};
        return lecturer;
    }
}
