import Foundation

enum ResponseError: Error {
    case parsingError(Error)
    case badURL
    case badRequest
    case backendError
    case unknownError
    case custom(Error)
    
    var errorAlertText: String {
        switch self {
        case .badRequest, .badURL, .parsingError:
            "Something wrong happens with application"
        case .backendError:
            "Oops, we're experiencing some technical difficulties"
        case .unknownError, .custom:
            "Please, try again later or contact support"
        }
    }
}

protocol NetworkClient {
    
    /// Basic method for requests with normal Codable responses
    /// - Parameters:
    ///   - request: Info about request
    func fetch<Request: NetworkRequest>(request: Request) async -> Result<Request.ResponseType, ResponseError>
}

final class NetworkClientImpl: NetworkClient {
    
    private let workQueue = DispatchQueue(
        label: "countires.networking",
        qos: .userInitiated,
        attributes: .concurrent
    )
    private let networkLoader: NetworkLoader
    
    init(
        networkLoader: NetworkLoader = NetworkLoaderImpl()
    ) {
        self.networkLoader = networkLoader
    }
    
    func fetch<Request: NetworkRequest>(request: Request) async -> Result<Request.ResponseType, ResponseError> {
        guard let urlRequest = configureRequest(request: request) else { return .failure(.badURL) }
        let response = await processRequest(request: urlRequest)
        
        switch response {
        case let .success(data):
            do {
                let result = try JSONDecoder().decode(Request.ResponseType.self, from: data)
                return .success(result)
            } catch {
                return .failure(.parsingError(error))
            }
        case let .failure(error):
            return .failure(error)
        }
    }
    
    private func processRequest(request: URLRequest) async -> Result<Data, ResponseError> {
        let result = await networkLoader.handleRequest(request)
        
        switch result {
        case let .success(response):
            if (400...499).contains(response.statusCode) {
                return .failure(.badRequest)
            }
            if (500...599).contains(response.statusCode) {
                return .failure(.backendError)
            }
            
            guard let data = response.data else { return .failure(.unknownError) }
            return .success(data)
        case let .failure(error):
            return .failure(.custom(error))
        }
    }
    
    private func configureRequest(request: any NetworkRequest) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = request.host
        urlComponents.path = "/" + request.version + "/" + request.path
        urlComponents.queryItems = request.params.map { key, value in
            URLQueryItem(name: key, value: "\(value)")
        }
        
        guard let url = urlComponents.url else { return nil }
        
        return URLRequest(url: url)
    }
}

