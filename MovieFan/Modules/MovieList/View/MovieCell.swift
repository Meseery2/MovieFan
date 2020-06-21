//
//  MovieCell.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieFavouriteButton: UIButton!
    @IBOutlet weak var layerView: UIView!
    
    private var delegate: MovieCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.cornerRadius = 8
        self.contentView.layer.masksToBounds = true
        
        movieTitleLabel.numberOfLines = 0
        movieTitleLabel.font = UIFont.themeBoldFont(of: 18)
        movieTitleLabel.textColor = UIColor.white
        
        movieReleaseDateLabel.numberOfLines = 0
        movieReleaseDateLabel.font = UIFont.themeMediumFont(of: 16)
        movieReleaseDateLabel.textColor = UIColor.lightText
        
        movieRatingLabel.numberOfLines = 0
        movieRatingLabel.font = UIFont.themeLightFont(of: 13)
        movieRatingLabel.textColor = UIColor.systemYellow
    
        moviePosterImage.image = nil
        self.contentView.backgroundColor = UIColor.lightText
        
        layerView.backgroundColor = UIColor.purple.withAlphaComponent(0.40)
        
        movieFavouriteButton.addTarget(self, action: #selector(buttonFavouriteTapped), for: .touchUpInside)
    }
    
    override func prepareForReuse() {
        movieTitleLabel.text = nil
        moviePosterImage.image = nil
        movieReleaseDateLabel.text = nil
        movieRatingLabel.text = nil
    }
    
    public func configure(delegate: MovieCollectionViewCellDelegate, movie: Movie, indexPath: IndexPath) {
        self.delegate = delegate
        movieTitleLabel.text = movie.title
        movieReleaseDateLabel.text = movie.releaseDate
        movieRatingLabel.text = "\(movie.voteAverage) ⭐️"
        moviePosterImage.load(url: movie.fullPosterPath, indexPath: indexPath)
        movieFavouriteButton.isSelected = movie.isFavoured
    }
    
    public func configure(delegate: MovieCollectionViewCellDelegate, movie: MovieLocalModel, indexPath: IndexPath) {
        self.delegate = delegate
        movieTitleLabel.text = movie.movieName
        movieReleaseDateLabel.text = movie.movieReleaseDate
        movieRatingLabel.text = "\(movie.movieRating) ⭐️"
        moviePosterImage.load(url: movie.moviePosterPath, indexPath: indexPath)
        movieFavouriteButton.isSelected = true
    }
    
    @objc private func buttonFavouriteTapped() {
        movieFavouriteButton.isSelected = !movieFavouriteButton.isSelected
        delegate?.movieFavouriteTapped(for: self)
    }
}
