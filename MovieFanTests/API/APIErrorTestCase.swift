//
//  APIErrorTestCase.swift
//  MovieFanTests
//
//  Created by Mohammed ELMeseery on 6/21/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import XCTest
@testable import MovieFan

class APIErrorTestCase: XCTestCase {
    
    var client: APIHTTPClientType!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        client = APIHTTPClientMock()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        client = nil
    }
    
    func testAPIErrorInvalidURL() {
        let req = APIRequest<MovieListResponse>(route: Route.getRoute(path: "invalidroute"))
        req.changeAPIClient(client: client)
        req.response { (result) in
            switch result {
            case .success(_):
                XCTFail("Invalid response received, should fail")
                break
            case .failure(let error):
                XCTAssertFalse(error.description.isEmpty)
                XCTAssertTrue(error.description == "Invalid URL. Please check the endPoint: invalidroute")
                break
            }
        }
    }
    
    func testAPIErrorEmptyData() {
        let req = NowPlayingMoviesRequest(page: 2)
        req.changeAPIClient(client: client)
        req.response { (result) in
            switch result {
            case .success(let response):
                XCTAssertTrue(response.page == 993)
                XCTAssertTrue(response.results.count == 0)
                XCTAssertTrue(response.totalPages == 991)
                XCTAssertTrue(response.totalResults == 19801)
                break
            case .failure(_):
                XCTFail("Response must not be nil")
                break
            }
        }
    }
    
    func testAPIErrorResponseSerialization() {
        let req = NowPlayingMoviesRequest(page: 5)
        req.changeAPIClient(client: client)
        req.response { (result) in
            switch result {
            case .success(_):
                XCTFail("Invalid response received, should fail")
                break
            case .failure(let error):
                XCTAssertFalse(error.description.isEmpty)
                XCTAssertTrue(error.description == "Json Decoding Error: The data couldn’t be read because it isn’t in the correct format.")
                break
            }
        }
    }
}
