//
//  DashboardTests.swift
//  GameNetTests
//
//  Created by Alliston Aleixo on 09/04/22.
//

import XCTest
@testable import GameNet_UIKit

final class DashboardTests: XCTestCase {
    // MARK: - Properties
    let mock = DashboardResponseMock()
    let stubRequests = StubRequests()
    
    // MARK: - SetUp/TearDown
    override func tearDown() {
        super.tearDown()
        KeychainDataSource.clear()
        URLCache.shared.removeAllCachedResponses()
    }
    
    // MARK: - Tests
    func testDashboardFetch_Unauthorized_ShouldReturnNil() async {
        // Given
        stubRequests.stubJSONResponse(jsonObject: [String: Any](), header: nil, statusCode: 401, absoluteStringWord: "gamenet.azurewebsites.net")
        
        // When
        let result = await NetworkManager.shared
            .performRequest(
                model: DashboardModel.self,
                endpoint: .dashboard,
                cache: false)
        
        // Then
        XCTAssertNil(result)
    }
    
    func testDashboardFetch_ValidParameters_ShouldReturnValidTotalGames() async {
        // Given
        let fakeJSONResponse = mock.fakeSuccessDashboardResponse
        
        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: "gamenet.azurewebsites.net")
            
        // When
        let result = await NetworkManager.shared
            .performRequest(
                model: APIResult<DashboardModel>.self,
                endpoint: .dashboard,
                cache: false)
        
        // Then
        XCTAssertNotNil(result)
        
        let data = fakeJSONResponse["data"] as? [String: Any?]
        let totalGames = data?["totalGames"] as? Int
        
        XCTAssertNotNil(totalGames)
        XCTAssertEqual(result?.data.totalGames, totalGames)
    }
}
