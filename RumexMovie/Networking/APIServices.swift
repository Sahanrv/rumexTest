//
//  APIServices.swift
//  RumexMovie
//
//  Created by Sahan Ravindu on 2021-02-14.
//

import Foundation
import UIKit

public enum ResponseStatus: String {
    case success
    case error
}

public enum _AppEnvironment {
    case development
    case staging
    case production
}

public struct RestAPI {
    
    private static let appEnvironment: _AppEnvironment = .production
    static let APIKey = "Bearer RMI6nWQa5seHnmk5EAm7J6vPgFFe6HaC"
    
    static var BaseURL: String {
        get {
            switch appEnvironment {
            case .development:
                return "https://wudzy-backend.sandbox8.elegant-media.com"
            case .staging:
                return ""
            case .production:
                return "http://wudzy.com.au"
            }
        }
    }
    
    static var APIVersion: String {
        get {
            switch appEnvironment {
            case .development:
                return "/api/v1"
            case .staging:
                return "/api/v1"
            case .production:
                return "/api/v1"
            }
        }
    }
    
    static var googlePlacesKey = "AIzaSyBaFAaCiXw6_kataL25D8upKdRjU6Qhlzo"
    static var googleCloudVisionKey = "AIzaSyAdXrpXBw5oCQMERFOIzQoTyBhPD0G9sOc"
    
    static var googlePlacesUrl = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=%@&location=%@&radius=10000&key=\(googlePlacesKey)"
    
    static var googleVisionUrl = "https://vision.googleapis.com/v1/images:annotate?key=\(googleCloudVisionKey)"
    
}

public enum WebService: String {
    
    case signIn = "/auth/login"
    case retrievePassword = "/password/email"
    case checkEmail = "/auth/email"
    case signUp = "/auth/register"
    case users = "/users" // Update My Profile / Preferences, Settings, Delete Account, Search Users, Update Status
    case preferences = "/categories"
    case countries = "/countries"
    case settings = "/settings"
    case faqs = "/faqs"
    case myProfile = "/auth/me"
    case avatar = "/avatar"
    case logout = "/auth/logout"
    case changePassword = "/password"
    case contactUs = "/contact-requests"
    case blockedUsers = "/blocked-users" // Blocked user, Blocked users, Unblock user
    case unfollowUsers = "/unfollowed-users"
    case leads = "/leads"
    case myFriends = "/friends"
    case notifications = "/notifications"
    case read = "/read"
    case posts = "/posts"
    case feedPosts = "/posts/feed"
    case follow = "/followers" // Like / Unlike
    case status = "/status"
    case hide = "/hide"
    case albums = "/albums"
    case answers = "/answers"
    case friendGroups = "/friend-groups"
    case friendSuggestions = "/friend-suggestions"
    case comments = "/comments"
    case complaints = "/complaints"
    case message = "/message"
    case pushToken = "/push_token"
}
