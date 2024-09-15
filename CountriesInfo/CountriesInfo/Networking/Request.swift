import Foundation

/// Basic interface for request sending
protocol NetworkRequest {
    
    associatedtype ResponseType: Decodable
    
    var host: String { get }
    var version: String { get }
    var path: String { get }
    
    var params: [String: Any] { get }
}

extension NetworkRequest {
    var host: String {
        "restcountries.com"
    }
    
    var version: String {
        "v3.1"
    }
    
}
