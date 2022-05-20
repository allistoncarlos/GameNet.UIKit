//
//  EditListViewModelTests.swift
//  GameNetTests
//
//  Created by Alliston Aleixo on 14/04/22.
//

import XCTest
import GameNet_Network
import GameNet_Keychain
@testable import GameNet_UIKit

final class EditListViewModelTests: XCTestCase {
    // MARK: - Properties
    let mock = ListResponseMock()
    let stubRequests = StubRequests()
    var viewModel: EditListViewModelProtocol?
    
    // MARK: - SetUp/TearDown
    override func setUp() {
        super.setUp()
        
        viewModel = EditListViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        
        viewModel = nil
        KeychainDataSource.clear()
    }
    
    // MARK: - Tests
    func testFetchPlatform_ShouldReturnValidData() async {
        // Given
        let id = "123"
        let fakeJSONResponse = mock.fakeListSuccessResponse

        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: Constants.listResource)

        // When
        await viewModel?.fetchData(id: id)
        let result = viewModel?.result

        // Then
        XCTAssertNotNil(result)

        let dictionary = fakeJSONResponse as NSDictionary
        let list = dictionary.value(forKeyPath: "data") as? [String: Any?]
        let resultName = result?.name
        let expectedName = list?["name"] as? String

        XCTAssertEqual(resultName, expectedName)
    }
    
    func testSaveNewPlatform_ValidParameters_ShouldReturnValidPlatform() async {
        // Given
        let name = "Nova Lista"
        let fakeJSONResponse = mock.fakeSaveNewListResponse
        
        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 201, absoluteStringWord: Constants.listResource)

        // When
        await viewModel?.save(id: nil, data: List(id: nil, name: name))
        let result = viewModel?.result
        
        // Then
        XCTAssertNotNil(result)
        
        let dictionary = fakeJSONResponse as NSDictionary
        let platformName = dictionary.value(forKeyPath: "data.name") as? String
        XCTAssertEqual(platformName, name)
    }

    func testSaveExistingPlatform_ValidParameters_ShouldReturnValidPlatforms() async {
        // Given
        let id = "123"
        let name = "Plataforma Existente"
        let fakeJSONResponse = mock.fakeSaveExistingListResponse
        
        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 201, absoluteStringWord: "/\(Constants.listResource)?id=\(id)")

        // When
        await viewModel?.save(id: id, data: List(id: id, name: name))
        let result = viewModel?.result
        
        // Then
        XCTAssertNotNil(result)
        
        let dictionary = fakeJSONResponse as NSDictionary
        let platformName = dictionary.value(forKeyPath: "data.name") as? String
        XCTAssertEqual(platformName, name)
    }
}
