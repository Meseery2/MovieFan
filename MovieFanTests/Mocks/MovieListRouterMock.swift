//
//  MovieListRouterMock.swift
//  MovieFanTests
//
//  Created by Mohammed ELMeseery on 6/21/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import XCTest
@testable import MovieFan

class MovieListRouterMock: MovieListRouterProtocol {
    var movieDetailSuccess: Bool = false
    
    func pushMovieDetailScene(view: MovieListViewProtocol, movie: Movie) {
        movieDetailSuccess = true
    }
    
    func pushFavouriteMoviesScene(view: MovieListViewProtocol) {}
}
