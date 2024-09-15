import Foundation

struct CountriesListReducer: Reducer {
    
    let countriesService: CountriesListService
    
    struct State {
        struct CountryViewData {
            let name: String
        }
        
        var searchText = ""
        var countries: [CountryViewData] = []
    }
    
    enum Action {
        case onFirstAppear
        case filterPicked
        case textChanged(String)
        case countriesFetched([State.CountryViewData])
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onFirstAppear:
            return .run({ [state = state] sendAction in
                Task {
                    let response = await countriesService.fetchCountries(text: state.searchText, isFullText: false)
                    switch response {
                    case let .success(countries):
                        let fetchedCountries = countries.map { State.CountryViewData(name: $0.name.official) }
                        sendAction?(.countriesFetched(fetchedCountries))
                    case let .failure(error):
                        print(error)
                    }
                }
            })
        case .filterPicked:
            return .none
        case let .textChanged(text):
            state.searchText = text
            return .none
        case let .countriesFetched(countries):
            state.countries = countries
            return .none
        }
    }
}
