import ballerina/grpc;
import ballerina/protobuf;

public const string BOOK_SERVICE_DESC = "0A1870726F746F2F626F6F6B5F736572766963652E70726F746F1205426F6F6B73227A0A11437265617465426F6F6B5265717565737412120A046973626E18012001280552046973626E121D0A0A626F6F6B5F7469746C651802200128095209626F6F6B5469746C6512160A06617574686F721803200128095206617574686F72121A0A086C6F636174696F6E18042001280952086C6F636174696F6E22280A12437265617465426F6F6B526573706F6E736512120A046973626E18012001280952046973626E324C0A0B426F6F6B53657276696365123D0A0663726561746512182E426F6F6B732E437265617465426F6F6B526571756573741A192E426F6F6B732E437265617465426F6F6B526573706F6E7365620670726F746F33";

public isolated client class BookServiceClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, BOOK_SERVICE_DESC);
    }

    isolated remote function create(CreateBookRequest|ContextCreateBookRequest req) returns CreateBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        CreateBookRequest message;
        if req is ContextCreateBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Books.BookService/create", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <CreateBookResponse>result;
    }

    isolated remote function createContext(CreateBookRequest|ContextCreateBookRequest req) returns ContextCreateBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        CreateBookRequest message;
        if req is ContextCreateBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Books.BookService/create", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <CreateBookResponse>result, headers: respHeaders};
    }
}

public client class BookServiceCreateBookResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendCreateBookResponse(CreateBookResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextCreateBookResponse(ContextCreateBookResponse response) returns grpc:Error? {
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

public type ContextCreateBookRequest record {|
    CreateBookRequest content;
    map<string|string[]> headers;
|};

public type ContextCreateBookResponse record {|
    CreateBookResponse content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: BOOK_SERVICE_DESC}
public type CreateBookRequest record {|
    int isbn = 0;
    string book_title = "";
    string author = "";
    string location = "";
|};

@protobuf:Descriptor {value: BOOK_SERVICE_DESC}
public type CreateBookResponse record {|
    string isbn = "";
|};

