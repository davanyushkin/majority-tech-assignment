import Foundation

struct Country: Codable {
    let name: CountryName
    let translations: [String: CountryName]
    
    let tld: [String]
    
    let cca2: String
    let ccn3: String
    let cca3: String
    
    let independent: Bool
    let unMember: Bool
    
    let currencies: [String: Currency]
    
    let idd: CallingCode
    
    let capital: [String]
    let altSpellings: [String]
    let region: String
    let subregion: String
    
    let languages: [String: String]
    
    let latlng: [Double]
    let landlocked: Bool
    let area: Double
    
    let denonyms: [String: Denonym]
    let flag: String
    
    let maps: [String: URL]
    
    let population: Int
    let gini: [String: Double]
    
    let car: CarInfo
    
    let timezones: [String]
    let continents: [String]
    
    let flagInfo: FlagInfo
    let coatOfArms: FlagInfo?
    
    let startOfWeek: String
    
    let borders: [String]?
    
    let capitalInfo: CapitalInfo
    
    let postalCode: PostalCode
}
