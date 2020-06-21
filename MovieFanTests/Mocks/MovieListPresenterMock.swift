//
//  MovieListPresenterMock.swift
//  MovieFanTests
//
//  Created by Mohammed ELMeseery on 6/21/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import XCTest
@testable import MovieFan

class MovieListPresenterMock:MovieListPresenterProtocol, MovieListInteractorOutputProtocol {
    weak var view: MovieListViewProtocol?
    var interactor: MovieListInteractorProtocol?
    var router: MovieListRouterProtocol?
    private var moviesViewModel: MovieListViewModel = MovieListViewModel(pageSize: 20)
    
    var movieFetchSuccess: Bool = false
    var movieSelected: Bool = false
    var willDisplayCalled: Bool = false
        
    func willDisplayCell(at indexPath: IndexPath) {
        if moviesViewModel.canLoadNow(index: indexPath.row) {
            willDisplayCalled = true
            loadMovies()
        }
    }
    
    func didSelectMovie(at indexPath: IndexPath) {
        router?.pushMovieDetailScene(view: view!, movie: moviesViewModel.movie(at: indexPath))
        movieSelected = true
    }
    
    
    func viewDidLoad() {
        loadMovies()
    }
        
    func retryLoadingMovies() {}

    func viewWillAppear() {}
    
    func selectedFavouriteMovies() {}
    
    func selectedFavourite(at indexPath: IndexPath) {}
    
    func onMoviesFetchSuccess(response: MovieListResponse) {
        movieFetchSuccess = true
        if response.page == 1 {
            XCTAssertFalse(response.results.isEmpty)
        } else {
            XCTAssertTrue(response.results.isEmpty)
        }
        moviesViewModel.success(objects: response.results)
        if response.page == 1 {
            view?.showMovieList(viewModel: moviesViewModel)
        } else {
            let previousCount = moviesViewModel.moviesCount - response.results.count
            let totalCount = moviesViewModel.moviesCount
            let indexPaths: [IndexPath] = (previousCount..<totalCount).map {
                return IndexPath(item: $0, section: 0)
            }
            view?.addMoreMovies(at: indexPaths)
        }
    }
    
    func onMoviesFetchError(error: APIError) {
         movieFetchSuccess = false
    }
    
    private func loadMovies() {
        interactor?.makeMovieListRequest(page: moviesViewModel.page)
    }
}
