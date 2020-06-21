//
//  MovieListInteractor.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import Foundation

class MovieListInteractor: MovieListInteractorProtocol {
    
    weak var presenter: MovieListInteractorOutputProtocol?
    private var favouriteDataManager: LocalDataManager
    
    init(manager: LocalDataManager) {
        self.favouriteDataManager = manager
    }
    
    func makeMovieListRequest(page: Int) {
        NowPlayingMoviesRequest(page: page).response { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.presenter?.onMoviesFetchSuccess(response: response)
                break
            case .failure(let error):
                self?.presenter?.onMoviesFetchError(error: error)
                break
            }
        }
    }
    
    func toogleFavourite(movie: Movie) {
        favouriteDataManager.toggleFavourite(movie: movie)
    }
    
    func isFavourite(movie: Movie) -> Bool {
        if favouriteDataManager.isFavourite(movie: movie) != nil {
            return true
        }
        return false
    }
}
