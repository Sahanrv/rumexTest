//
//  Constants.swift
//  RumexMovie
//
//  Created by Sahan Ravindu on 2021-01-29.
//
//

import Foundation

// Action Handler
typealias ActionHandler = (_ status: Bool, _ message: String) -> ()

// Completion Handler
typealias CompletionHandler = (_ status: Bool, _ message: String, _ data: Any?) -> ()

enum AppEnvironment {
    case sandbox
    case staging
    case production
}

struct K {
    
    struct AppServer {
        static var baseURL: String {
            get {
                return "https://api.themoviedb.org/3"
            }
        }
    }
    
    static let imagePath = "https://image.tmdb.org/t/p/w500/"
    
    struct APIParameterKey {
        
        //Sign Up //Log In
        static let image = "image"
        static let username = "username"
        static let password = "password"
        static let email = "email"
        static let gender = "gender"
        static let deviceType = "deviceType"
        
        //Movies
        static let key = "api_key"
        static let page = "page"
    }
}

enum HTTPHeaderField: String {
    case authorization = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
