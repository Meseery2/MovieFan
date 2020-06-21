//
//  MovieSearchInteractor.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import Foundation

class MovieSearchInteractor: MovieSearchInteractorProtocol {
    
    weak var presenter: MovieSearchInteractorOutputProtocol?
    private var favouritesDataManager: LocalDataManager
    
    init(manager: LocalDataManager) {
        self.favouritesDataManager = manager
    }
    
    func toogleFavourite(movie: Movie) {
        favouritesDataManager.toggleFavourite(movie: movie)
    }
}
