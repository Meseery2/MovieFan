//
//  MovieLocalModel.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import Foundation
import CoreData

@objc(MovieLocalModel)
public class MovieLocalModel: NSManagedObject {

}

extension MovieLocalModel {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieLocalModel> {
        return NSFetchRequest<MovieLocalModel>(entityName: "MovieLocalModel")
    }
    @NSManaged public var movieId: Int32
    @NSManaged public var moviePosterPath: String
    @NSManaged public var movieName: String
    @NSManaged public var movieReleaseDate: String
    @NSManaged public var movieRating: Int32
}
