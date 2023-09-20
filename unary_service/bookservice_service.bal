import ballerina/grpc;
import ballerina/io;

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: BOOK_SERVICE_DESC}
service "BookService" on ep {

    remote function create(CreateBookRequest value) returns CreateBookResponse|error {
         return {message: "Book Succesfully Created " + isbn };
         io:println("Hello World!");
    }
}

