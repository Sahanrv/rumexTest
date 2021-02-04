//
//  Constants.swift
//  Template
//
//  Created by Dushan Saputhanthri on 26/6/18.
//  Copyright © 2018 Elegant Media Pvt Ltd. All rights reserved.
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
                return "https://oxygen.sandbox15.preview.cx/api/v1"
            }
        }
    }
    
    struct APIParameterKey {
        
        //Sign Up //Log In
        static let image = "image"
        static let username = "username"
        static let password = "password"
        static let email = "email"
        static let gender = "gender"
        static let deviceType = "deviceType"
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
