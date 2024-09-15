import Foundation

struct CountryName: Decodable {
    let common: String
    let official: String
    @DecodableDefault.EmptyDictionary private(set) var nativeName: [String: CountryName]
}
