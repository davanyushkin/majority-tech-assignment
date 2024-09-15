import Foundation

final class CountriesListAllRequest: NetworkRequest {
    typealias ResponseType = [Country]
    
    let params: [String: Any] = [:]
    
    var path: String {
        "all"
    }
    
    init() {}
    
}
