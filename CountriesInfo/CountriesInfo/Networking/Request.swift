import Foundation

/// Basic interface for request sending
protocol NetworkRequest {
    
    associatedtype ReponseType: Codable
    
    var host: String { get }
    var version: String { get }
    var path: String { get }
}

extension NetworkRequest {
    var host: String {
        "restcountries.com"
    }
    
    var version: String {
        "v3.1"
    }
    
}
