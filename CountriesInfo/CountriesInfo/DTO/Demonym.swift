import Foundation

struct Demonym: Decodable {
    let male: String
    let female: String
    
    enum CodingKeys: String, CodingKey {
        case male = "m"
        case female = "f"
    }
}
