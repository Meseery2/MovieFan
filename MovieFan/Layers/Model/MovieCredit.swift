//
//  MovieCredit.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import Foundation

class MovieCredit: Decodable {
    var cast: [MovieCast] = []
    var crew: [MovieCrew] = []
}
