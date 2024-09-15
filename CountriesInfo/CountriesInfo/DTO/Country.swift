import Foundation

struct Country: Decodable {
    let name: CountryName
    let translations: [String: CountryName]
    
    @DecodableDefault.EmptyArray private(set) var tld: [String]
    
    let cca2: String
    let ccn3: String?
    let cca3: String
    
    @DecodableDefault.True private(set) var independent: Bool
    let unMember: Bool
    
    @DecodableDefault.EmptyDictionary private(set) var currencies: [String: Currency]
    
    let idd: CallingCode
    
    @DecodableDefault.EmptyArray private(set) var capital: [String]
    @DecodableDefault.EmptyArray private(set) var altSpellings: [String]
    let region: String
    let subregion: String?
    
    @DecodableDefault.EmptyDictionary private(set) var languages: [String: String]
    
    let latlng: [Double]
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
    let coatOfArms: FlagInfo?
    
    let startOfWeek: String
    
    @DecodableDefault.EmptyArray private(set) var borders: [String]
    
    let capitalInfo: CapitalInfo
    
    let postalCode: PostalCode?
}
