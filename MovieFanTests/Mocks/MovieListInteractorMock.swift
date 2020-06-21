//
//  MovieListInteractorMock.swift
//  MovieFanTests
//
//  Created by Mohammed ELMeseery on 6/21/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import XCTest
@testable import MovieFan

class MovieListInteractorMock: MovieListInteractorProtocol {    
    weak var presenter: MovieListInteractorOutputProtocol?
    var client: APIHTTPClientType
    var requestCalled: Bool = false
    
    init(presenter: MovieListInteractorOutputProtocol, client: APIHTTPClientType) {
        self.presenter = presenter
        self.client = client
    }
    
    func makeMovieListRequest(page: Int) {
        let req = NowPlayingMoviesRequest(page: page)
        req.changeAPIClient(client: client)
        req.response { (result) in
            self.requestCalled = true
            switch result {
            case .success(let response):
                self.presenter?.onMoviesFetchSuccess(response: response)
                break
            case .failure(let error):
                self.presenter?.onMoviesFetchError(error: error)
                break
            }
        }
    }
    
    func toogleFavourite(movie: Movie) {}
    
    func isFavourite(movie: Movie) -> Bool { return true }
}
