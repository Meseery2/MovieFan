//
//  MovieDetailRouter.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import UIKit

class MovieDetailRouter: MovieDetailRouterProtocol {
    func pushMovieCastScene(view: MovieDetailViewProtocol, model: MovieDetailViewModel) {
        if let superViewController = view as? UIViewController {
            let viewController = AppNavigationCordinator.buildMovieDetailModule(movieDetailViewModel: model)
            superViewController.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
