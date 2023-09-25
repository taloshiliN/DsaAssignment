import ballerina/grpc;

type Bookdetails record{
    string title;
    string authors;
    string location;
    readonly string isbn;
    string status;
};
type userDetails record{
    string userFirstName;
    string userLastName;
    readonly string userID;
    string userGender;
};

table<Bookdetails> key(isbn) BookTable=table[
    {title: "The Adventure",authors:"Aronzo Delgano",location:"A1",isbn: "1000",status: "Available"},
    {title: "Peak",authors:"Arnold Schwazanegger",location:"A2",isbn: "1001",status: "Available"},
    {title: "Kenpo",authors:"Aronzo Delgano",location:"A4",isbn: "1002",status: "Available"}
];
table<userDetails> key(userID) UserTable=table[];
listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: LIBRARY_DESC}
service "LibraryManagement" on ep {
    private map<userDetails> all_users={};

    remote function addBook(BookDetails value) returns Response|error {
        string New_Book=value.isbn;
        Bookdetails NewBook={title: value.title, authors: value.authors,location: value.location,isbn: New_Book,status: value.status};
        error? addNewBook=BookTable.add(NewBook);
        if addNewBook is error{
            return addNewBook;
        } else{
            return {message: string`${NewBook.isbn} has been Saved`};
        }
    }

    remote function updateBook(BookDetails value) returns Response|error {
        string Update_Book=value.title;
        Bookdetails UpdateBook={title: Update_Book,authors: value.authors,location: value.location,isbn: value.isbn,status: value.status};
        error? Update_A_Book=BookTable.put(UpdateBook);
        if Update_A_Book is error{
            return Update_A_Book;
        } else{
            return {message: string `${UpdateBook.isbn} updated successfully`};
        }  
    }
    remote function removeBook(BookDetails value) returns Response|error {
        string Delete_Book=value.title;
        Bookdetails DeleteBook=BookTable.remove(Delete_Book);
        return {message: string `${DeleteBook.title} deleted successfully`};
    }
    remote function listAvailableBooks(Bookdetails value) returns ListAvailableBooks|error {
        string AllBooks=value.title;
        Bookdetails Available_Books=BookTable.get(AllBooks);
        if (Available_Books.status==="No"){
            return error ("No Books Available");
        } else {
            foreach Bookdetails status in BookTable{
                return {availableBooks: string `$j`};
            }
        } return {availableBooks: string``};
    }
    remote function locateBook(BookDetails value) returns BookLocation|error {
        string Find_Book=value.title;
        BookDetails FindBook={title: Find_Book,authors: value.authors,location: value.location,isbn: value.isbn,status: value.status};
        if (FindBook.status==="No"){
            return error("Book cannot be found");
        } else {
            return {bookName: string`${FindBook.title} location is ${FindBook.location}`};
        }
    }
    remote function borrowBook(BookOnLoan value) returns Response|error {
        Bookdetails|error? BorrowBook=BookTable.get(value.isbn);
        if BorrowBook is error{
            return error("the Book is Unavailable");
        }
        return{message:"Your book is available"};
    }
    remote function createUsers(stream<UserDetails, grpc:Error?> clientStream) returns Response|error {
        check clientStream.forEach(function(UserDetails userdetails){
        string newUserName=userdetails.userFirstName;
        UserDetails newUser={userFirstName: newUserName,userLastName: userdetails.userLastName,userID: userdetails.userID,userGender: userdetails.userGender};
        lock {
            if self.all_users.hasKey(newUserName.clone()) {
                //return error:("A user with this username already exists");
            } else {
                //self.all_users[newUserName.clone()] = newUser;
            }
        }                    
        });
        return{message: string `return`};
    }
}

