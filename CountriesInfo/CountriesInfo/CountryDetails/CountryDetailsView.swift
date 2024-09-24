import SwiftUI

struct CountryDetailsView: View {
    
    @StateObject var store: StoreOf<CountryDetailsReducer>
    
    @State private var showingCountryCodes = false
    @State private var showingDifferentCountryNames = false
    
    var body: some View {
        ScrollView {
            CachingAsyncImage(url: store.state.flagURL) { phase in
                switch phase {
                case let .success(image):
                    image
                default:
                    Color.gray
                }
            }
            .border(.black, width: 2)
            .aspectRatio(1.0, contentMode: .fit)
            .padding(.top, 16)
            Text(store.state.name)
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
            Text(store.state.fullName)
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
            
            Text(store.state.region)
                .font(.title2)
                .multilineTextAlignment(.center)
            if let subregion = store.state.subregion {
                Text(subregion)
                    .font(.title2)
                    .multilineTextAlignment(.center)
            }
            
            VStack(alignment: .leading) {
                sectionTitle("Common info")
                Text(store.state.capitals)
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                Text(store.state.callingInfo)
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 5)
                Text(store.state.unMmemberStatus)
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                Button("How this coutry named in different languages?") {
                    showingDifferentCountryNames.toggle()
                }
                if !store.state.alternativeNames.isEmpty {
                    sectionTitle("Also can be known as:")
                    Text(store.state.alternativeNames)
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                    
                }
                
                sectionTitle("Spoken languages")
                Text(store.state.languages)
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                
                sectionTitle("What currency should I go with?")
                if store.state.currencyInfo.isEmpty {
                    Text("Seems like there is no official currency provided. Take gold bars")
                        .font(.title3)
                } else {
                    ForEach(store.state.currencyInfo, id: \.self) { currency in
                        HStack {
                            Text(currency)
                                .font(.title3)
                            Spacer()
                        }
                    }
                }
                
                if !store.state.demonyms.isEmpty {
                    sectionTitle("How live in this country?")
                    ForEach(store.state.demonyms, id: \.language) { demonym in
                        HStack(alignment: .center) {
                            Text(demonym.language)
                                .bold()
                                .font(.title2)
                            Text(demonym.demonym)
                                .font(.title3)
                            Spacer()
                        }
                    }
                }
                
                sectionTitle("Geography")
                Text(store.state.population)
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                Text(store.state.area)
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                Text(store.state.continents)
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                Text(store.state.landlockedInfo)
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                Text(store.state.timezones)
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                
                sectionTitle("Some extra information")
                if let googleMapURL = store.state.googleMapURL {
                    Button("Reveal in Google Maps") {
                        UIApplication.shared.open(googleMapURL)
                    }
                }
                
                if let openStreetMapURL = store.state.openStreetMapURL {
                    Button("Reveal in Open Street Maps") {
                        UIApplication.shared.open(openStreetMapURL)
                    }
                }
                
                Button("Country codes") {
                    showingCountryCodes.toggle()
                }
            }
        }
        .sheet(isPresented: $showingCountryCodes) {
            VStack(alignment: .leading) {
                Text("All available country codes")
                    .font(.title)
                    .bold()
                    .padding(.bottom, 15)
                HStack {
                    Text("CCA2:")
                        .bold()
                    Text(store.state.countryCodes.cca2)
                    Spacer()
                }
                .font(.title2)
                HStack {
                    Text("CCA3:")
                        .bold()
                    Text(store.state.countryCodes.cca3)
                    Spacer()
                }
                .font(.title2)
                if let ccn3 = store.state.countryCodes.ccn3 {
                    HStack {
                        Text("CCN3:")
                            .bold()
                        Text(ccn3)
                        Spacer()
                    }
                    .font(.title2)
                }
            }
            .padding(.horizontal, 16)
            .presentationDetents([.fraction(0.25)])
            .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $showingDifferentCountryNames) {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(store.state.countryTranslations, id: \.language) { translation in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(translation.language)
                                    .bold()
                                    .font(.title2)
                                    .padding(.top, 15)
                                Text(translation.commonName)
                                    .font(.title2)
                                Text(translation.officialName)
                                    .font(.title2)
                            }
                            Spacer()
                        }
                    }
                }
            }
            .contentMargins(.horizontal, 16, for: .scrollContent)
            .presentationDetents([.fraction(0.45)])
            .presentationDragIndicator(.visible)
        }
        .contentMargins(.horizontal, 16, for: .scrollContent)
        .onFirstAppear {
            store.send(.onViewAppear)
        }
        .navigationTitle(store.state.name)
    }
    
    @ViewBuilder func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.title3)
            .bold()
            .padding(.top, 15)
    }
}
