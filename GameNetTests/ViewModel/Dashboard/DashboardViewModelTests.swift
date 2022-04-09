//
//  DashboardViewModelTests.swift
//  GameNetTests
//
//  Created by Alliston Aleixo on 09/04/22.
//

import XCTest
@testable import GameNet_UIKit

final class DashboardViewModelTests: XCTestCase {
    // MARK: - Properties
    let mock = DashboardResponseMock()
    let stubRequests = StubRequests()
    var viewModel: DashboardViewModelProtocol?
    
    // MARK: - SetUp/TearDown
    override func setUp() {
        super.setUp()
        
        viewModel = DashboardViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        
        viewModel = nil
        KeychainDataSource.clear()
    }
    
    // MARK: - Tests
    func testFetchDashboard_ShouldReturnValidData() async {
        // Given
        let fakeJSONResponse = mock.fakeSuccessDashboardResponse
        
        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: "gamenet.azurewebsites.net")
        
        // When
        await viewModel?.fetchData()
        let result = viewModel?.result
        
        // Then
        XCTAssertNotNil(result)
        let data = fakeJSONResponse["data"] as? [String: Any]
        let totalGames = data?["totalGames"] as? Int
        
        XCTAssertNotNil(totalGames)
        XCTAssertEqual(result?.totalGames, totalGames)
    }
}
