//
//  StubRequests.swift
//  GameNetTests
//
//  Created by Alliston Aleixo on 09/04/22.
//

import OHHTTPStubs

final class StubRequests {
    func stubJSONResponse(jsonObject: [String: Any?],
                          header: [String: String]?,
                          statusCode: Int32,
                          absoluteStringWord: String,
                          slowConnection: Bool = false
    ) {
        stub(condition: { (urlRequest) -> Bool in
            return urlRequest.url?.absoluteString.contains(absoluteStringWord) ?? false
        }) { (_) -> HTTPStubsResponse in
            let response = HTTPStubsResponse(jsonObject: jsonObject, statusCode: statusCode, headers: header)
            
            if slowConnection {
                return response.responseTime(OHHTTPStubsDownloadSpeedGPRS)
            }
            
            return response
        }
    }
}