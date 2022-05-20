//
//  GamesViewModelTests.swift
//  GameNetTests
//
//  Created by Alliston Aleixo on 26/04/22.
//

import XCTest
@testable import GameNet_UIKit

final class GamesViewModelTests: XCTestCase {
    // MARK: - Properties
    let mock = GamesResponseMock()
    let stubRequests = StubRequests()
    var viewModel: GamesViewModelProtocol?
    
    // MARK: - SetUp/TearDown
    override func setUp() {
        super.setUp()
        
        viewModel = GamesViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        
        viewModel = nil
        KeychainDataSource.clear()
    }
    
    // MARK: - Tests
    func testFetchGames_ShouldReturnValidData() async {
        // Given
        let fakeJSONResponse = mock.fakeSuccessGamesPagedResponse
        
        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: Constants.gameResource)
        
        // When
        await viewModel?.fetchData()
        let result = viewModel?.pagedList
        
        // Then
        XCTAssertNotNil(result)
        
        let dictionary = fakeJSONResponse as NSDictionary
        let game = dictionary.value(forKeyPath: "data.result.@firstObject") as? [String: Any?]
        let resultName = result?.result[0].name
        let expectedName = game?["gameName"] as? String
        XCTAssertEqual(resultName, expectedName)
    }
    
    func testFetchGames_ValidSearchParameters_ShouldReturnValidData() async {
        // Given
        let page = 0
        let search = "zelda"
        let fakeJSONResponse = mock.fakeSuccessGamesPagedSearchResponse
        
        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: Constants.gameResource)
        
        // When
        await viewModel?.fetchData(search: search, page: page)
        let result = viewModel?.pagedList
        
        // Then
        XCTAssertNotNil(result)
        
        let dictionary = fakeJSONResponse as NSDictionary
        let game = dictionary.value(forKeyPath: "data.result.@firstObject") as? [String: Any?]
        if let resultName = result?.result[0].name {
            let expectedName = game?["gameName"] as? String
            
            XCTAssertEqual(resultName, expectedName)
            XCTAssertTrue(resultName.lowercased().contains(search.lowercased()))
        }
    }
}
