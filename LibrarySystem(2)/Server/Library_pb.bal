import ballerina/grpc;
import ballerina/protobuf;
import ballerina/protobuf.types.empty;

public const string LIBRARY_DESC = "0A0D4C6962726172792E70726F746F12114C6962726172794D616E6167656D656E741A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F2285010A0B426F6F6B44657461696C7312140A057469746C6518012001280952057469746C6512180A07617574686F72731802200128095207617574686F7273121A0A086C6F636174696F6E18032001280952086C6F636174696F6E12120A046973626E18042001280952046973626E12160A067374617475731805200128095206737461747573221A0A044953424E12120A046973626E18012001280952046973626E222A0A0C426F6F6B4C6F636174696F6E121A0A08626F6F6B4E616D651801200128095208626F6F6B4E616D65228F010A0B5573657244657461696C7312240A0D7573657246697273744E616D65180120012809520D7573657246697273744E616D6512220A0C757365724C6173744E616D65180220012809520C757365724C6173744E616D6512160A067573657249441803200128095206757365724944121E0A0A7573657247656E646572180420012809520A7573657247656E64657222240A08526573706F6E736512180A076D65737361676518012001280952076D65737361676522260A08426F6F6B4C697374121A0A08616C6C426F6F6B731801200128095208616C6C426F6F6B73223C0A124C697374417661696C61626C65426F6F6B7312260A0E617661696C61626C65426F6F6B73180120012809520E617661696C61626C65426F6F6B7322380A0A426F6F6B4F6E4C6F616E12160A06757365724944180120012809520675736572494412120A046973626E18022001280952046973626E32AD040A114C6962726172794D616E6167656D656E7412460A07616464426F6F6B121E2E4C6962726172794D616E6167656D656E742E426F6F6B44657461696C731A1B2E4C6962726172794D616E6167656D656E742E526573706F6E736512490A0A757064617465426F6F6B121E2E4C6962726172794D616E6167656D656E742E426F6F6B44657461696C731A1B2E4C6962726172794D616E6167656D656E742E526573706F6E736512490A0A72656D6F7665426F6F6B121E2E4C6962726172794D616E6167656D656E742E426F6F6B44657461696C731A1B2E4C6962726172794D616E6167656D656E742E526573706F6E736512530A126C697374417661696C61626C65426F6F6B7312162E676F6F676C652E70726F746F6275662E456D7074791A252E4C6962726172794D616E6167656D656E742E4C697374417661696C61626C65426F6F6B73124C0A0B6372656174655573657273121E2E4C6962726172794D616E6167656D656E742E5573657244657461696C731A1B2E4C6962726172794D616E6167656D656E742E526573706F6E73652801124D0A0A6C6F63617465426F6F6B121E2E4C6962726172794D616E6167656D656E742E426F6F6B44657461696C731A1F2E4C6962726172794D616E6167656D656E742E426F6F6B4C6F636174696F6E12480A0A626F72726F77426F6F6B121D2E4C6962726172794D616E6167656D656E742E426F6F6B4F6E4C6F616E1A1B2E4C6962726172794D616E6167656D656E742E526573706F6E7365620670726F746F33";

public isolated client class LibraryManagementClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, LIBRARY_DESC);
    }

    isolated remote function addBook(BookDetails|ContextBookDetails req) returns Response|grpc:Error {
        map<string|string[]> headers = {};
        BookDetails message;
        if req is ContextBookDetails {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManagement.LibraryManagement/addBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Response>result;
    }

    isolated remote function addBookContext(BookDetails|ContextBookDetails req) returns ContextResponse|grpc:Error {
        map<string|string[]> headers = {};
        BookDetails message;
        if req is ContextBookDetails {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManagement.LibraryManagement/addBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Response>result, headers: respHeaders};
    }

    isolated remote function updateBook(BookDetails|ContextBookDetails req) returns Response|grpc:Error {
        map<string|string[]> headers = {};
        BookDetails message;
        if req is ContextBookDetails {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManagement.LibraryManagement/updateBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Response>result;
    }

    isolated remote function updateBookContext(BookDetails|ContextBookDetails req) returns ContextResponse|grpc:Error {
        map<string|string[]> headers = {};
        BookDetails message;
        if req is ContextBookDetails {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManagement.LibraryManagement/updateBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Response>result, headers: respHeaders};
    }

    isolated remote function removeBook(BookDetails|ContextBookDetails req) returns Response|grpc:Error {
        map<string|string[]> headers = {};
        BookDetails message;
        if req is ContextBookDetails {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManagement.LibraryManagement/removeBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Response>result;
    }

    isolated remote function removeBookContext(BookDetails|ContextBookDetails req) returns ContextResponse|grpc:Error {
        map<string|string[]> headers = {};
        BookDetails message;
        if req is ContextBookDetails {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManagement.LibraryManagement/removeBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Response>result, headers: respHeaders};
    }

    isolated remote function listAvailableBooks() returns ListAvailableBooks|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManagement.LibraryManagement/listAvailableBooks", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ListAvailableBooks>result;
    }

    isolated remote function listAvailableBooksContext() returns ContextListAvailableBooks|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManagement.LibraryManagement/listAvailableBooks", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ListAvailableBooks>result, headers: respHeaders};
    }

    isolated remote function locateBook(BookDetails|ContextBookDetails req) returns BookLocation|grpc:Error {
        map<string|string[]> headers = {};
        BookDetails message;
        if req is ContextBookDetails {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManagement.LibraryManagement/locateBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <BookLocation>result;
    }

    isolated remote function locateBookContext(BookDetails|ContextBookDetails req) returns ContextBookLocation|grpc:Error {
        map<string|string[]> headers = {};
        BookDetails message;
        if req is ContextBookDetails {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManagement.LibraryManagement/locateBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <BookLocation>result, headers: respHeaders};
    }

    isolated remote function borrowBook(BookOnLoan|ContextBookOnLoan req) returns Response|grpc:Error {
        map<string|string[]> headers = {};
        BookOnLoan message;
        if req is ContextBookOnLoan {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManagement.LibraryManagement/borrowBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Response>result;
    }

    isolated remote function borrowBookContext(BookOnLoan|ContextBookOnLoan req) returns ContextResponse|grpc:Error {
        map<string|string[]> headers = {};
        BookOnLoan message;
        if req is ContextBookOnLoan {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("LibraryManagement.LibraryManagement/borrowBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Response>result, headers: respHeaders};
    }

    isolated remote function createUsers() returns CreateUsersStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("LibraryManagement.LibraryManagement/createUsers");
        return new CreateUsersStreamingClient(sClient);
    }
}

public client class CreateUsersStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendUserDetails(UserDetails message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextUserDetails(ContextUserDetails message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveResponse() returns Response|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return <Response>payload;
        }
    }

    isolated remote function receiveContextResponse() returns ContextResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: <Response>payload, headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public client class LibraryManagementResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendResponse(Response response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextResponse(ContextResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class LibraryManagementListAvailableBooksCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendListAvailableBooks(ListAvailableBooks response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextListAvailableBooks(ContextListAvailableBooks response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class LibraryManagementBookLocationCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendBookLocation(BookLocation response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextBookLocation(ContextBookLocation response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextUserDetailsStream record {|
    stream<UserDetails, error?> content;
    map<string|string[]> headers;
|};

public type ContextBookDetails record {|
    BookDetails content;
    map<string|string[]> headers;
|};

public type ContextResponse record {|
    Response content;
    map<string|string[]> headers;
|};

public type ContextBookOnLoan record {|
    BookOnLoan content;
    map<string|string[]> headers;
|};

public type ContextListAvailableBooks record {|
    ListAvailableBooks content;
    map<string|string[]> headers;
|};

public type ContextUserDetails record {|
    UserDetails content;
    map<string|string[]> headers;
|};

public type ContextBookLocation record {|
    BookLocation content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type BookDetails record {|
    string title = "";
    string authors = "";
    string location = "";
    string isbn = "";
    string status = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type Response record {|
    string message = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type BookOnLoan record {|
    string userID = "";
    string isbn = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type ListAvailableBooks record {|
    string availableBooks = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type UserDetails record {|
    string userFirstName = "";
    string userLastName = "";
    string userID = "";
    string userGender = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type ISBN record {|
    string isbn = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type BookList record {|
    string allBooks = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type BookLocation record {|
    string bookName = "";
|};

