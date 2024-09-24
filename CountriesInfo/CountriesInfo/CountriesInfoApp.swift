import SwiftUI

@main
struct CountriesInfoApp: App {
    var body: some Scene {
        WindowGroup {
            #if TEST
            EmptyView()
            #endif
            #if !TEST
            NavigationStack {
                CountiresListView(
                    store: Store(
                        initialState: .init(),
                        reducer: CountriesListReducer(
                            countriesService: CountriesListServiceImpl(),
                            debouncer: Debouncer(duration: .seconds(0.5))
                        )
                    )
                )
            }
            #endif
        }
    }
}
