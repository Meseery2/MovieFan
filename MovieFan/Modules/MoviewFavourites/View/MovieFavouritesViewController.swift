//
//  MovieFavouritesViewController.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import UIKit

class FavouriteMoviesScene: BaseUIViewController {
    
    private var favouritesDataManager: LocalDataManager = LocalDataManager.shared
    private var allFavourites: [MovieLocalModel] = []
    private var lastSelectedIndexPath: IndexPath?
    private var lastSelectedMovie: Movie?
    
    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let itemWidth: CGFloat = (UIScreen.main.bounds.width - (3 * spacing)) / 2
        let itemHeight: CGFloat = itemWidth * (3/2)
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(inset: spacing)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Favourite Movies"
        allFavourites.append(contentsOf: favouritesDataManager.fetchAll())
        
        view.addSubview(collectionView)
        collectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
            ])
        
        showEmptyFavourites()
    }
    
    private func showEmptyFavourites() {
        if allFavourites.isEmpty {
            showError(type: .Custom(title: "Favourite Movies Empty", desc: "All your favourite marked movies will be shown here.", image: Image.icEmptyState.image, buttonAction: nil))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = lastSelectedIndexPath, let movie = lastSelectedMovie {
            if !movie.isFavoured {
                removeFavourite(at: indexPath)
            }
            lastSelectedIndexPath = nil
            lastSelectedMovie = nil
        }
    }
    
    private func didSelectMovie(at indexPath: IndexPath) {
        let movie = Movie(movie: allFavourites[indexPath.row])
        lastSelectedIndexPath = indexPath
        lastSelectedMovie = movie
        let viewController = AppNavigationCordinator.buildMovieDetailModule(movie: movie)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension FavouriteMoviesScene: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allFavourites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        let movie = allFavourites[indexPath.row]
        cell.configure(delegate: self, movie: movie, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectMovie(at: indexPath)
    }
}

extension FavouriteMoviesScene: MovieCollectionViewCellDelegate {
    func movieFavouriteTapped(for cell: MovieCollectionViewCell) {
        guard let indexPath = self.collectionView.indexPath(for: cell) else {
            return
        }
        removeFavourite(at: indexPath)
    }
    
    private func removeFavourite(at indexPath: IndexPath) {
        favouritesDataManager.remove(objectID: allFavourites[indexPath.row].objectID)
        allFavourites.remove(at: indexPath.row)
        collectionView.deleteItems(at: [indexPath])
        showEmptyFavourites()
    }
}
