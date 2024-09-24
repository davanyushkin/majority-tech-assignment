import Foundation

enum SearchType: CaseIterable, Identifiable {
    case countryName
    case countryNameFullText
    case countryCode
    case severalCountryCodes
    case currency
    case demonym
    case language
    case capital
    case region
    case subregion
    
    var id: String { searchName }
    
    var searchName: String {
        switch self {
        case .countryName:
            return "Country name"
        case .countryNameFullText:
            return "Country name (full text)"
        case .countryCode:
            return "Country code"
        case .severalCountryCodes:
            return "Several country codes"
        case .currency:
            return "Currency"
        case .demonym:
            return "Demonym"
        case .language:
            return "Language"
        case .capital:
            return "Capital"
        case .region:
            return "Region"
        case .subregion:
            return "Subregion"
        }
    }
    
    var placeholderText: String {
        switch self {
        case .countryName, .countryNameFullText:
            return "country"
        case .countryCode:
            return "country code"
        case .severalCountryCodes:
            return "country codes"
        case .currency:
            return "currency"
        case .demonym:
            return "demonym"
        case .language:
            return "language"
        case .capital:
            return "capital"
        case .region:
            return "region"
        case .subregion:
            return "subregion"
        }
    }
}
