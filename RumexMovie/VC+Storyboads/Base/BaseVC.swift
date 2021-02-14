//
//  BaseVCViewController.swift
//  RumexMovie
//
//  Created by Sahan Ravindu on 2021-02-14.
//

import UIKit
import RxCocoa
import RxSwift
import PullToRefreshKit

class BaseVC: UIViewController, UIScrollViewDelegate, UITextFieldDelegate, UITextViewDelegate, LoadingIndicatorDelegate  {
    
    var refresher:UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // Hide the keyboard when tap background
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Back navigation
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    // Dismiss Top VC
    func dismissTop() {
        dismiss(animated: true, completion: nil)
    }
    
    //Navigation Bar transparent
    func navigationBarTransparent(_ transparent: Answer = .no) {
        if transparent == .yes {
            // Make the navigation bar background clear
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.isTranslucent = true
            
        } else {
            // Restore the navigation bar to default
            navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            navigationController?.navigationBar.shadowImage = nil
        }
    }
    
    //Navigation Bar hide
    func hideNavigationBar(_ transparent: Answer = .no) {
        if transparent == .yes {
            navigationController?.setNavigationBarHidden(true, animated: true)
            
        } else {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }

}

extension BaseVC {
    func configureLoadMoreFooter() -> DefaultRefreshFooter {
           let footer = DefaultRefreshFooter.footer()
           footer.setText("", mode: .pullToRefresh)
           footer.setText("", mode: .noMoreData)
           footer.setText("Load more...", mode: .refreshing)
           footer.setText("Tap to load more", mode: .tapToRefresh)
           footer.tintColor = UIColor.blue
           footer.textLabel.textColor  = .gray
           footer.refreshMode = .scroll
           
           return footer
    }
    
    func configurePulltoRefresh() -> DefaultRefreshHeader {
        let header = DefaultRefreshHeader.header()
        header.setText("Pull to refresh", mode: .pullToRefresh)
        header.setText("Release to refresh", mode: .releaseToRefresh)
        header.setText("Success", mode: .refreshSuccess)
        header.setText("Refreshing...", mode: .refreshing)
        header.setText("Failed", mode: .refreshFailure)
        header.tintColor = UIColor.orange
        header.imageRenderingWithTintColor = true
        header.durationWhenHide = 0.4
        
        return header
    }
}

enum Answer {
    case yes
    case no
}
