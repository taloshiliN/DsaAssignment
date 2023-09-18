import ballerina/http;

public type Lecturer record {|
    readonly string StaffNumber;
    decimal officeNumber;
    string staffName;
    string Tittle;
    string Courses;
|};
public type Office record {|
    readonly decimal officeNumber;
    string StaffNumber;
    string staffName;
|};
public type Courses record {|
    readonly string courseCode;
    decimal NQFLevel;
    string courseName;
    string StaffNumber;
|};

public final table<Lecturer> key(StaffNumber) staffTable = table [
    {StaffNumber: "123", officeNumber: 159303, staffName: "Galeger", Tittle: "Proffesor", Courses: "Core Network Communications"},
    {StaffNumber: "124", officeNumber: 159303, staffName: "Chitaro", Tittle: "Proffesor", Courses: "Systems Administrations"},
    {StaffNumber: "125", officeNumber: 159303, staffName: "Chimba", Tittle: "Proffesor", Courses: "Programming 2"}

];
public final table<Office> key(officeNumber) officeTable = table [
    {officeNumber: 159303, StaffNumber: "123", staffName: "Galeger"},
    {officeNumber: 159304, StaffNumber: "124", staffName: "Chitaro"},
    {officeNumber: 159305, StaffNumber: "125", staffName: "Chimba"}

];
public final table<Courses> key(courseCode) courseTable = table [
    {courseCode: "CNC612S1", NQFLevel: 159303, courseName: "Galeger", StaffNumber: "123"},
    {courseCode: "SAD54S1", NQFLevel: 159303, courseName: "Chitaro", StaffNumber: "124"},
    {courseCode: "PRG612S1", NQFLevel: 159303, courseName: "Chimba", StaffNumber: "125"}

];

service / on new http:Listener(9000) {
	resource function get officeNumbers() returns Lecturer[] {
        return staffTable.toArray();
    }
resource function post officeNumbers(@http:Payload Lecturer[] Lecturers)
                                    returns Lecturer[]|ConflictingstaffNumberError {

    string[] conflictingstaffNumbers = from Lecturer staff in Lecturers
        where staffTable.hasKey(staff.StaffNumber)
        select staff.StaffNumber;

    if conflictingstaffNumbers.length() > 0 {
        return {
            body: {
                errmsg: string:'join(" ", "Conflicting Staff Numbers:", ...conflictingstaffNumbers)
            }
        };
    } else {
        Lecturers.forEach(staff => staffTable.add(staff));
        return Lecturers;
    }
}
resource function get countries/[string StaffNumber]() returns Lecturer|InvalidIsoCodeError {
    Lecturer? covidEntry = staffTable[StaffNumber];
    if covidEntry is () {
        return {
            body: {
                errmsg: string `Invalid Staff Number: ${StaffNumber}`
            }
        };
    }
    return covidEntry;
}
}

public type ConflictingstaffNumberError record {|
    *http:Conflict;
    ErrorMsg body;
|};

public type ErrorMsg record {|
    string errmsg;
|};
public type InvalidIsoCodeError record {|
    *http:NotFound;
    ErrorMsg body;
|};
