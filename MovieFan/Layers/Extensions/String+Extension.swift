//
//  String+Extension.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/21/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import Foundation

extension String {
    func formatDateMediumStyle(dateFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        
        let date = formatter.date(from: self)
        
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        let dateString = formatter.string(from: date!)
        
        return dateString
    }
}
