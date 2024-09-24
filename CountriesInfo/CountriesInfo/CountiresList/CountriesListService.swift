import Foundation

protocol CountriesListService {
    func fetchCountries(text: String, searchType: SearchType) async -> Result<[Country], ResponseError>
}

final class CountriesListServiceImpl: CountriesListService {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = NetworkClientImpl()) {
        self.networkClient = networkClient
    }
    
    func fetchCountries(text: String, searchType: SearchType) async -> Result<[Country], ResponseError> {
        if text.isEmpty {
            return await networkClient.fetch(request: CountriesListAllRequest())
        }
        switch searchType {
        case .countryName:
            return await networkClient.fetch(request: CountriesListByTextRequest(text: text, isFullText: false))
        case .countryNameFullText:
            return await networkClient.fetch(request: CountriesListByTextRequest(text: text, isFullText: true))
        case .countryCode:
            return await networkClient.fetch(request: CountriesListByCodeRequest(text: text))
        case .severalCountryCodes:
            return await networkClient.fetch(request: CountriesListByCodeRequest(severalCodes: text.formatForRequest))
        case .currency:
            return await networkClient.fetch(request: CountriesListByCurrencyRequest(text: text))
        case .demonym:
            return await networkClient.fetch(request: CountriesListByDemonymRequest(text: text))
        case .language:
            return await networkClient.fetch(request: CountriesListByLanguageRequest(text: text))
        case .capital:
            return await networkClient.fetch(request: CountriesListByCapitalRequest(text: text))
        case .region:
            return await networkClient.fetch(request: CountriesListByRegionRequest(text: text))
        case .subregion:
            return await networkClient.fetch(request: CountriesListBySubregionRequest(text: text))
        }
    }
    
}

extension String {
    var formatForRequest: String {
        let pattern = "[^a-zA-Z0-9]+"
        return self.replacingOccurrences(of: pattern, with: ",", options: .regularExpression)
    }
}
