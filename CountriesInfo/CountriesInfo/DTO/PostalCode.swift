import Foundation

struct PostalCode: Decodable {
    let format: String
    let regex: String?
}
