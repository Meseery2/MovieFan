//
//  UIViewController+Extension.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentOkAlert(title: String = "", message: String) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        presentAlert(title: title, message: message, preferredStyle: .alert, actionButtons: [okAction], dismissOnTap: false)
    }
    
    func presentAlert(title: String? = "", message: String?, preferredStyle: UIAlertController.Style = .alert, actionButtons: [UIAlertAction], dismissOnTap: Bool = false) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        for button in actionButtons {
            alert.addAction(button)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}
