//
//  MovieDetailViewController.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import UIKit

class MovieDetailViewController: BaseUIViewController {
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    @IBOutlet weak var movieRatingButton: UIButton!
    @IBOutlet weak var movieDurationButton: UIButton!
    @IBOutlet weak var movieOverviewTitleLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var movieOverviewMoreButton: UIButton!
    @IBOutlet weak var movieCastTitleLabel: UILabel!
    @IBOutlet weak var movieCastViewAllButton: UIButton!
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var ratingView: RatingView!

    
    var presenter: MovieDetailPresenterProtocol?
    var movieViewModel: MovieDetailViewModel?
    private var flowLayout: UICollectionViewFlowLayout!
    private var overviewExpanded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewWillAppear()
    }
    
    override func setUI() {
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        
        castCollectionView.register(UINib(nibName: "MovieCastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCastCollectionViewCell")
        
        movieTitleLabel.numberOfLines = 2
        movieGenreLabel.numberOfLines = 0
        
        movieCastViewAllButton.setTitle("View All", for: .normal)
        movieOverviewMoreButton.setTitle("More", for: .normal)
        movieCastTitleLabel.text = "Cast"
        movieOverviewTitleLabel.text = "Overview"
        
        flowLayout = self.castCollectionView.collectionViewLayout as? UICollectionViewFlowLayout ?? UICollectionViewFlowLayout()
        
        flowLayout.sectionHeadersPinToVisibleBounds = true
        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(inset: 0)
        flowLayout.minimumInteritemSpacing = 0
        
        let itemSize: CGFloat = (UIScreen.main.bounds.width - 40)/4
        flowLayout.itemSize = CGSize(width: itemSize, height: itemSize)


        movieCastViewAllButton.addTarget(self, action: #selector(castViewAllButtonTapped), for: .touchUpInside)
        movieOverviewMoreButton.addTarget(self, action: #selector(overviewMoreButtonTapped), for: .touchUpInside)
        favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped(sender:)), for: .touchUpInside)
        
        ratingView.delegate = self
    }
    
    @objc private func favouriteButtonTapped(sender: UIButton) {
        favouriteButton.isSelected = !favouriteButton.isSelected
        presenter?.selectFavourite()
    }
    
    override func setUITheme() {
        movieTitleLabel.font = UIFont.themeBoldFont(of: 24)
        movieOverviewTitleLabel.font = UIFont.themeMediumFont(of: 20)
        movieOverviewLabel.font = UIFont.themeRegularFont(of: 16)
        movieCastTitleLabel.font = UIFont.themeMediumFont(of: 20)
        
        movieOverviewMoreButton.titleLabel?.font = UIFont.themeRegularFont(of: 14)
        movieCastViewAllButton.titleLabel?.font = UIFont.themeRegularFont(of: 14)
        
        movieRatingButton.titleLabel?.font = UIFont.themeRegularFont(of: 15)
        movieDurationButton.titleLabel?.font = UIFont.themeRegularFont(of: 15)
        
        movieOverviewMoreButton.setTitleColor(UIColor.purple, for: .normal)
        movieCastViewAllButton.setTitleColor(UIColor.purple, for: .normal)
        
        moviePosterImageView.backgroundColor = UIColor.purple.withAlphaComponent(0.12)
        
        movieRatingButton.setTitleColor(UIColor.darkText, for: .normal)
        movieDurationButton.setTitleColor(UIColor.darkGray, for: .normal)
        movieRatingButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        movieRatingButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
        movieDurationButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        movieDurationButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 5)
        
        movieReleaseDateLabel.font = UIFont.themeRegularFont(of: 16)
        movieGenreLabel.font = UIFont.themeRegularFont(of: 16)
        
        movieOverviewLabel.textColor = UIColor.darkText
        movieOverviewTitleLabel.textColor = UIColor.black
        
        movieCastTitleLabel.textColor = UIColor.black
        
        movieReleaseDateLabel.textColor = UIColor.darkText
        movieGenreLabel.textColor = UIColor.darkText

        moviePosterImageView.layer.cornerRadius = 8
        moviePosterImageView.layer.masksToBounds = true
    }
    
    @objc private func castViewAllButtonTapped() {
        presenter?.viewAllCast()
    }
    
    @objc private func overviewMoreButtonTapped() {
        overviewExpanded = !overviewExpanded
        movieOverviewLabel.numberOfLines = overviewExpanded ? 0 : 3
        movieOverviewMoreButton.setTitle(overviewExpanded ? "Less" : "More", for: .normal)
    }
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewmodel = movieViewModel else {
            return 0
        }
        let count = viewmodel.castCount
        return count > 4 ? 4 : count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCastCollectionViewCell", for: indexPath) as! MovieCastCollectionViewCell
        cell.configure(cast: movieViewModel?.cast(at: indexPath), indexPath: indexPath)
        return cell
    }
}

extension MovieDetailViewController: MovieDetailViewProtocol {
    
    func showMovieDetail(viewModel: MovieDetailViewModel) {
        self.movieViewModel = viewModel
        movieOverviewLabel.text = viewModel.movieDetail.overview
        movieTitleLabel.text = viewModel.movieDetail.title
        moviePosterImageView.load(url: viewModel.movieDetail.fullPosterPath)
        
        movieGenreLabel.text = viewModel.movieGenre
        movieReleaseDateLabel.text = viewModel.releaseText
        
        movieRatingButton.setTitle(viewModel.ratingText, for: .normal)
        movieDurationButton.setTitle("\(viewModel.movieDetail.runtime) mins", for: .normal)
        
        favouriteButton.isSelected = viewModel.isFavourite
        
        castCollectionView.reloadData()
    }
    
    func showErrorView(type: EmptyErrorType) {
        self.showError(type: type, delegate: self)
    }
}

extension MovieDetailViewController: EmptyStateViewDelegate {
    func retryButtonTapped() {
        hideError()
        presenter?.viewDidLoad()
    }
}

extension MovieDetailViewController: RatingViewDelegate {
    func ratingView(_ ratingView: RatingView, didUpdate rating: Double) {
        presenter?.rateMovie(rating: rating)
    }
}
