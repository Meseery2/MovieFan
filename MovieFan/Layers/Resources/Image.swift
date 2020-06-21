//
//  Image.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import UIKit

enum Image: String {
    case icEmptyState = "ic_empty_state"
    
    var image: UIImage? {
        return UIImage(named: self.rawValue)
    }
}
