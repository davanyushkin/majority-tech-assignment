import Foundation

final class CountriesListByRegionRequest: NetworkRequest {
    typealias ResponseType = [Country]
    
    let params: [String: Any] = [:]
    private let text: String
    
    var path: String {
        "region/\(text)"
    }
    
    init(text: String) {
        self.text = text
    }
    
}
