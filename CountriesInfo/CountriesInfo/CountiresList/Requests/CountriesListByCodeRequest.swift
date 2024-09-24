import Foundation

final class CountriesListByCodeRequest: NetworkRequest {
    typealias ResponseType = [Country]
    
    let params: [String: Any]
    private let text: String?
    
    var path: String {
        if let text {
            return "alpha/\(text)"
        }
        return "alpha"
    }
    
    init(text: String) {
        self.text = text
        params = [:]
    }
    
    init(severalCodes: String) {
        text = nil
        params = ["codes": severalCodes]
    }
    
}
