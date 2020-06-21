//
//  DataManager.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import UIKit
import CoreData

class LocalDataManager {
    
    private let persistentContainer: NSPersistentContainer!
    
    private lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    private var allFavourites: [MovieLocalModel] = []
    
    static var shared: LocalDataManager = { return LocalDataManager() }()
    
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        configure()
    }
    
    private convenience init() {
        //Use the default container for production environment
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Can not get shared app delegate")
        }
        self.init(container: appDelegate.persistentContainer)
    }
    
    private func configure() {
        allFavourites.append(contentsOf: fetchAll())
    }
    
    @discardableResult
    func insertMovie(movie: Movie) -> MovieLocalModel? {
        guard let favouriteMovie = NSEntityDescription.insertNewObject(forEntityName: "MovieLocalModel", into: backgroundContext) as? MovieLocalModel else { return nil }
        favouriteMovie.movieName = movie.title
        favouriteMovie.moviePosterPath = movie.fullPosterPath
        favouriteMovie.movieId = Int32(movie.id)
        favouriteMovie.movieReleaseDate = movie.releaseDate
        favouriteMovie.movieRating = Int32(movie.voteCount)
        
        allFavourites.append(favouriteMovie)
        save()
        return favouriteMovie
    }
    
    func isFavourite(movie: Movie) -> MovieLocalModel? {
        return allFavourites.filter { $0.movieId == Int32(movie.id) }.first
    }
    
    func toggleFavourite(movie: Movie) {
        if let favourite = isFavourite(movie: movie) {
            remove(objectID: favourite.objectID)
        } else {
            insertMovie(movie: movie)
        }
    }
    
    public func fetchAll() -> [MovieLocalModel] {
        let request: NSFetchRequest<MovieLocalModel> = MovieLocalModel.fetchRequest()
        let results = try? persistentContainer.viewContext.fetch(request)
        return results ?? [MovieLocalModel]()
    }
    
    func remove(objectID: NSManagedObjectID ) {
        let obj = backgroundContext.object(with: objectID)
        backgroundContext.delete(obj)
        save()
    }
    
    func remove(favouriteMovie: MovieLocalModel ) {
        backgroundContext.delete(favouriteMovie)
        save()
    }
    
    func save() {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch {
                print("Save error \(error)")
            }
        }
    }    
}
