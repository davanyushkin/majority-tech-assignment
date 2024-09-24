import Foundation

final class CountriesListBySubregionRequest: NetworkRequest {
    typealias ResponseType = [Country]
    
    let params: [String: Any] = [:]
    private let text: String
    
    var path: String {
        "subregion/\(text)"
    }
    
    init(text: String) {
        self.text = text
    }
    
}
