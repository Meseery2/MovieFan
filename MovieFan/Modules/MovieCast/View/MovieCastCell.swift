//
//  MovieCastCell.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import UIKit

class MovieCastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieCastImage: UIImageView!
    @IBOutlet weak var movieCastlabelName: UILabel!
    @IBOutlet weak var movieCastlabelCharacter: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        movieCastlabelName.font = UIFont.themeMediumFont(of: 18)
        movieCastlabelCharacter.font = UIFont.themeRegularFont(of: 16)
        
        movieCastlabelName.textColor = UIColor.black
        movieCastlabelCharacter.textColor = UIColor.gray
        
        movieCastlabelName.text = ""
        movieCastlabelCharacter.text = ""
        
        movieCastImage.image = nil
        movieCastImage.contentMode = .scaleAspectFill
        
        movieCastImage.layer.cornerRadius = movieCastImage.bounds.width/2
        movieCastImage.layer.masksToBounds = true
        movieCastImage.backgroundColor = UIColor.red.withAlphaComponent(0.12)
        
        self.selectionStyle = .none
    }
    
    override func prepareForReuse() {
        movieCastlabelName.text = ""
        movieCastlabelCharacter.text = ""
        
        movieCastImage.image = nil
    }
    
    func configure(cast: MovieCast?, indexPath: IndexPath) {
        if let cast = cast {
            movieCastlabelName.text = cast.name
            movieCastlabelCharacter.text = cast.character
            movieCastImage.load(url: cast.fullProfilePath, indexPath: indexPath)
        }
    }
    
    func configure(crew: MovieCrew?, indexPath: IndexPath) {
        if let crew = crew {
            movieCastlabelName.text = crew.name
            movieCastlabelCharacter.text = "\(crew.job) - \(crew.department)"
            movieCastImage.load(url: crew.fullProfilePath, indexPath: indexPath)
        }
    }
}
