import ballerina/grpc;

public final table<BookDetails> key(isbn) libraryTable =table[
    {title:"The Adventures of Sherlock Holmes", authors: "Nancy Springer", location: "", isbn: 122334, status: "Available for loan"},
    {title:"Hary Potter and The Goblet of Fire",authors: "J.K Rowling", location: "", isbn:1563576, status: "Available for loan"},
    {title:"A Game of Thrones ", authors:"George R.R. Martin", location:"", isbn:543583, status:"Available for loan"}
];
public final table<UserDetails> key() userTable=table[
    {userID:13246,userFirstName:"John",userLastName:"Constentine",userGender:"Male"},
    {userID:25346,userFirstName:"Pepa",userLastName:"Pig",userGender:"Female"},
    {userID:73485,userFirstName:"Ben",userLastName:"Tenison",userGender:"Male"}
];

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: LIBRARY_DESC}
service "LibraryManagement" on ep {

    remote function addBook(BookDetails value) returns ISBN|error {
         error? addBook=libraryTable.add(value);
        if addBook is error{
               return error("Failed to Add Book");
        }
         return {isbn: value.isbn};
    }
    remote function updateBook(BookDetails value) returns Response|error {
          error? updateBook=libraryTable.put(value);
        if updateBook is error{
            return error("Failed to update the book");
        }
    return {message:"Created Successfully"};
    }
    remote function removeBook(BookDetails value) returns BookDetails|error {
        BookDetails removeBook=libraryTable.remove(value.isbn);
        string[] v;
        if removeBook is error {
            return error("Failed to Delete Book");}
        else{    
        foreach BookDetails status in libraryTable{
            return{title:value.title};
        }
        }
    }
    remote function listAvailableBooks(BookDetails value) returns BookDetails|error {
        BookDetails listAvailableBooks=libraryTable.get(value.isbn);
        if listAvailableBooks is error{
            return error("Failed to List All Books");
        }else{
            foreach BookDetails status in libraryTable{
                return{title:value.title};
            }
        }
        return{};
    }
    remote function createUsers(UserDetails value) returns Response|error {
         error? createUsers=userTable.add(value); 
        if createUsers is error{
            return error("Failed to Create Users");
        }
        return{message:"User created Successfully"};
    }
    remote function locateBook(ISBN value) returns BookDetails|error {
        BookDetails locateBook=libraryTable.get(value.isbn);
        if locateBook is error{
            return error("Failed to Locate Your Book");
        }
        return {isbn:value.isbn};
    }
    remote function borrowBook(BookOnLoan value) returns Response|error {
          BookDetails borrowBook=libraryTable.get(value.isbn);
        if borrowBook is error{
            return error("The Book is Unavailable");
        }
        return{message:"you book is available"};
    }
}

