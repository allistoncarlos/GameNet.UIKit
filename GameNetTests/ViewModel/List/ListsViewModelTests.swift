//
//  ListsViewModelTests.swift
//  GameNetTests
//
//  Created by Alliston Aleixo on 11/04/22.
//

import XCTest
@testable import GameNet_UIKit

final class ListsViewModelTests: XCTestCase {
    // MARK: - Properties
    let mock = ListsResponseMock()
    let stubRequests = StubRequests()
    var viewModel: ListsViewModelProtocol?
    
    // MARK: - SetUp/TearDown
    override func setUp() {
        super.setUp()
        
        viewModel = ListsViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        
        viewModel = nil
        KeychainDataSource.clear()
    }
    
    // MARK: - Tests
    func testFetchLists_ShouldReturnValidData() async {
        // Given
        let fakeJSONResponse = mock.fakeSuccessListsResponse
        
        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: "gamenet.azurewebsites.net")
        
        // When
        await viewModel?.fetchData()
        let result = viewModel?.result
        
        // Then
        XCTAssertNotNil(result)
        
        let dictionary = fakeJSONResponse as NSDictionary
        let list = dictionary.value(forKeyPath: "data.result.@firstObject") as? [String: Any?]
        let resultName = result?[0].name
        let expectedName = list?["name"] as? String
        
        XCTAssertEqual(resultName, expectedName)
    }
}
