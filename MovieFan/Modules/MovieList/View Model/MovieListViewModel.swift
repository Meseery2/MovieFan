//
//  MovieListViewModel.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import Foundation

class MovieListViewModel: PaginationViewModel<Movie> {
    override init(pageSize: Int = 20) {
        super.init(pageSize: pageSize)
    }
    
    public func movie(at indexPath: IndexPath) -> Movie {
        return data[indexPath.row]
    }
    
    var moviesCount: Int {
        return data.count
    }
}
