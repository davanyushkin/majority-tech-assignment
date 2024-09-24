import Foundation

final class CountriesListByDemonymRequest: NetworkRequest {
    typealias ResponseType = [Country]
    
    let params: [String: Any] = [:]
    private let text: String
    
    var path: String {
        "demonym/\(text)"
    }
    
    init(text: String) {
        self.text = text
    }
    
}
