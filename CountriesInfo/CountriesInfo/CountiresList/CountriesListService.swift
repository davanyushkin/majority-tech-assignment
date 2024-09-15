import Foundation

protocol CountriesListService {
    func fetchCountries(text: String, isFullText: Bool) async -> Result<[Country], ResponseError>
}

final class CountriesListServiceImpl: CountriesListService {
    
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient = NetworkClientImpl()) {
        self.networkClient = networkClient
    }
    
    func fetchCountries(text: String, isFullText: Bool) async -> Result<[Country], ResponseError> {
        if text.isEmpty {
            return await networkClient.fetch(request: CountriesListAllRequest())
        }
        return await networkClient.fetch(request: CountriesListByTextRequest(text: text, isFullText: isFullText))
    }
}
