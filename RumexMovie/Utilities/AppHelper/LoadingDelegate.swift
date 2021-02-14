//
//  LoadingDelegate.swift
//  Created by Sahan Ravindu on 2021-01-29.
//

import Foundation
import UIKit
import RappleProgressHUD

protocol LoadingIndicatorDelegate {
    func startLoading(isLoadMore: Bool)
    func startLoadingWithText(label: String)
    func stopLoading(isLoadMore: Bool)
    func startLoadingWithProgress(current: CGFloat, total:CGFloat)
}

extension LoadingIndicatorDelegate {
    // -------- RappleProgressHUD -------- //
    // Start loading
    func startLoading(isLoadMore: Bool = false) {
        if !isLoadMore {
        RappleActivityIndicatorView.startAnimating()
        }
    }
    
    // Start loading with text
    func startLoadingWithText(label: String) {
        RappleActivityIndicatorView.startAnimatingWithLabel(label)
    }
    
    // Stop loading
    func stopLoading(isLoadMore: Bool = false) {
        RappleActivityIndicatorView.stopAnimation()
    }
    
    func startLoadingWithProgress(current: CGFloat, total:CGFloat) {
        RappleActivityIndicatorView.setProgress(current/total)
    }
}

