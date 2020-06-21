//
//  MovieRateRequest.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/22/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import Foundation

// TODO: Check Authentication privilege from TMDB API "Authentication failed: You do not have permissions to access the service."
class MovieRateRequest: APIRequest<MovieDetail> {
    
    var rating: Double = 0.5
    
    init(id: Int, rating: Double) {
        self.rating = rating
        super.init(route: MovieRoute.rateMovie(id: id).asRoute)
    }
    
    override func getParameters() -> [String : Any] {
        return [ "value": rating]
    }
}
