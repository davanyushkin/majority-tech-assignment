import SwiftUI

struct CountiresListView: View {
    @StateObject var store: StoreOf<CountriesListReducer>
    
    var body: some View {
        Group {
            TextField(
                "Enter a country",
                text: .init(
                    get: { store.state.searchText },
                    set: { store.send(.textChanged($0)) }
                )
            )
            ScrollView {
                VStack {
                    ForEach(store.state.countries, id: \.name) {
                        Text($0.name)
                    }
                }
            }
        }
        .padding()
        .ignoresSafeArea(.all, edges: .bottom)
        .onFirstAppear {
            store.send(.onFirstAppear)
        }
    }
}

#Preview {
    CountiresListView(
        store: Store(
            initialState: .init(),
            reducer: PreviewReducer { _, action in
                print(action)
                return .none
            }
        )
    )
}
