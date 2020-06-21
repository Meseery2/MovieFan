//
//  MovieSearchPresenter.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import Foundation

class MovieSearchPresenter: MovieSearchPresenterProtocol {
    
    weak var view: MovieSearchViewProtocol?
    var interactor: MovieSearchInteractorProtocol?
    var router: MovieSearchRouterProtocol?
    private var movies: [Movie] = []
    private var moviesResult: [Movie] = []
    private weak var delegate: MovieSearchResultViewDelegate?
    
    init(delegate: MovieSearchResultViewDelegate?) {
        self.delegate = delegate
    }
    
    func viewDidLoad() {}
    
    func viewWillAppear() {}
    
    func setFilterMovies(movies: [Movie]) {
        self.movies.removeAll()
        self.moviesResult.removeAll()
        self.movies.append(contentsOf: movies)
        view?.showSearchResult(movies: moviesResult)
    }
    
    func searchMovie(searchText: String) {
        moviesResult.removeAll()
        moviesResult.append(contentsOf: movies.filter { $0.title.lowercased().contains(searchText.lowercased()) })
        view?.showSearchResult(movies: moviesResult)
        if moviesResult.count == 0 {
            view?.showErrorView(type: .Custom(title: nil, desc: "No matching results found", image: Image.icEmptyState.image, buttonAction: nil))
        } else {
            view?.hideErrorView()
        }
    }
    
    func didSelectMovie(indexPath: IndexPath) {
        let movie = moviesResult[indexPath.row]
        let index = movies.firstIndex(where: { $0.id == movie.id })
        let originalIndexPath = IndexPath(row: index ?? indexPath.row, section: 0)
        delegate?.movieSeachView(tappedMovie: originalIndexPath)
        router?.dismiss(view: view!)
    }
    
    func selectedFavourite(at indexPath: IndexPath) {
        let movie = moviesResult[indexPath.row]
        movie.isFavoured = !movie.isFavoured
        interactor?.toogleFavourite(movie: movie)
    }
}

extension MovieSearchPresenter: MovieSearchInteractorOutputProtocol {}
