import Foundation

final class CountriesListByLanguageRequest: NetworkRequest {
    typealias ResponseType = [Country]
    
    let params: [String: Any] = [:]
    private let text: String
    
    var path: String {
        "lang/\(text)"
    }
    
    init(text: String) {
        self.text = text
    }
}
