//
//  ListsTests.swift
//  GameNetTests
//
//  Created by Alliston Aleixo on 09/04/22.
//

import XCTest
@testable import GameNet_UIKit

final class ListsTests: XCTestCase {
    // MARK: - Properties
    let mock = ListsResponseMock()
    let stubRequests = StubRequests()
    
    // MARK: - SetUp/TearDown
    override func tearDown() {
        super.tearDown()
        KeychainDataSource.clear()
        URLCache.shared.removeAllCachedResponses()
    }
    
    // MARK: - Tests
    func testListFetch_Unauthorized_ShouldReturnNil() async {
        // Given
        stubRequests.stubJSONResponse(jsonObject: [String: Any](), header: nil, statusCode: 401, absoluteStringWord: "gamenet.azurewebsites.net")
        
        // When
        let result = await NetworkManager.shared
            .performRequest(
                model: ListModel.self,
                endpoint: .dashboard)
        
        // Then
        XCTAssertNil(result)
    }
    
    func testListFetch_ValidParameters_ShouldReturnValidId() async {
        // Given
        let fakeJSONResponse = mock.fakeSuccessListsResponse
        
        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: "gamenet.azurewebsites.net")
            
        // When
        let result = await NetworkManager.shared
            .performRequest(
                model: APIResult<PagedResult<ListModel>>.self,
                endpoint: .lists)
        
        // Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.ok, true)
        
        let dictionary = fakeJSONResponse as NSDictionary
        let list = dictionary.value(forKeyPath: "data.result.@firstObject") as? [String: Any?]
        let resultName = result?.data.result[0].name
        let expectedName = list?["name"] as? String
        XCTAssertEqual(resultName, expectedName)
    }
}
