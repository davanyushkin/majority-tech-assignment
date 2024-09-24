import Foundation

struct CountriesListReducer: Reducer {
    
    let countriesService: CountriesListService
    let debouncer: Debouncer
    
    struct State {
        struct CountryViewData {
            let name: String
            let officialName: String
            let flagEmoji: String
            let countryModel: Country
        }
        
        var isLoading: Bool = false
        var searchText = ""
        var searchType: SearchType = .countryName
        var countries: [CountryViewData] = []
        var errorText: String?
    }
    
    enum Action {
        case loadData
        case searchTypePicked(SearchType)
        case textChanged(String)
        case countriesFetched([State.CountryViewData], String?)
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .loadData:
            state.isLoading = true
            return .run({ [state = state] sendAction in
                Task { @MainActor in
                    let response = await countriesService.fetchCountries(text: state.searchText, searchType: state.searchType)
                    switch response {
                    case let .success(countries):
                        let fetchedCountries = countries.map {
                            State.CountryViewData(
                                name: $0.name.common,
                                officialName: $0.name.official,
                                flagEmoji: $0.flag,
                                countryModel: $0
                            )
                        }
                        sendAction?(.countriesFetched(fetchedCountries, nil))
                    case let .failure(error):
                        let errorText: String
                        switch error {
                        case let .badRequest(statusCode):
                            if statusCode == 404 {
                                errorText = "No countries found"
                            } else {
                                fallthrough
                            }
                        default:
                            errorText = error.errorAlertText
                        }
                        sendAction?(.countriesFetched([], errorText))
                    }
                }
            })
        case let .searchTypePicked(searchType):
            state.searchType = searchType
            return .run { sendAction in
                sendAction?(.loadData)
            }
        case let .textChanged(text):
            state.searchText = text
            return .run({ sendAction in
                debouncer.emit { @MainActor in
                    sendAction?(.loadData)
                }
            })
        case let .countriesFetched(countries, errorText):
            state.isLoading = false
            state.countries = countries
            state.errorText = errorText
            return .none
        }
    }
}
