import ballerina/grpc;

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: LIBRARY3_DESC}
service "LibraryManagement" on ep {

    remote function addBook(BookDetails value) returns ISBN|error {
    }
    remote function updateBook(BookDetails value) returns BookList|error {
    }
    remote function removeBook(BookDetails value) returns BookList|error {
    }
    remote function listAvailableBooks() returns ListAvailableBooks|error {
    }
    remote function createUsers(UserDetails value) returns Response|error {
    }
    remote function locateBook(ISBN value) returns Book|error {
    }
    remote function borrowBook(BookOnLoan value) returns Response|error {
    }
}

