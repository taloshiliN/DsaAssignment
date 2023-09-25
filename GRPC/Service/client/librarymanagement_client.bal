import ballerina/io;

LibraryManagementClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    BookDetails addBookRequest = {title: "ballerina", authors: "ballerina", location: "ballerina", isbn: 1, status: "ballerina"};
    ISBN addBookResponse = check ep->addBook(addBookRequest);
    io:println(addBookResponse);

    BookDetails updateBookRequest = {title: "ballerina", authors: "ballerina", location: "ballerina", isbn: 1, status: "ballerina"};
    BookList updateBookResponse = check ep->updateBook(updateBookRequest);
    io:println(updateBookResponse);

    BookDetails removeBookRequest = {title: "ballerina", authors: "ballerina", location: "ballerina", isbn: 1, status: "ballerina"};
    BookList removeBookResponse = check ep->removeBook(removeBookRequest);
    io:println(removeBookResponse);

    ListAvailableBooks listAvailableBooksResponse = check ep->listAvailableBooks();
    io:println(listAvailableBooksResponse);

    UserDetails createUsersRequest = {userFirstName: "ballerina", userLastName: "ballerina", userID: 1, userGender: "ballerina"};
    Response createUsersResponse = check ep->createUsers(createUsersRequest);
    io:println(createUsersResponse);

    ISBN locateBookRequest = {isbn: 1};
    Book locateBookResponse = check ep->locateBook(locateBookRequest);
    io:println(locateBookResponse);

    BookOnLoan borrowBookRequest = {userID: 1, isbn: 1};
    Response borrowBookResponse = check ep->borrowBook(borrowBookRequest);
    io:println(borrowBookResponse);
}

