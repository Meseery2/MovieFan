//
//  MovieSearchContracts.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import Foundation

protocol MovieSearchRouterProtocol: class {
    func dismiss(view: MovieSearchViewProtocol)
}

protocol MovieSearchViewProtocol: BaseView {
    var presenter: MovieSearchPresenterProtocol? { get set }
    
    func showSearchResult(movies: [Movie])
}

protocol MovieSearchPresenterProtocol: BasePresenter {
    var view: MovieSearchViewProtocol? { get set }
    var interactor: MovieSearchInteractorProtocol? { get set }
    var router: MovieSearchRouterProtocol? { get set }

    func setFilterMovies(movies: [Movie])
    func searchMovie(searchText: String)
    func didSelectMovie(indexPath: IndexPath)
    func selectedFavourite(at indexPath: IndexPath)
}

protocol MovieSearchInteractorProtocol: class {
    var presenter: MovieSearchInteractorOutputProtocol? { get set }
    
    func toogleFavourite(movie: Movie)
}

protocol MovieSearchInteractorOutputProtocol: class {}
