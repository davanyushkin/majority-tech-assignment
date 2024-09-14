import Foundation

typealias DataResponse = (data: Data?, statusCode: Int)

/// Loader - part of the networking layer directly responsible for data loading
protocol NetworkLoader {
    /// Method for performing request
    /// - Parameters:
    ///   - request: Request information
    ///   - completion: Callback for result handling - contains raw data and status code or an error
    func handleRequest(_ request: URLRequest, completion: @escaping (Result<DataResponse, Error>) -> Void)
    
    func handleRequest(_ request: URLRequest) async -> Result<DataResponse, Error>
}

final class NetworkLoaderImpl: NetworkLoader {
    func handleRequest(_ request: URLRequest, completion: @escaping (Result<DataResponse, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(ResponseError.unknownError))
                return
            }
            
            completion(.success((data, response.statusCode)))
        }.resume()
    }
    
    func handleRequest(_ request: URLRequest) async -> Result<DataResponse, Error> {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
    
            guard let response = response as? HTTPURLResponse else {
                return .failure(ResponseError.unknownError)
            }
            
            return .success((data, response.statusCode))
        } catch {
            return .failure(ResponseError.custom(error))
        }
        
    }
}
