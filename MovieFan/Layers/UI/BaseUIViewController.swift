//
//  BaseUIViewController.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import UIKit

class BaseUIViewController: UIViewController {
    
    private var emptyStateView: EmptyStateView = EmptyStateView()
    private var activityIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUITheme()
        setUI()
    }
    
    internal func setUI() {}
    
    internal func setUITheme() {}
    
    func showLoadingView(msg: String) {
        if #available(iOS 13.0, *) {
            activityIndicator = UIActivityIndicatorView(style: .large)
        } else {
            activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        }
        activityIndicator?.color = UIColor.red
        activityIndicator?.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator?.hidesWhenStopped = true
        activityIndicator?.startAnimating()
        self.view.addSubview(activityIndicator!)
        self.view.bringSubviewToFront(activityIndicator!)
        
        activityIndicator?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        activityIndicator?.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    func hideLoadingView() {
        activityIndicator?.removeFromSuperview()
    }
    
    func showError(type: EmptyErrorType, delegate: EmptyStateViewDelegate? = nil) {
        emptyStateView
            .delegate(with: delegate)
            .action(button: type.actionButton)
            .with(title: type.title, subTitle: type.desc, image: type.image)
            .show(superview: self.view)
    }
    
    func hideError() {
        if emptyStateView.superview != nil {
            emptyStateView.removeFromSuperview()
        }
    }
}
