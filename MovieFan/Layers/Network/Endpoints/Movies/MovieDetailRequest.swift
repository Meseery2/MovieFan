//
//  MovieDetailRequest.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import Foundation

class MovieDetailRequest: APIRequest<MovieDetail> {
    init(id: Int) {
        super.init(route: MovieRoute.movieDetail(id: id).asRoute)
    }
    
    override func getParameters() -> [String : Any] {
        return [ "append_to_response": "credits"]
    }
}
