//
//  StubRequests.swift
//  GameNetTests
//
//  Created by Alliston Aleixo on 09/04/22.
//

import OHHTTPStubs

final class StubRequests {
    func stubJSONrespone (jsonObject: [String: Any], header: [String: String]?, statusCode: Int32, absoluteStringWord: String) {
        stub(condition: { (urlRequest) -> Bool in
            return urlRequest.url?.absoluteString.contains(absoluteStringWord) ?? false
        }) { (_) -> HTTPStubsResponse in
            return HTTPStubsResponse(jsonObject: jsonObject, statusCode: statusCode, headers: header)
        }
    }
}
