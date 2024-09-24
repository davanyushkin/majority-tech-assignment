import Foundation

final class CountriesListByTextRequest: NetworkRequest {
    typealias ResponseType = [Country]
    
    let params: [String: Any]
    private let name: String
    
    var path: String {
        "name/\(name)"
    }
    
    init(text: String, isFullText: Bool) {
        name = text
        params = [
            "isFullText": isFullText
        ]
    }
    
}
