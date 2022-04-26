//
//  GamesTests.swift
//  GameNetTests
//
//  Created by Alliston Aleixo on 20/04/22.
//

import XCTest
@testable import GameNet_UIKit

final class GamesTests: XCTestCase {
    // MARK: - Properties
    let mock = GamesResponseMock()
    let stubRequests = StubRequests()
    
    // MARK: - SetUp/TearDown
    override func tearDown() {
        super.tearDown()
        KeychainDataSource.clear()
        URLCache.shared.removeAllCachedResponses()
    }
    
    // MARK: - Tests
    func testGamesFetch_ValidParameters_ShouldReturnValidData() async {
        // Given
        let page = 0
        let pageSize = Constants.pageSize
        let absoluteStringWord = "\(Constants.gameResource)?page=\(page)&pageSize=\(pageSize)"
        let fakeJSONResponse = mock.fakeSuccessGamesPagedResponse
        
        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: absoluteStringWord)
            
        // When
        let result = await NetworkManager.shared
            .performRequest(
                model: APIResult<PagedResult<GameModel>>.self,
                endpoint: .games(search: nil, page: page, pageSize: pageSize))
        
        // Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.ok, true)
        
        let dictionary = fakeJSONResponse as NSDictionary
        let game = dictionary.value(forKeyPath: "data.result.@firstObject") as? [String: Any?]
        let resultName = result?.data.result[0].name
        let expectedName = game?["gameName"] as? String
        XCTAssertEqual(resultName, expectedName)
    }
    
    func testGamesFetch_ValidSearchParameters_ShouldReturnValidData() async {
        // Given
        let page = 0
        let pageSize = 21
        let search = "zelda"
        let fakeJSONResponse = mock.fakeSuccessGamesPagedSearchResponse
        
        stubRequests.stubJSONResponse(
            jsonObject: fakeJSONResponse,
            header: nil,
            statusCode: 200,
            absoluteStringWord: "\(Constants.gameResource)?search=\(search)&page=\(page)&pageSize=\(pageSize)")

        // When
        let result = await NetworkManager.shared
            .performRequest(
                model: APIResult<PagedResult<GameModel>>.self,
                endpoint: .games(search: search, page: page, pageSize: pageSize))
        
        // Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.ok, true)
        
        let dictionary = fakeJSONResponse as NSDictionary
        let game = dictionary.value(forKeyPath: "data.result.@firstObject") as? [String: Any?]
        let resultName = result?.data.result[0].name
        let expectedName = game?["gameName"] as? String
        XCTAssertEqual(resultName, expectedName)
    }
}
