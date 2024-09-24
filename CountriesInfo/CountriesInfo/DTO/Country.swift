import Foundation

struct Country: Decodable {
    let name: CountryName
    let translations: [String: CountryName]
    
    @DecodableDefault.EmptyArray private(set) var tld: [String]
    
    let cca2: String
    let ccn3: String?
    let cca3: String
    
    let unMember: Bool
    
    @DecodableDefault.EmptyDictionary private(set) var currencies: [String: Currency]
    
    let idd: CallingCode
    
    @DecodableDefault.EmptyArray private(set) var capital: [String]
    @DecodableDefault.EmptyArray private(set) var altSpellings: [String]
    let region: String
    let subregion: String?
    
    @DecodableDefault.EmptyDictionary private(set) var languages: [String: String]
    
    let landlocked: Bool
    let area: Double
    
    @DecodableDefault.EmptyDictionary private(set) var demonyms: [String: Demonym]
    let flag: String
    
    let maps: [String: URL]
    
    let population: Int
    let gini: [String: Double]?
    
    let car: CarInfo
    
    let timezones: [String]
    let continents: [String]
    
    let flags: FlagInfo
}
