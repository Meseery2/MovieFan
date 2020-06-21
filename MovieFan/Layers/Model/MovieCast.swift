//
//  MovieCast.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import Foundation

class MovieCast: Decodable {
    var castId: Int = 0
    var character: String = ""
    var creditId: String = ""
    var gender: Int = 1
    var id: Int = -1
    var name: String = ""
    var order: Int = 1
    var profilePath: String = ""
    
    enum CodingKeys: String, CodingKey {
        case castId = "cast_id"
        case character
        case creditId = "credit_id"
        case gender
        case id
        case name
        case order
        case profilePath = "profile_path"
    }
    
    var fullProfilePath: String {
        return "\(APIConstants.APIBaseImagePath)\(self.profilePath)"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        castId = try values.decode(Int.self, forKey: .castId)
        character = try values.decode(String.self, forKey: .character)
        creditId = try values.decode(String.self, forKey: .creditId)
        gender = try values.decodeIfPresent(Int.self, forKey: .gender) ?? 0
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        order = try values.decode(Int.self, forKey: .order)
        profilePath = try values.decodeIfPresent(String.self, forKey: .profilePath) ?? ""
    }
}
