//
//  MovieCastCell.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import UIKit

class MovieCastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var castNameLabel: UILabel!
    @IBOutlet weak var castCharacterLabel: UILabel!
    @IBOutlet weak var castImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        castNameLabel.font = UIFont.themeRegularFont(of: 14)
        castNameLabel.text = ""
        castNameLabel.textAlignment = .center

        castCharacterLabel.font = UIFont.themeRegularFont(of: 12)
        castCharacterLabel.text = ""
        castCharacterLabel.textAlignment = .center
        castCharacterLabel.textColor = UIColor.gray
        
        castImageView.contentMode = .scaleAspectFill
        castImageView.layer.masksToBounds = true
        roundImage()
        castImageView.backgroundColor = UIColor.red.withAlphaComponent(0.12)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundImage()
    }
    
    func roundImage() {
        self.layoutIfNeeded()
        castImageView.layer.cornerRadius = castImageView.bounds.size.width/2
    }
    
    override func prepareForReuse() {
        castNameLabel.text = ""
        castCharacterLabel.text = ""
        castImageView.image = nil
    }
    
    func configure(cast: MovieCast?, indexPath: IndexPath) {
        if let cast = cast {
            castNameLabel.text = cast.name
            castCharacterLabel.text = cast.character
            castImageView.load(url: cast.fullProfilePath, indexPath: indexPath)
        }
        roundImage()
    }
}


