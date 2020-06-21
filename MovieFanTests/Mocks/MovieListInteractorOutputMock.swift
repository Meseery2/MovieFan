//
//  MovieListInteractorOutputMock.swift
//  MovieFanTests
//
//  Created by Mohammed ELMeseery on 6/21/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import XCTest
@testable import MovieFan

class MovieListInteractorOutputMock: MovieListInteractorOutputProtocol {
    var success = false
    
    func onMoviesFetchSuccess(response: MovieListResponse) {
        success = true
//        XCTAssertFalse(response.results.isEmpty)
    }
    
    func onMoviesFetchError(error: APIError) {
        success = false
    }
}
