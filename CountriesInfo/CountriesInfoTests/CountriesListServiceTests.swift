@testable import CountriesInfo
import XCTest

final class CountriesInfoTests: XCTestCase {
    
    func testEmptyTextRequests() async {
        // Arrange
        let networkClientMock = NetworkClientMock()
        let service = CountriesListServiceImpl(networkClient: networkClientMock)
        let searchTypes = SearchType.allCases
        
        let extpectedCallsAmount = searchTypes.count
        let expectedRequest = CountriesListAllRequest()
        
        // Act
        for searchType in searchTypes {
            _ = await service.fetchCountries(text: "", searchType: searchType)
        }
        
        // Assert
        XCTAssertEqual(networkClientMock.callsAmount[expectedRequest.key], extpectedCallsAmount, "Should be exactly \(extpectedCallsAmount) rquests sent")
        XCTAssertEqual(networkClientMock.callsAmount.keys.count, 1, "Only all countires request should be called")
    }
    
    func testNonEmpyTextRequests() async {
        // Arrange
        let searchTypes = SearchType.allCases
        let searchText = "Well"
        
        let expectedRequests: [any NetworkRequest] = [
            CountriesListByTextRequest(text: searchText, isFullText: false),
            CountriesListByTextRequest(text: searchText, isFullText: true),
            CountriesListByCodeRequest(text: searchText),
            CountriesListByCodeRequest(severalCodes: searchText),
            CountriesListByCurrencyRequest(text: searchText),
            CountriesListByDemonymRequest(text: searchText),
            CountriesListByLanguageRequest(text: searchText),
            CountriesListByCapitalRequest(text: searchText),
            CountriesListByRegionRequest(text: searchText),
            CountriesListBySubregionRequest(text: searchText),
        ]
        
        // Arrange & Act
        for (index, searchType) in searchTypes.enumerated() {
            let networkClientMock = NetworkClientMock()
            let service = CountriesListServiceImpl(networkClient: networkClientMock)
            
            _ = await service.fetchCountries(text: searchText, searchType: searchType)

            // Assert
            XCTAssertEqual(networkClientMock.callsAmount[expectedRequests[index].key], 1, "Only one request should be made for \(expectedRequests[index].key)")
            XCTAssertEqual(networkClientMock.callsAmount.keys.count, 1, "No other request should be called")
        }
        
    }
}
