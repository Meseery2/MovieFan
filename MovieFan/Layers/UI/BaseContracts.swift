//
//  BaseContracts.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import UIKit
protocol BaseView: class {
    func showErrorView(type: EmptyErrorType)
    func hideErrorView()
    func showErrorAlert(type: EmptyErrorType)
    func showErrorAlert(msg: String)
    
    func showLoading(message: String)
    func hideLoading()
    
    func showAlertSheet(title: String?, msg: String?, actions: [UIAlertAction])
    func showAlert(title: String?, msg: String?, actions: [UIAlertAction])
}

extension BaseView where Self: BaseUIViewController {
    
    func hideErrorView() {
        self.hideError()
    }
    
    func showErrorAlert(msg: String) {
        self.presentOkAlert(message: msg)
    }
    
    func showErrorAlert(type: EmptyErrorType) {
        self.presentOkAlert(title: type.title ?? "", message: type.desc ?? "")
    }
    
    func showLoading(message: String) {
        self.showLoadingView(msg: message)
    }
    
    func hideLoading() {
        self.hideLoadingView()
    }
    
    func showAlertSheet(title: String?, msg: String?, actions: [UIAlertAction]) {
        self.presentAlert(title: title, message: msg, preferredStyle: .actionSheet, actionButtons: actions, dismissOnTap: false)
    }
    
    func showAlert(title: String?, msg: String?, actions: [UIAlertAction]) {
        self.presentAlert(title: title, message: msg, preferredStyle: .alert, actionButtons: actions, dismissOnTap: false)
    }
}

@objc protocol BasePresenter: class {
    func viewDidLoad()
    func viewWillAppear()
    @objc optional func viewWillDisapper()
}
