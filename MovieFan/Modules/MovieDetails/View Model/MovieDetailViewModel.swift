//
//  MovieDetailViewModel.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import Foundation

class MovieDetailViewModel {
    
    private(set) var movieDetail: MovieDetail
    private(set) var isFavourite: Bool = false
    
    init(movieDetail: MovieDetail, isFavourite: Bool) {
        self.movieDetail = movieDetail
        self.isFavourite = isFavourite
    }
    
    func toggleFavourite() {
        isFavourite = !isFavourite
    }
    
    var castCount: Int {
        return self.movieDetail.credits?.cast.count ?? 0
    }
    
    var crewCount: Int {
        return self.movieDetail.credits?.crew.count ?? 0
    }
    
    func cast(at indexPath: IndexPath) -> MovieCast? {
        return self.movieDetail.credits?.cast[indexPath.row]
    }
    
    func crew(at indexPath: IndexPath) -> MovieCrew? {
        return self.movieDetail.credits?.crew[indexPath.row]
    }
    
    var movieGenre: String {
        return movieDetail.genres.map { $0.name }.joined(separator: ", ")
    }
    
    var ratingText: String {
        return "\(movieDetail.voteAverage) (\(movieDetail.voteCount) Reviews)"
    }
    
    var releaseText: String {
        return "\(movieDetail.releaseDate.formatDateMediumStyle(dateFormat: "yyyy-MM-dd")) \(movieDetail.status)"
    }
}
