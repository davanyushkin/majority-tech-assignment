@testable import CountriesInfo
import Foundation

final class NetworkClientMock: NetworkClient {
    var requestStub = [String: Any]()
    var callsAmount = [String: Int]()
    
    func addStub<Request: NetworkRequest>(request: Request, value: Request.ResponseType) {
        requestStub[request.key] = value
    }
    
    func fetch<Request>(request: Request) async -> Result<Request.ResponseType, ResponseError> where Request : NetworkRequest {
        callsAmount[request.key] = (callsAmount[request.key] ?? 0) + 1
        if let value = requestStub[request.key] as? Request.ResponseType {
            return .success(value)
        } else if let error = requestStub[request.key] as? ResponseError {
            return .failure(error)
        }
        return .failure(.unknownError)
    }
    
}

extension NetworkRequest {
    var key: String {
        host + path + params.map { "\($0.key):\($0.value)" }.joined(separator: ",")
    }
}
