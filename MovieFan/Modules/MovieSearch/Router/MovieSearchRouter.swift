//
//  MovieSearchRouter.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import UIKit

class MovieSearchRouter: MovieSearchRouterProtocol {
    func dismiss(view: MovieSearchViewProtocol) {
        if let viewController = view as? UIViewController {
            viewController.dismiss(animated: true, completion: nil)
        }
    }
}
