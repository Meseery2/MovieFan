//
//  MovieDetailsContract.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import Foundation

protocol MovieDetailRouterProtocol: class {
    func pushMovieCastScene(view: MovieDetailViewProtocol, model: MovieDetailViewModel)
}

protocol MovieDetailViewProtocol: BaseView {
    var presenter: MovieDetailPresenterProtocol? { get set }
    
    func showMovieDetail(viewModel: MovieDetailViewModel)
}

protocol MovieDetailPresenterProtocol: BasePresenter {
    var view: MovieDetailViewProtocol? { get set }
    var interactor: MovieDetailInteractorProtocol? { get set }
    var router: MovieDetailRouterProtocol? { get set }

    func retryLoadMovieDetail()
    func viewAllCast()
    func selectFavourite()
    func rateMovie(rating: Double)
}

protocol MovieDetailInteractorProtocol: class {
    var presenter: MovieDetailInteractorOutputProtocol? { get set }
    
    func makeMovieDetailRequest(id: Int)
    func toogleFav(movie: Movie)
    func isFavourite(movie: Movie) -> Bool
    func rateMovie(id: Int, rating: Double)
}

protocol MovieDetailInteractorOutputProtocol: class {
    func onMovieDetailSuccess(response: MovieDetail)
    func onMovieDetailError(error: APIError)
    func onMovieRatingSuccess()
    func onMovieRatingError(error: APIError)
}
