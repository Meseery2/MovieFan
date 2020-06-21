//
//  APIEndpoint.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import Foundation

enum MovieRoute {
    case nowPlayingMovies
    case movieDetail(id: Int)
    case rateMovie(id: Int)
}

extension MovieRoute {
    
    private var baseUrl: String { APIConstants.APIBaseURL }
    
    private var apiEndPoint: String { "\(baseUrl)/\(urlPath)?api_key=\(APIConstants.APIKey)" }
    
    var url: URL { URL(string: apiEndPoint)! }
    
    var asRoute: Route {
        switch self {
        case .rateMovie:
            return Route.postRoute(path: self.apiEndPoint)
        default:
            return Route.getRoute(path: self.apiEndPoint)
        }
    }
    
    private var urlPath: String {
        switch self {
        case .nowPlayingMovies:
            return "movie/now_playing"
        case .movieDetail(let id):
            return "movie/\(id)"
        case .rateMovie(let id):
            return "movie/\(id)/rating"
        }
    }
}
