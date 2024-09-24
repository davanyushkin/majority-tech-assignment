import Foundation

final class CountriesListByCurrencyRequest: NetworkRequest {
    typealias ResponseType = [Country]
    
    let params: [String: Any] = [:]
    private let text: String
    
    var path: String {
        "currency/\(text)"
    }
    
    init(text: String) {
        self.text = text
    }
    
}
