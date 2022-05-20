//
//  EditGameViewModelTests.swift
//  GameNetTests
//
//  Created by Alliston Aleixo on 26/04/22.
//

import GameNet_Network
import GameNet_Keychain
@testable import GameNet_UIKit
import XCTest

final class EditGameViewModelTests: XCTestCase {
    // MARK: - Properties

    let mock = GamesResponseMock()
    let stubRequests = StubRequests()
    var viewModel: EditGameViewModelProtocol?

    // MARK: - SetUp/TearDown

    override func setUp() {
        super.setUp()

        let platformsViewModel = PlatformsViewModel()
        let gamesViewModel = GamesViewModel()

        viewModel = EditGameViewModel(
            gamesViewModel: gamesViewModel,
            platformsViewModel: platformsViewModel)
    }

    override func tearDown() {
        super.tearDown()

        viewModel = nil
        KeychainDataSource.clear()
    }

    // MARK: - Tests

    func testFetchPlatforms_ShouldReturnValidData() async {
        // Given
        let fakeJSONResponse = mock.fakeSuccessPlatformsResponse

        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: Constants.platformResource)

        // When
        await viewModel?.fetchPlatforms()
        let result = viewModel?.platformsResult

        // Then
        XCTAssertNotNil(result)

        let dictionary = fakeJSONResponse as NSDictionary
        let platform = dictionary.value(forKeyPath: "data.result.@firstObject") as? [String: Any?]
        let resultName = result?[0].name
        let expectedName = platform?["name"] as? String
        XCTAssertEqual(resultName, expectedName)
    }

    func testFetchGame_ShouldReturnValidData() async {
        // Given
        let id = "123"
        let fakeJSONResponse = mock.fakeSuccessGameResponse

        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 200, absoluteStringWord: "\(Constants.gameResource)/\(id)")

        // When
        await viewModel?.fetchData(id: id)
        let result = viewModel?.result

        // Then
        XCTAssertNotNil(result)

        let dictionary = fakeJSONResponse as NSDictionary
        let game = dictionary.value(forKeyPath: "data") as? [String: Any?]
        let resultName = result?.name
        let expectedName = game?["gameName"] as? String
        XCTAssertEqual(resultName, expectedName)
    }

    func testSaveNewGame_ShouldReturnValidData() async throws {
        // Given
        // Login
        let username = "username123"
        let password = "password123"

        let fakeJSONLoginResponse = LoginResponseMock().fakeSuccessLoginResponse

        stubRequests.stubJSONResponse(jsonObject: fakeJSONLoginResponse, header: nil, statusCode: 200, absoluteStringWord: "/user/login")

        let loginResult = await UserViewModel().login(username: username, password: password)
        let userId = KeychainDataSource.id.get()

        XCTAssertNotNil(loginResult)
        XCTAssertNotNil(userId)

        // Load Cover
        let imageUrl = "https://placehold.co/600x400.jpg"
        let url = URL(string: imageUrl)!

        let (coverData, _) = try await URLSession.shared.data(from: url)

        // Save Game
        let gameEdit = Game(
            id: nil,
            name: "Teste Save",
            cover: coverData,
            coverURL: nil,
            platformId: "123",
            platform: "Nintendo Switch"
        )

        let userGameEdit = UserGame(
            id: nil,
            gameId: "123",
            userId: userId!,
            price: 0,
            boughtDate: Date(),
            have: true,
            want: false,
            digital: true,
            original: false
        )

        let fakeJSONResponse = mock.fakeSuccessSaveGameResponse
        let fakeJSONUserGameResponse = mock.fakeSuccessSaveUserGameResponse

        stubRequests.stubJSONResponse(jsonObject: fakeJSONResponse, header: nil, statusCode: 201, absoluteStringWord: "/api/game")
        stubRequests.stubJSONResponse(jsonObject: fakeJSONUserGameResponse, header: nil, statusCode: 201, absoluteStringWord: "/api/usergame")

        // When
        await viewModel?.save(data: gameEdit, userGameData: userGameEdit)
        let result = viewModel?.result

        // Then
        XCTAssertNotNil(result)
    }
}
