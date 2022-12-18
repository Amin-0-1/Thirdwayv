//
//  UIViewController.swift
//  Thirdwayv
//
//  Created by Amin on 16/12/2022.
//

import UIKit
extension UIViewController {
    
    static let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func startLoading() {
        let activityIndicator = UIViewController.activityIndicator
        activityIndicator.style = .large
        activityIndicator.color = .label
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        DispatchQueue.main.async {
            self.view.addSubview(activityIndicator)
        }
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    func stopLoading() {
        let activityIndicator = UIViewController.activityIndicator
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
        view.isUserInteractionEnabled = true
    }
}
