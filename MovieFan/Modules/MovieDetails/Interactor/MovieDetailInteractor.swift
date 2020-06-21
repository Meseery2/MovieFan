//
//  MovieDetailInteractor.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import Foundation

class MovieDetailInteractor: MovieDetailInteractorProtocol {
    weak var presenter: MovieDetailInteractorOutputProtocol?
    private var favouriteSDataManager: LocalDataManager
    
    init(manager: LocalDataManager) {
        self.favouriteSDataManager = manager
    }
    
    func toogleFav(movie: Movie) {
        favouriteSDataManager.toggleFavourite(movie: movie)
    }
    
    func isFavourite(movie: Movie) -> Bool {
        if favouriteSDataManager.isFavourite(movie: movie) != nil {
            return true
        }
        return false
    }
    
    func makeMovieDetailRequest(id: Int) {
        MovieDetailRequest(id: id).response { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.presenter?.onMovieDetailSuccess(response: response)
                break
            case .failure(let error):
                self?.presenter?.onMovieDetailError(error: error)
                break
            }
        }
    }
    
    func rateMovie(id: Int, rating: Double) {
        MovieRateRequest(id: id, rating: rating).response { [weak self] (result) in
            switch result {
            case .success:
                self?.presenter?.onMovieRatingSuccess()
                break
            case .failure(let error):
                self?.presenter?.onMovieDetailError(error: error)
                break
            }
        }
    }
}
