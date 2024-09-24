import Foundation

struct CountryDetailsReducer: Reducer {
    struct State {
        struct CountryCodes {
            let cca2: String
            let ccn3: String?
            let cca3: String
        }
        
        struct Demonym {
            let language: String
            let demonym: String
        }
        
        struct CountryTranslation {
            let language: String
            let officialName: String
            let commonName: String
        }
        
        var flagURL: URL?
        var name = ""
        var fullName = ""
        var region = ""
        var subregion: String?
        
        var capitals = ""
        var callingInfo = ""
        var languages = ""
        var unMmemberStatus = ""
        var countryTranslations: [CountryTranslation] = []
        
        var alternativeNames = ""
        
        var currencyInfo: [String] = []
        
        var demonyms: [Demonym] = []
        
        var population: String = ""
        var area: String = ""
        var continents: String = ""
        var landlockedInfo = ""
        var timezones: String = ""
        
        var googleMapURL: URL?
        var openStreetMapURL: URL?
        var countryCodes = CountryCodes(cca2: "", ccn3: "", cca3: "")
    }
    
    enum Action {
        case onViewAppear
    }
    
    private let country: Country
    
    init(country: Country) {
        self.country = country
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onViewAppear:
            state.flagURL = country.flags.png
            state.name = country.name.common
            state.fullName = country.name.official
            state.region = country.region
            state.subregion = country.subregion
            
            state.capitals = (country.capital.count > 1 ? "Capitals: " : "Capital: ") + country.capital.joined(separator: ", ")
            state.callingInfo = "Calling code: \(country.idd.root ?? "Unknown")"
            
            state.unMmemberStatus = country.unMember ? "Member of the United Nations" : "Not a member of the United Nations"
            state.countryTranslations = country.translations.keys.sorted(by: <).compactMap { code in
                country.translations[code].map {
                    .init(
                        language: LanguageCodeHelper.getCountryEmoji(from: code),
                        officialName: $0.official,
                        commonName: $0.common
                    )
                }
            }
            
            state.alternativeNames = country.altSpellings.joined(separator: ", ")
            
            state.currencyInfo = country.currencies.map { _, currency in
                "\(currency.name) (\(currency.symbol))"
            }
            
            state.languages = country.languages
                .map { ($0.key, $0.value) }
                .sorted(by: { $0.0 < $1.0 })
                .map { $0.1 }
                .joined(separator: ", ")
            
            state.demonyms = country.demonyms.keys.sorted(by: <).compactMap { code in
                country.demonyms[code].map {
                    .init(
                        language: LanguageCodeHelper.getCountryEmoji(from: code),
                        demonym: $0.male == $0.female ? $0.male : "\($0.male)/\($0.female)"
                    )
                }
            }
            
            state.population = country.population.formatted(.number) + " people"
            state.area = country.area.formatted(.number) + " square kilometers"
            state.continents = "Located in " + country.continents.joined(separator: ", ")
            state.timezones = "Timezone\(country.timezones.count > 1 ? "s" : ""): " + country.timezones.joined(separator: ", ")
            state.landlockedInfo = country.landlocked ? "Country is landlocked" : "Country is not landlocked"
            
            state.googleMapURL = country.maps["googleMaps"]
            state.openStreetMapURL = country.maps["openStreetMaps"]
            state.countryCodes = .init(cca2: country.cca2, ccn3: country.ccn3, cca3: country.cca3)
            return .none
        }
    }
}
