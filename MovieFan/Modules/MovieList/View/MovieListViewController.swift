//
//  MovieListViewController.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import UIKit

class MovieListViewController: BaseUIViewController {
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    private let spacing: CGFloat = 16
    private let numberOfColumns: CGFloat = 2
    private var flowLayout: UICollectionViewFlowLayout!
    private var showCollectionViewLoadingFooter: Bool = false
    
    var presenter: MovieListPresenterProtocol?
    private var movieViewModel: MovieListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Now Playing Movies"
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    internal override func setUI() {
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        let activityIndicator = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
            activityIndicator.style = .whiteLarge
        }
        activityIndicator.tintColor = UIColor.red
        activityIndicator.startAnimating()
        
        moviesCollectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        moviesCollectionView.register(MovieLoadingFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "MovieLoadingFooter")
        
        flowLayout = self.moviesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout ?? UICollectionViewFlowLayout()
        
        flowLayout.sectionHeadersPinToVisibleBounds = true
        flowLayout.minimumLineSpacing = spacing
        flowLayout.sectionInset = UIEdgeInsets(inset: spacing)
        flowLayout.minimumInteritemSpacing = spacing
        
        let itemWidth: CGFloat = (UIScreen.main.bounds.width - ((numberOfColumns + 1) * spacing))/numberOfColumns
        let itemHeight: CGFloat = itemWidth * (3/2)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        let favouriteNavigationButton = UIBarButtonItem(image: UIImage(named: "ic_fav_normal"), style: .plain, target: self, action: #selector(favouriteNavigationButtonTapped))
        
        navigationItem.rightBarButtonItem = favouriteNavigationButton
        
        // Set SearchController
        let searchViewController = AppNavigationCordinator.buildSearchMoviesModule(delegate: self)
        let searchController = UISearchController(searchResultsController: searchViewController)
        if #available(iOS 11, *) {
            searchController.obscuresBackgroundDuringPresentation = true
        } else {
            searchController.dimsBackgroundDuringPresentation = true
        }
        definesPresentationContext = true
        searchController.searchResultsUpdater = nil
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = searchViewController as? UISearchBarDelegate
        searchController.delegate = self
        searchController.hidesNavigationBarDuringPresentation = true

        if #available(iOS 11, *) {
            navigationItem.searchController = searchController
            //navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            navigationItem.titleView = searchController.view
        }
        definesPresentationContext = true
    }
    
    @objc private func favouriteNavigationButtonTapped() {
        presenter?.selectedFavouriteMovies()
    }
}

extension MovieListViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        guard let viewController = searchController.searchResultsController as? MovieSearchResultViewController, let _model = movieViewModel, let presenter = viewController.presenter else {
            return
        }
        presenter.setFilterMovies(movies: _model.data)
    }
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = self.movieViewModel else {
            return 0
        }
        return viewModel.moviesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        guard let viewModel = self.movieViewModel else {
            return cell
        }
        let movie = viewModel.movie(at: indexPath)
        cell.configure(delegate: self, movie: movie, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if showCollectionViewLoadingFooter {
            return CGSize(width: UIScreen.main.bounds.width, height: 60)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if showCollectionViewLoadingFooter {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "MovieLoadingFooter", for: indexPath) as! MovieLoadingFooterView
            return cell
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter?.willDisplayCell(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectMovie(at: indexPath)
    }
}

extension MovieListViewController: MovieListViewProtocol {
    func showErrorView(type: EmptyErrorType) {
        self.showError(type: type, delegate: self)
    }
    
    func showLoading(message: String) {
        if movieViewModel == nil {
            showCollectionViewLoadingFooter = false
            showLoadingView(msg: message)
        } else {
            showCollectionViewLoadingFooter = true
        }
    }
    
    func hideLoading() {
        if showCollectionViewLoadingFooter {
            showCollectionViewLoadingFooter = false
        } else {
            hideLoadingView()
        }
    }
   
    func showMovieList(viewModel: MovieListViewModel) {
        self.movieViewModel = viewModel
        moviesCollectionView.reloadSections(IndexSet(integer: 0))
    }
    
    func addMoreMovies(at indexPaths: [IndexPath]) {
        moviesCollectionView.performBatchUpdates({
            self.moviesCollectionView.insertItems(at: indexPaths)
        }, completion: nil)
    }
    
    func reloadMovieList(at indexPaths: [IndexPath]) {
        if indexPaths.isEmpty {
            let index = moviesCollectionView.indexPathsForVisibleItems
            moviesCollectionView.reloadItems(at: index)
        } else {
            moviesCollectionView.reloadItems(at: indexPaths)
        }
    }
}

extension MovieListViewController: EmptyStateViewDelegate {
    func retryButtonTapped() {
        presenter?.retryLoadingMovies()
    }
}

extension MovieListViewController: MovieCollectionViewCellDelegate {
    func movieFavouriteTapped(for cell: MovieCollectionViewCell) {
        guard let indexPath = self.moviesCollectionView.indexPath(for: cell) else {
            return
        }
        presenter?.selectedFavourite(at: indexPath)
    }
}

extension MovieListViewController: MovieSearchResultViewDelegate {
    func movieSeachView(tappedMovie index: IndexPath) {
        presenter?.didSelectMovie(at: index)
    }
}
