//
//  AppCoordinator.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import UIKit

class AppNavigationCordinator {
    static func buildMovieListModule() -> UIViewController {
        let viewController = UIStoryboard(name: "MovieList", bundle: nil)
            .instantiateViewController(withIdentifier: "MovieListViewController") as! MovieListViewController
        
        let presenter: MovieListPresenterProtocol & MovieListInteractorOutputProtocol = MovieListPresenter()
        let favouritesDataManager = LocalDataManager.shared
        let interactor: MovieListInteractorProtocol = MovieListInteractor(manager: favouritesDataManager)
        let router: MovieListRouterProtocol = MovieListRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return viewController
    }
    
    static func buildMovieDetailModule(movie: Movie) -> UIViewController {
        let viewController = UIStoryboard(name: "MovieDetail", bundle: nil)
            .instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        
        let presenter: MovieDetailPresenterProtocol & MovieDetailInteractorOutputProtocol = MovieDetailPresenter(movie: movie)
        let favouritesDataManager = LocalDataManager.shared
        let interactor: MovieDetailInteractorProtocol = MovieDetailInteractor(manager: favouritesDataManager)
        let router: MovieDetailRouterProtocol = MovieDetailRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return viewController
    }
    
    static func buildMovieDetailModule(movieDetailViewModel: MovieDetailViewModel) -> UIViewController {
        let viewController = MovieCastViewController()
        viewController.movieViewModel = movieDetailViewModel
        return viewController
    }
    
    static func buildFavouriteMoviesModule() -> UIViewController {
        let viewController = FavouriteMoviesScene()
        return viewController
    }
    
    static func buildSearchMoviesModule(delegate: MovieSearchResultViewDelegate?) -> UIViewController {
        let viewController = MovieSearchResultViewController()
        
        let presenter: MovieSearchPresenterProtocol & MovieSearchInteractorOutputProtocol = MovieSearchPresenter(delegate: delegate)
        let favouritesDataManager = LocalDataManager.shared
        let interactor: MovieSearchInteractorProtocol = MovieSearchInteractor(manager: favouritesDataManager)
        let router: MovieSearchRouterProtocol = MovieSearchRouter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return viewController
    }
}
