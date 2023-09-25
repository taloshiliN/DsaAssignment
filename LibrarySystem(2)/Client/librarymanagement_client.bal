import ballerina/io;

LibraryManagementClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    io:println("Welcome to the Nust Library System");
    io:println("keyWords: ");
    io:println("signup      -First Time");
    io:println("login       -Existing User");
    string keyword=io:readln("Enter a keyword: ");

    if keyword=="signup"{
        string option=io:readln("Sign Up as librarian or student: ");
        if option=="librarian"{
            //Librarian sign up
            //check AddUser();
            //interface for librarian
            io:println("What do you want to do:");
            io:println("Add Book        :add");
            io:println("Update Book     :update");
            io:println("Remove Book     :remove");
            string choice1=io:readln("Enter here: ");
            if (choice1==="add"){
                check AddBook();
            } else if (choice1=="update"){
                check UpdateBooks();
            } else if (choice1=="remove"){
                check RemoveBooks();
            } else {
                io:println("That is not a keyword");
            }            
        } else if option=="student"{
            //Student sign up
            //check AddUser();
            //interface for student
            io:println("What do you want to do:");
            io:println("Borrow Book     :borrow");
            io:println("Locate Book     :locate");
            io:println("Available Books :available");
            string choice2=io:readln("Enter Here: ");
            if (choice2==="borrow"){
                check BorrowBook();
            } else if(choice2=="locate"){
                check Location();
            } else if(choice2=="available"){
                check AvailableBooks();
            } else{
                io:println("That is not a keyword");
            }            
        } else {
            io:println("Such a command does not exist");
        }
    } else if (keyword==="login"){
        string option=io:readln("login as librarian or student");
        if (option==="librarian"){
            //librarian login
            //check AddUser();
            //interface for librarian
            io:println("What do you want to do:");
            io:println("Add Book        :add");
            io:println("Update Book     :update");
            io:println("Remove Book     :remove");
            string choice1=io:readln("Enter here: ");
            if (choice1==="add"){
                check AddBook();
            } else if (choice1=="update"){
                check UpdateBooks();
            } else if (choice1=="remove"){
                check RemoveBooks();
            } else {
                io:println("That is not a keyword");
            }
        } else if(option==="student"){
            //student login
            //check AddUser();
            //interface for student
            io:println("What do you want to do:");
            io:println("Borrow Book     :borrow");
            io:println("Locate Book     :locate");
            io:println("Available Books :available");
            string choice2=io:readln("Enter Here");
            if (choice2==="borrow"){
                check BorrowBook();
            } else if(choice2=="locate"){
                check Location();
            } else if(choice2=="available"){
                check AvailableBooks();
            } else{
                io:println("That is not a keyword");
            }
        } else {
            io:println("That is not a keyword");
        }
    } else {
        io:println("That is not a keyword");
    }
}
    //Adding a book
    function AddBook()returns error?{
    string isbn = io:readln("Enter the isbn: ");    
    string title = io:readln("Enter the title: ");
    string authors = io:readln("Enter the author: ");
    string location = io:readln("Enter the location: ");
    string status = io:readln("What is the status of the book: ");

    BookDetails addBookRequest = {title: title, authors: authors, location: location, isbn: isbn, status: status};
    Response addBookResponse = check ep->addBook(addBookRequest);
    io:println(addBookResponse);
    }
    //Update a book
    function UpdateBooks() returns error? {
    string isbn = io:readln("Enter the isbn: ");
    string title="";
    string authors="";
    string location="";
    string status="";
    title =io:readln("Update Title: ");
    authors = io:readln("Update Authors: ");
    location = io:readln("Update Location of the Book: ");
    status = io:readln("Update Status of book: ");
    BookDetails updateBookRequest = {title: title, authors: authors, location: location, isbn: isbn, status: status};
    Response updateBookResponse = check ep->updateBook(updateBookRequest);
    io:println(updateBookResponse);
    }
    //Remove a book
    function RemoveBooks() returns error?{
    string isbn = io:readln("Enter the ISBN of the book to DELETE");  
    BookDetails removeBookRequest = {title: "ballerina", authors: "ballerina", location: "ballerina", isbn: isbn, status: "ballerina"};
    Response removeBookResponse = check ep->removeBook(removeBookRequest);
    io:println(removeBookResponse);
    }
    
    //Books which are Available
    function AvailableBooks()returns error?{
    ListAvailableBooks listAvailableBooksResponse = check ep->listAvailableBooks();
    io:println(listAvailableBooksResponse);
    }

    function Location()returns error?{
    string title=io:readln("Enter the title of the book");
    BookDetails locateBookRequest = {title: title};
    BookLocation locateBookResponse = check ep->locateBook(locateBookRequest);
    io:println(locateBookResponse);
    }

    function BorrowBook() returns error?{
    string userid=io:readln("Enter your UserId: ");
    string isbn=io:readln("Enter the book's isbn: ");
    
    BookOnLoan borrowBookRequest = {userID: userid, isbn: isbn};
    Response borrowBookResponse = check ep->borrowBook(borrowBookRequest);
    io:println(borrowBookResponse);
    }

    function AddUser()returns error?{
    string FirstName=io:readln("Enter your first Name: ");
    string LastName=io:readln("Enter your last Name: ");
    string userID=io:readln("Enter your id: ");
    string usergender=io:readln("Enter your Gender: ");
    UserDetails createUsersRequest = {userFirstName: FirstName, userLastName: LastName, userID: userID, userGender: usergender};
    CreateUsersStreamingClient createUsersStreamingClient = check ep->createUsers();
    check createUsersStreamingClient->sendUserDetails(createUsersRequest);
    check createUsersStreamingClient->complete();
    Response? createUsersResponse = check createUsersStreamingClient->receiveResponse();
    io:println(createUsersResponse);
    }



