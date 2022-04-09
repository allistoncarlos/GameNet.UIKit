//
//  ListResponseMock.swift
//  GameNetTests
//
//  Created by Alliston Aleixo on 09/04/22.
//

import Foundation

final class ListResponseMock {
    let fakeSuccessListResponse: [String: Any?] = [
        "data": [
            "count": 2,
            "totalCount": 2,
            "totalPages": 1,
            "page": nil,
            "pageSize": nil,
            "search": "",
            "result": [
                [
                    "name": "Próximos à Jogar",
                    "creationDate": "2020-05-19T00:00:00Z",
                    "games": [],
                    "id": "123"
                ],
                [
                    "name": "Próximos à Comprar",
                    "creationDate": "2021-11-22T10:34:34Z",
                    "games": [],
                    "id": "456"
                ]
            ]
        ],
        "ok": true,
        "errors": []
    ]
}
