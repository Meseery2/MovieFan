//
//  MovieDetailInteractor.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import Foundation

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    weak var view: MovieDetailViewProtocol?
    var interactor: MovieDetailInteractorProtocol?
    var router: MovieDetailRouterProtocol?
    
    private var movieDetailViewModel: MovieDetailViewModel?
    private var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func viewDidLoad() {
        loadMovieDetail()
    }
    
    func viewWillAppear() {}
    
    func selectFavourite() {
        movieDetailViewModel?.toggleFavourite()
        movie.isFavoured = !movie.isFavoured
        interactor?.toogleFav(movie: movie)
    }
    
    func retryLoadMovieDetail() {
        view?.hideErrorView()
        loadMovieDetail()
    }
    
    private func loadMovieDetail() {
        view?.showLoading(message: "Loading...")
        interactor?.makeMovieDetailRequest(id: movie.id)
    }
    
    func viewAllCast() {
        if let model = movieDetailViewModel {
            router?.pushMovieCastScene(view: view!, model: model)
        }
    }
    
    func rateMovie(rating: Double) {
        interactor?.rateMovie(id: movie.id, rating: rating)
    }
}

extension MovieDetailPresenter: MovieDetailInteractorOutputProtocol {
    func onMovieDetailSuccess(response: MovieDetail) {
        view?.hideLoading()
        let isFav = interactor?.isFavourite(movie: movie) ?? false
        movieDetailViewModel = MovieDetailViewModel(movieDetail: response, isFavourite: isFav)
        view?.showMovieDetail(viewModel: movieDetailViewModel!)
    }
    
    func onMovieDetailError(error: APIError) {
        view?.hideLoading()
        view?.showErrorView(type: .Custom(title: nil, desc: error.description, image: Image.icEmptyState.image, buttonAction: "Retry"))
    }
    
    func onMovieRatingSuccess() {
        view?.showAlert(title: "✅", msg: "Your rating sent successfully", actions: [])
    }
    
    func onMovieRatingError(error: APIError) {
        view?.hideLoading()
        view?.showErrorView(type: .OnlyTitle(title: error.description))
    }
}
