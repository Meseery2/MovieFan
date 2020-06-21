//
//  MovieListInteractorTestCase.swift
//  MovieFanTests
//
//  Created by Mohammed ELMeseery on 6/21/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import XCTest
@testable import MovieFan

class MovieListInteractorTestCase: XCTestCase {
    var interactor: MovieListInteractorMock!
    var presenter: MovieListInteractorOutputMock!
    var client: APIHTTPClientType!
    
    override func setUp() {
        presenter = MovieListInteractorOutputMock()
        client = APIHTTPClientMock()
        interactor = MovieListInteractorMock(presenter: presenter, client: client)
    }
    
    override func tearDown() {
        interactor = nil
        presenter = nil
        client = nil
    }
    
    func testLoadMovies() {
        interactor.makeMovieListRequest(page: 1)
        wait(for: 10)
        XCTAssertTrue(presenter.success)
        XCTAssertTrue(interactor.requestCalled)
    }
    
    func testLoadMoviesError() {
        interactor.makeMovieListRequest(page: 5)
        wait(for: 2)
        XCTAssertFalse(presenter.success)
        XCTAssertTrue(interactor.requestCalled)
    }
}
