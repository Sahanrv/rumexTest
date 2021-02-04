//
//  APIRouter.swift
//  Template
//
//  Created by Sahan Ravind on 11/2/20.
//
import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

enum APIRouter: APIConfiguration {
    // MARK: - Services
    case login(username: String, password: String, deviceType: String)
    case register(username:String, password:String, email: String, gender: String)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .register:
            return .post
        
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .login:
            return "/login"
        case .register:
            return "/create_account"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .login(let username, let password, let deviceType) :
            return [K.APIParameterKey.username: username, K.APIParameterKey.password: password, K.APIParameterKey.deviceType: deviceType]
        case .register(let username, let password, let email, let gender):
            return [K.APIParameterKey.username: username, K.APIParameterKey.password: password, K.APIParameterKey.email: email, K.APIParameterKey.gender: gender]
        
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let urlString = (K.AppServer.baseURL + path).addingPercentEncoding(withAllowedCharacters : CharacterSet.urlQueryAllowed) ?? path
        let url = try urlString.asURL()
        var urlRequest = URLRequest(url: url) //.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
//        urlRequest.setValue("Bearer \(K.APIKey)", forHTTPHeaderField: HTTPHeaderField.authorization.rawValue)
        
        // Parameters
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        // NOTE:- Comment this after testing been completed
        printRequestData(urlRequest: urlRequest)
        
        return urlRequest
    }
    
    private func printRequestData(urlRequest: URLRequest) {
        print("**** URL:- \(urlRequest)")
        print("**** HTTP_METHOD:- \(method.rawValue)")
        print("**** HEADERS:- \(urlRequest.allHTTPHeaderFields ?? [:])")
        print("**** PARAMETERS:- \(parameters ?? [:])")
    }
}
