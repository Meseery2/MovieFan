//
//  APIRequestTestCase.swift
//  MovieFanTests
//
//  Created by Mohammed ELMeseery on 6/21/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import XCTest
@testable import MovieFan

class APIRequestTestCase: XCTestCase {

    var client: APIHTTPClientType!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        client = APIHTTPClientMock()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        client = nil
    }
    
    func testNowPlayingMoviesResponseSuccess() {
        let req = NowPlayingMoviesRequest(page: 1)
        req.changeAPIClient(client: client)
        req.response { (result) in
            switch result {
            case .success(let response):
                XCTAssertTrue(response.page == 1)
                XCTAssertFalse(response.results.count == 10)
                XCTAssertTrue(response.totalPages == 991)
                XCTAssertTrue(response.totalResults == 19801)
                break
            case .failure(_):
                break
            }
        }
    }
}
