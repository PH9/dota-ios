enum APIServiceError: Error {
    case unacceptableHTTPStatus
    case responseDataNotFound
    case couldNotParseJSONValue
}
