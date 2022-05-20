//
//  ListDetailViewModelTests.swift
//  GameNetTests
//
//  Created by Alliston Aleixo on 11/04/22.
//

import XCTest
import GameNet_Keychain
@testable import GameNet_UIKit

final class ListDetailViewModelTests: XCTestCase {
    // MARK: - Properties
    let mock = ListResponseMock()
    let stubRequests = StubRequests()
    var viewModel: ListDetailViewModelProtocol?
    
    // MARK: - SetUp/TearDown
    override func setUp() {
        super.setUp()
        
        viewModel = ListDetailViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        
        viewModel = nil
        KeychainDataSource.clear()
    }
    
    // MARK: - Tests
    func testFetchFinishedByYearList_ShouldReturnValidData() async {
        // Given
        let id = "123"
        let fakeJSONResponse = mock.fakeFinishedByYearResponse
        
        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: "gamenet.azurewebsites.net")
        
        // When
        viewModel?.listType = .finishedByYear
        await viewModel?.fetchData(id: id)
        let result = viewModel?.result
        
        // Then
        XCTAssertNotNil(result)
        
        let dictionary = fakeJSONResponse as NSDictionary
        let list = dictionary.value(forKeyPath: "data.@firstObject") as? [String: Any?]
        let expectedName = list?["gameName"] as? String
        
        XCTAssertEqual(result?[0].name, expectedName)
    }
    
    func testFetchBoughtByYearList_ShouldReturnValidData() async {
        // Given
        let id = "123"
        let fakeJSONResponse = mock.fakeBoughtByYearResponse
        
        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: "gamenet.azurewebsites.net")
        
        // When
        viewModel?.listType = .boughtByYear
        await viewModel?.fetchData(id: id)
        let result = viewModel?.result
        
        // Then
        XCTAssertNotNil(result)
        
        let dictionary = fakeJSONResponse as NSDictionary
        let list = dictionary.value(forKeyPath: "data.@firstObject") as? [String: Any?]
        let expectedName = list?["gameName"] as? String
        
        XCTAssertEqual(result?[0].name, expectedName)
    }
    
    func testFetchCustomList_ShouldReturnValidData() async {
        // Given
        let id = "123"
        let fakeJSONResponse = mock.fakeListSuccessResponse
        
        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: "gamenet.azurewebsites.net")
        
        // When
        viewModel?.listType = .custom
        await viewModel?.fetchData(id: id)
        let result = viewModel?.result
        
        // Then
        XCTAssertNotNil(result)
        
        let dictionary = fakeJSONResponse as NSDictionary
        let list = dictionary.value(forKeyPath: "data.games.@firstObject") as? [String: Any?]
        let expectedName = list?["gameName"] as? String
        
        XCTAssertEqual(result?[0].name, expectedName)
    }
}
