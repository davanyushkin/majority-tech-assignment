import Foundation

final class CountriesListByCapitalRequest: NetworkRequest {
    typealias ResponseType = [Country]
    
    let params: [String: Any] = [:]
    private let text: String
    
    var path: String {
        "capital/\(text)"
    }
    
    init(text: String) {
        self.text = text
    }
}
