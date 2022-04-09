//
//  DashboardResponseMock.swift
//  GameNetTests
//
//  Created by Alliston Aleixo on 09/04/22.
//

import Foundation

final class DashboardResponseMock {
    let fakeSuccessDashboardResponse: [String: Any] = [
        "ok": true,
        "errors": [String](),
        "data": [
            "boughtByYear": [
                [
                    "quantity": 3,
                    "total": 200.33,
                    "year": 2022
                ],
                [
                    "quantity": 10,
                    "total": 687.54,
                    "year": 2021
                ],
                [
                    "quantity": 17,
                    "total": 914,
                    "year": 2020
                ]
            ],
            "finishedByYear": [
                [
                    "total": 2,
                    "year": 2022
                ],
                [
                    "total": 7,
                    "year": 2021
                ],
                [
                    "total": 7,
                    "year": 2020
                ]
            ],
            "gamesByPlatform": [
                "platforms": [
                    [
                        "platformGamesTotal": 18,
                        "platformId": "123",
                        "platformName": "Nintendo 3DS"
                    ],
                    [
                        "platformGamesTotal": 83,
                        "platformId": "456",
                        "platformName": "PlayStation 4"
                    ],
                    [
                        "platformGamesTotal": 18,
                        "platformId": "789",
                        "platformName": "Nintendo WiiU"
                    ]
                ],
                "total": 378
            ],
            "totalGames": 481,
            "totalPrice": 9000.75
        ]
    ]
}
