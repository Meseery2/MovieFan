//
//  MovieSearchResultViewController.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import UIKit

protocol MovieSearchResultViewDelegate: class {
    func movieSeachView(tappedMovie index: IndexPath)
}

class MovieSearchResultViewController: BaseUIViewController, UISearchBarDelegate {

    private var moviesResult: [Movie] = []
    private var searchBar: UISearchBar?
    var presenter: MovieSearchPresenterProtocol?
    
    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 16
        let itemWidth: CGFloat = (UIScreen.main.bounds.width - (3 * spacing)) / 2
        let itemHeight: CGFloat = itemWidth * (3/2)
        layout.sectionHeadersPinToVisibleBounds = true
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
        
        view.addSubview(collectionView)
        collectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCollectionViewCell")
        collectionView.backgroundColor = UIColor.white
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
            ])
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchBar = searchBar
        presenter?.searchMovie(searchText: searchText)
    }
}

extension MovieSearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        let movie = moviesResult[indexPath.row]
        cell.configure(delegate: self, movie: movie, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let _searchBar = searchBar {
            _searchBar.text = ""
            _searchBar.resignFirstResponder()
        }
        presenter?.didSelectMovie(indexPath: indexPath)
    }
}

extension MovieSearchResultViewController: MovieCollectionViewCellDelegate {
    func movieFavouriteTapped(for cell: MovieCollectionViewCell) {
        guard let indexPath = self.collectionView.indexPath(for: cell) else {
            return
        }
        presenter?.selectedFavourite(at: indexPath)
    }
}

extension MovieSearchResultViewController: MovieSearchViewProtocol {
    func showSearchResult(movies: [Movie]) {
        moviesResult.removeAll()
        moviesResult.append(contentsOf: movies)
        collectionView.reloadData()
    }
    
    func showErrorView(type: EmptyErrorType) {
        showError(type: type)
    }
}
