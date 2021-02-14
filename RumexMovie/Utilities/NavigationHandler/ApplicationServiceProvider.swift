//
//  ApplicationServiceProvider.swift
//  RumexMovie
//
//  Created by Sahan Ravindu on 2021-01-29.
//

import Foundation
import UIKit

enum Storyboard: String {
    case Auth
    case Main
}

class ApplicationServiceProvider {
    
    static let shared = ApplicationServiceProvider()
    
    let bundleId = Bundle.main.bundleIdentifier ?? ""
    let deviceId = UIDevice.current.identifierForVendor!.uuidString
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let sceneDelegate: SceneDelegate = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)!
    let deviceType = "APPLE"
    let imagePath: String = "https://image.tmdb.org/t/p/w500/"
    let apiKey: String = "21cf9e58fa9fb18d1769658101c2fa34"
    
    // Initial parameters for authenication services (Login / Register)
    var initialAuthParameters: [String: Any] = [:]
    
    private init() {}
    
    // Configure Application
    func configure() {
        manageUIAppearance(hasCustomBackButton: true, hideNavBarShadow: true, hideTabBarShadow: false)
        
    }
    
    //MARK: Setup application appearance
    private func manageUIAppearance(hasCustomBackButton: Bool = false, hideNavBarShadow: Bool = false, hideTabBarShadow: Bool = false) {
        // Set navigation bar tint / background color
        UINavigationBar.appearance().isTranslucent = false
        
        // Set navigation bar item tint color
        UIBarButtonItem.appearance().tintColor = .darkGray
        
        // Set navigation bar back button tint color
        UINavigationBar.appearance().tintColor = .darkGray
        
        // Set cutom back image if needed
        if hasCustomBackButton == true {
            // Set back button image
            let backImage = #imageLiteral(resourceName: "icons8-back")
            UINavigationBar.appearance().backIndicatorImage = backImage
            UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImage
        }
        
        // Hide navigation bar shadow if needed
        if hideNavBarShadow == true {
            // To remove the 1px seperator at the bottom of navigation bar
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
            UINavigationBar.appearance().shadowImage = UIImage()
        }
        
        // Hide tab bar shadow if needed
        if hideTabBarShadow == true {
            // To remove the 1px seperator at the bottom of tab bar
            UITabBar.appearance().backgroundImage = UIImage()
            UITabBar.appearance().shadowImage = UIImage()
        }
    }
    
    //MARK: Manage User Direction
    public func manageUserDirection(from vc: UIViewController? = nil, window: UIWindow? = nil) {
        //        guard LocalUser.current() != nil else {
        //            directToPath(in: .Auth, for: .SignUpNC, from: vc, window: window)
        //            return
        //        }
        // Set access token to SwaggerClientAPI.customHeaders and iBaseSwift AppConstant.customHeaders
        setupAccessToken()
        getRedirectionWithMainInterfaceType(type: ApplicationControl.appMainInterfaceType, window: window)
    }
    
    //MARK: Get ridirection with app main interface type
    func getRedirectionWithMainInterfaceType(type: MainInterfaceType, from vc: UIViewController? = nil, window: UIWindow? = nil) {
        switch type {
        case .Main:
            directToPath(in: .Main, for: .MainNC, from: vc, window: window)
        case .SideMenuNavigations:
            break
        case .TabBarNavigations:
            break
        case .Custom:
            break
        }
    }
    
    //MARK: Direct to Main Root window
    public func directToPath(in sb: Storyboard, for identifier: String, from vc: UIViewController? = nil, window: UIWindow? = nil) {
        let storyboard = UIStoryboard(name: sb.rawValue, bundle: nil)
        let topController = storyboard.instantiateViewController(withIdentifier: identifier)
        
        sceneDelegate.setAsRoot(_controller: topController)
    }
    
    
    //MARK: Navigation push view Controller
    public func pushToViewController(in sb: Storyboard, for identifier: String, from vc: UIViewController?, data: Any? = nil) {
        
        let storyboard = UIStoryboard(name: sb.rawValue, bundle: nil)
        let destVc = storyboard.instantiateViewController(withIdentifier: identifier)
        
        if destVc is MovieDetailVC && data != nil {
            let _vc = storyboard.instantiateViewController(withIdentifier: identifier) as! MovieDetailVC
            if let _data = data as? Movie {
                _vc.vm.movie = _data
            }
            vc?.navigationController?.pushViewController(_vc, animated: true)
            
        } else {
            
            vc?.navigationController?.pushViewController(destVc, animated: true)
            
        }
        
    }
    
    //MARK: Present view Controller
    public func presentViewController(in sb: Storyboard, for identifier: String, from vc: UIViewController?, style: UIModalPresentationStyle = .overCurrentContext, data: Any? = nil) {
        
        let storyboard = UIStoryboard(name: sb.rawValue, bundle: nil)
        let destVc = storyboard.instantiateViewController(withIdentifier: identifier)
        
        destVc.modalPresentationStyle = style
        vc?.present(destVc, animated: true, completion: nil)
    }
    
    
    //MARK: Setup access token
    func setupAccessToken() {
        guard LocalUser.current() != nil else {
            return
        }
        //SwaggerClientAPI.customHeaders.updateValue(iBSUserDefaults.getAccessToken(), forKey: "x-access-token")
    }
}
