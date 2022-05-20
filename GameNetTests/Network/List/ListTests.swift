//
//  ListTests.swift
//  GameNetTests
//
//  Created by Alliston Aleixo on 11/04/22.
//

import XCTest
import GameNet_Network
import GameNet_Keychain
@testable import GameNet_UIKit

final class ListTests: XCTestCase {
    // MARK: - Properties
    let mock = ListResponseMock()
    let stubRequests = StubRequests()
    
    // MARK: - SetUp/TearDown
    override func tearDown() {
        super.tearDown()
        KeychainDataSource.clear()
        URLCache.shared.removeAllCachedResponses()
    }
    
    // MARK: - Tests
    func testFinishedByYearListFetch_ValidParameters_ShouldReturnValidGames() async {
        // Given
        let year = "2022"
        let fakeJSONResponse = mock.fakeFinishedByYearResponse
        
        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: "gamenet.azurewebsites.net")
        
        // When
        let result = await NetworkManager.shared
            .performRequest(
                responseType: APIResult<[ListItemResponse]>.self,
                endpoint: .finishedByYearList(id: year))
        
        // Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.ok, true)
        
        let dictionary = fakeJSONResponse as NSDictionary
        let list = dictionary.value(forKeyPath: "data.@firstObject") as? [String: Any?]
        let expectedName = list?["gameName"] as? String
        
        XCTAssertEqual(result?.data[0].name, expectedName)
    }
    
    func testBoughtByYearListFetch_ValidParameters_ShouldReturnValidGames() async {
        // Given
        let year = "2022"
        let fakeJSONResponse = mock.fakeBoughtByYearResponse
        
        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: "gamenet.azurewebsites.net")
        
        // When
        let result = await NetworkManager.shared
            .performRequest(
                responseType: APIResult<[ListItemResponse]>.self,
                endpoint: .boughtByYearList(id: year))
        
        // Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.ok, true)
        
        let dictionary = fakeJSONResponse as NSDictionary
        let list = dictionary.value(forKeyPath: "data.@firstObject") as? [String: Any?]
        let expectedName = list?["gameName"] as? String
        
        XCTAssertEqual(result?.data[0].name, expectedName)
    }
    
    func testListFetch_ValidParameters_ShouldReturnValidList() async {
        // Given
        let id = "123"
        let fakeJSONResponse = mock.fakeListSuccessResponse
        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: "gamenet.azurewebsites.net")
        
        // When
        let result = await NetworkManager.shared
            .performRequest(
                responseType: APIResult<ListGameResponse>.self,
                endpoint: .list(id: id))
        
        // Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.ok, true)
        
        let dictionary = fakeJSONResponse as NSDictionary
        XCTAssertEqual(result?.data.name, dictionary.value(forKeyPath: "data.name") as? String)
    }
}
