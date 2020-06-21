//
//  MovieListPresenter.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import Foundation

class MovieListPresenter: MovieListPresenterProtocol {
    
    weak var view: MovieListViewProtocol?
    var interactor: MovieListInteractorProtocol?
    var router: MovieListRouterProtocol?
    
    private var moviesViewModel: MovieListViewModel = MovieListViewModel(pageSize: 20)
    private var lastSelectedIndexPath: IndexPath?
    
    func willDisplayCell(at indexPath: IndexPath) {
        if moviesViewModel.canLoadNow(index: indexPath.row) {
            loadMovieList()
        }
    }
    
    func viewDidLoad() {
        loadMovieList()
    }
    
    func viewWillAppear() {
        if let indexPath = lastSelectedIndexPath {
            view?.reloadMovieList(at: [indexPath])
            lastSelectedIndexPath = nil
        } else {
            _ = moviesViewModel.data.map {
                $0.isFavoured = interactor?.isFavourite(movie: $0) ?? false
            }
            view?.reloadMovieList(at: [])
        }
    }
    
    func retryLoadingMovies() {
        view?.hideErrorView()
        loadMovieList()
    }
    
    private func loadMovieList() {
        if moviesViewModel.isLoading { return }
        moviesViewModel.start()
        view?.showLoading(message: "Loading...")
        interactor?.makeMovieListRequest(page: moviesViewModel.page)
    }
    
    func didSelectMovie(at indexPath: IndexPath) {
        let movie = moviesViewModel.movie(at: indexPath)
        lastSelectedIndexPath = indexPath
        router?.pushMovieDetailScene(view: view!, movie: movie)
    }
    
    func selectedFavouriteMovies() {
        router?.pushFavouriteMoviesScene(view: view!)
    }
    
    func selectedFavourite(at indexPath: IndexPath) {
        let movie = moviesViewModel.movie(at: indexPath)
        movie.isFavoured = !movie.isFavoured
        interactor?.toogleFavourite(movie: movie)
    }
}

extension MovieListPresenter: MovieListInteractorOutputProtocol {
    func onMoviesFetchSuccess(response: MovieListResponse) {
        view?.hideLoading()
        _ = response.results.map { $0.isFavoured = interactor?.isFavourite(movie: $0) ?? false }
        let sortedList = response.results.sorted(by: {$0.title.localizedCaseInsensitiveCompare($1.title) == .orderedAscending})
        moviesViewModel.success(objects: sortedList)
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
        view?.hideLoading()
        moviesViewModel.failed()
        view?.showErrorView(type: .Custom(title: nil, desc: error.description, image: Image.icEmptyState.image, buttonAction: "Retry"))
    }
}
