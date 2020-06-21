//
//  MovieListBuilderTestCase.swift
//  MovieFanTests
//
//  Created by Mohammed ELMeseery on 6/21/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import XCTest
@testable import MovieFan

class MovieListBuilderTestCase: XCTestCase {    
    var viewController: MovieListViewProtocol!
    var presenter: MovieListPresenterProtocol!
    var interactor: MovieListInteractorProtocol!
    var router: MovieListRouterProtocol!
    
    override func setUp() {
        super.setUp()
        viewController = AppNavigationCordinator.buildMovieListModule() as? MovieListViewProtocol
        presenter = viewController.presenter
        interactor = presenter.interactor
        router = presenter.router
    }
    
    override func tearDown() {
        viewController = nil
        presenter = nil
        interactor = nil
        router = nil
    }
    
    func testMovieListModule() {
        XCTAssertTrue(viewController != nil)
        XCTAssertTrue(presenter != nil)
        XCTAssertTrue(interactor != nil)
        XCTAssertTrue(router != nil)
    }
    
    func testMovieListModuleViewController() {
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(viewController.presenter)
        XCTAssertTrue((viewController.presenter) != nil)
    }
    
    func testMovieListModulePresenter() {
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(presenter.view)
        XCTAssertNotNil(presenter.interactor)
        XCTAssertNotNil(presenter.router)
        XCTAssertTrue((presenter.view) != nil)
        XCTAssertTrue((presenter.interactor) != nil)
        XCTAssertTrue((presenter.router) != nil)
    }
    
    func testMovieListModuleInteractor() {
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(interactor.presenter)
        XCTAssertTrue(interactor.presenter is MovieListPresenterProtocol)
    }
    
    func testMovieListModuleRouter() {
        XCTAssertNotNil(router)
    }
}
