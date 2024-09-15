import Foundation

final class CountriesListByTextRequest: NetworkRequest {
    typealias ResponseType = [Country]
    
    let params: [String: Any]
    
    var path: String {
        "name"
    }
    
    init(text: String, isFullText: Bool) {
        params = [
            "text": text,
            "isFullText": isFullText
        ]
    }
    
}
