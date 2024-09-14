import Foundation

struct Denonym: Codable {
    let male: String
    let female: String
    
    enum CodingKeys: String, CodingKey {
        case male = "m"
        case female = "f"
    }
}
