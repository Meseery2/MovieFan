//
//  MovieDetail.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import Foundation

class MovieDetail: Decodable {
    var adult: Bool = false
    var backdropPath: String = ""
    var budget: Int = 0
    var genres: [MovieGenre] = []
    var homepage: String = ""
    var id: Int = 0
    var imdbId: String = ""
    var originalLanguage: String = ""
    var originalTitle: String = ""
    var overview: String = ""
    var popularity: Float = 0.0
    var posterPath: String = ""
    var releaseDate: String = ""
    var revenue: Int = 0
    var runtime: Int = -1
    var status: String = ""
    var tagline: String = ""
    var title: String = ""
    var video: Bool = false
    var voteAverage: Float = 0.0
    var voteCount: Int = 0
    var credits: MovieCredit?

    var fullPosterPath: String {
        return "\(APIConstants.APIBaseImagePath)\(self.posterPath)"
    }

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget
        case genres
        case homepage
        case id
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case credits
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult = try values.decode(Bool.self, forKey: .adult)
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath) ?? ""
        budget = try values.decode(Int.self, forKey: .budget)
        genres = try values.decode([MovieGenre].self, forKey: .genres)
        homepage = try values.decodeIfPresent(String.self, forKey: .homepage) ?? ""
        id = try values.decode(Int.self, forKey: .id)
        imdbId = try values.decodeIfPresent(String.self, forKey: .imdbId) ?? ""
        originalLanguage = try values.decode(String.self, forKey: .originalLanguage)
        originalTitle = try values.decode(String.self, forKey: .originalTitle)
        overview = try values.decodeIfPresent(String.self, forKey: .overview) ?? ""
        popularity = try values.decode(Float.self, forKey: .popularity)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
        releaseDate = try values.decode(String.self, forKey: .releaseDate)
        revenue = try values.decode(Int.self, forKey: .revenue)
        runtime = try values.decodeIfPresent(Int.self, forKey: .runtime) ?? -1
        status = try values.decode(String.self, forKey: .status)
        tagline = try values.decodeIfPresent(String.self, forKey: .tagline) ?? ""
        title = try values.decode(String.self, forKey: .title)
        video = try values.decode(Bool.self, forKey: .video)
        voteAverage = try values.decode(Float.self, forKey: .voteAverage)
        voteCount = try values.decode(Int.self, forKey: .voteCount)
        credits = try values.decode(MovieCredit.self, forKey: .credits)
    }
}
