import SwiftUI

struct CountiresListView: View {
    @StateObject var store: StoreOf<CountriesListReducer>
    
    @State private var showingSearchTypePicker: Bool = false
    
    var body: some View {
        Group {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField(
                    "Enter a \(store.state.searchType.placeholderText)",
                    text: .init(
                        get: { store.state.searchText },
                        set: { store.send(.textChanged($0)) }
                    )
                )
                .font(.title2)
                .textFieldStyle(.roundedBorder)
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)
            HStack {
                Image(systemName: "scope")
                Text("Search by \(store.state.searchType.searchName)")
                    .font(.title3)
                Spacer()
            }
            .padding(.horizontal, 16)
            .onTapGesture {
                showingSearchTypePicker.toggle()
            }
            if store.state.countries.isEmpty, let errorText = store.state.errorText {
                EmptyStateView(text: errorText) {
                    store.send(.loadData)
                }
                .frame(maxHeight: .infinity)
            } else if store.state.countries.isEmpty && store.state.isLoading {
                loadingIndicator
            } else {
                ZStack {
                    ScrollView {
                        LazyVStack {
                            ForEach(store.state.countries, id: \.name) { country in
                                NavigationLink(
                                    destination: CountryDetailsView(
                                        store: .init(
                                            initialState: .init(),
                                            reducer: CountryDetailsReducer(country: country.countryModel)
                                        )
                                    )
                                ) {
                                    HStack(alignment: .center) {
                                        Text(country.flagEmoji)
                                            .font(.system(size: 60))
                                        VStack(alignment: .leading) {
                                            Text(country.name)
                                                .font(.title2)
                                            Text(country.officialName)
                                                .font(.caption)
                                        }
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                    }
                                    .contentShape(Rectangle())
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }.refreshable {
                        store.send(.loadData)
                    }
                    .allowsHitTesting(!store.state.isLoading)
                    if store.state.isLoading {
                        loadingIndicator
                    }
                }
            }
        }
        .sheet(isPresented: $showingSearchTypePicker) {
            VStack(alignment: .leading) {
                Text("Search by")
                    .font(.title2)
                    .bold()
                ForEach(SearchType.allCases) { searchType in
                    HStack {
                        Text(searchType.searchName)
                        Spacer()
                        if searchType == store.state.searchType {
                            Image(systemName: "checkmark.circle.fill")
                        }
                    }
                    .padding(.vertical, 10)
                    .onTapGesture {
                        showingSearchTypePicker.toggle()
                        store.send(.searchTypePicked(searchType))
                    }
                }
            }
            .padding(.horizontal, 16)
            .presentationDetents([.fraction(0.65)])
            .presentationDragIndicator(.visible)
        }
        .contentMargins(.horizontal, 16, for: .scrollContent)
        .ignoresSafeArea(.all, edges: .bottom)
        .onFirstAppear {
            store.send(.loadData)
        }
    }
    
    @ViewBuilder
    private var loadingIndicator: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ProgressView()
                Spacer()
            }
            .padding(.top, 30)
            Spacer()
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
