//
//  MovieRequest.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import Foundation

class NowPlayingMoviesRequest: APIRequest<MovieListResponse> {
    
    private var page: Int = 1
    
    init(page: Int) {
        super.init(route: MovieRoute.nowPlayingMovies.asRoute)
        self.page = page
    }
    
    override func getParameters() -> [String : Any] { return [ "page": self.page ] }
}
