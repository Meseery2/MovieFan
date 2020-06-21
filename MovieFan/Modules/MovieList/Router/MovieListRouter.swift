//
//  MovieListRouter.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import UIKit

class MovieListRouter: MovieListRouterProtocol {
    
    func pushMovieDetailScene(view: MovieListViewProtocol, movie: Movie) {
        if let superViewController = view as? UIViewController {
            let viewController = AppNavigationCordinator.buildMovieDetailModule(movie: movie)
            superViewController.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func pushFavouriteMoviesScene(view: MovieListViewProtocol) {
        if let superViewController = view as? UIViewController {
            let viewController = AppNavigationCordinator.buildFavouriteMoviesModule()
            superViewController.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
