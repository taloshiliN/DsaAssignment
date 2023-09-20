import ballerina/io;

BookServiceClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    CreateBookRequest createRequest = {isbn: 1, book_title: "ballerina", author: "ballerina", location: "ballerina"};
    CreateBookResponse createResponse = check ep->create(createRequest);
    io:println(createResponse);
}

