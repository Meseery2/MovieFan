//
//  MovieListViewMock.swift
//  MovieFanTests
//
//  Created by Mohammed ELMeseery on 6/21/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import XCTest
@testable import MovieFan

class MovieListViewMock: BaseUIViewController, MovieListViewProtocol {
    var presenter: MovieListPresenterProtocol?
    var showMovies: Bool = false
    var addMoreMovies: Bool = false
    var viewModel: MovieListViewModel?
    
    init(presenter: MovieListPresenterMock) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = presenter
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showErrorView(type: EmptyErrorType) {}

    func showMovieList(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        XCTAssertFalse(viewModel.data.isEmpty)
        XCTAssertTrue(viewModel.moviesCount == 20)
        showMovies = true
    }
    
    func reloadMovieList(at indexPaths: [IndexPath]) {
        
    }
    
    func addMoreMovies(at indexPaths: [IndexPath]) {
        XCTAssertFalse(viewModel?.data.isEmpty ?? true)
        XCTAssertTrue(viewModel?.moviesCount == 20)
        addMoreMovies = true
    }
}
