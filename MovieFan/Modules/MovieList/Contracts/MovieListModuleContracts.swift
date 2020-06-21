//
//  MovieListModuleContracts.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import Foundation

protocol MovieListRouterProtocol: class {
    func pushMovieDetailScene(view: MovieListViewProtocol, movie: Movie)
    func pushFavouriteMoviesScene(view: MovieListViewProtocol)
}

protocol MovieListViewProtocol: BaseView {
    var presenter: MovieListPresenterProtocol? { get set }
    
    func showMovieList(viewModel: MovieListViewModel)
    func reloadMovieList(at indexPaths: [IndexPath])
    func addMoreMovies(at indexPaths: [IndexPath])
}

protocol MovieListPresenterProtocol: BasePresenter, MovieListInteractorOutputProtocol {
    var view: MovieListViewProtocol? { get set }
    var interactor: MovieListInteractorProtocol? { get set }
    var router: MovieListRouterProtocol? { get set }
    
    func retryLoadingMovies()
    func willDisplayCell(at indexPath: IndexPath)
    func didSelectMovie(at indexPath: IndexPath)
    func selectedFavouriteMovies()
    func selectedFavourite(at indexPath: IndexPath)
}

protocol MovieListInteractorProtocol: class {
    var presenter: MovieListInteractorOutputProtocol? { get set }
    
    func makeMovieListRequest(page: Int)
    func toogleFavourite(movie: Movie)
    func isFavourite(movie: Movie) -> Bool
}

protocol MovieListInteractorOutputProtocol: class {
    func onMoviesFetchSuccess(response: MovieListResponse)
    func onMoviesFetchError(error: APIError)
}
