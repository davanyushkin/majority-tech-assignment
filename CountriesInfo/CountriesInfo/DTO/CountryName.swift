import Foundation

struct CountryName: Codable {
    let common: String
    let official: String
    let nativeName: [CountryName]
}
