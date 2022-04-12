//
//  PlatformsResponseMock.swift
//  GameNetTests
//
//  Created by Alliston Aleixo on 12/04/22.
//

import Foundation

final class PlatformsResponseMock {
    let fakeSuccessPlatformsResponse: [String: Any?] = [
        "data": [
            "count": 2,
            "totalCount": 2,
            "totalPages": 1,
            "page": nil,
            "pageSize": nil,
            "search": "",
            "result": [
                [
                    "name": "Nintendo Switch",
                    "id": "123"
                ],
                [
                    "name": "PlayStation 5",
                    "id": "456"
                ]
            ]
        ],
        "ok": true,
        "errors": []
    ]
}
