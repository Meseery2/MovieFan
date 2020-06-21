//
//  MovieListPresenterTestCase.swift
//  MovieFanTests
//
//  Created by Mohammed ELMeseery on 6/21/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import XCTest
@testable import MovieFan

class MovieListPresenterTestCase: XCTestCase {

    var interactor: MovieListInteractorMock!
    var presenter: MovieListPresenterMock!
    var view: MovieListViewMock!
    var router: MovieListRouterMock!
    
    override func setUp() {
        let client = APIHTTPClientMock()
        presenter = MovieListPresenterMock()
        interactor = MovieListInteractorMock(presenter: presenter, client: client)
        router = MovieListRouterMock()
        view = MovieListViewMock(presenter: presenter)
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
    }
    
    override func tearDown() {
        presenter = nil
        view = nil
        interactor = nil
        router = nil
    }
    
    func testShowLoadMovies() {
        presenter.viewDidLoad()
        wait(for: 2)
        XCTAssertTrue(presenter.movieFetchSuccess)
        XCTAssertTrue(view.showMovies)
    }
    
    func testAddMoreMovies() {
        presenter.viewDidLoad()
        wait(for: 2)
        presenter.willDisplayCell(at: IndexPath(row: 18, section: 0))
        wait(for: 2)
        XCTAssertTrue(presenter.movieFetchSuccess)
        XCTAssertTrue(presenter.willDisplayCalled)
        XCTAssertTrue(view.addMoreMovies)
    }

    func testdidSelectMovie() {
        presenter.viewDidLoad()
        wait(for: 2)
        presenter.didSelectMovie(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(presenter.movieSelected)
    }
}
