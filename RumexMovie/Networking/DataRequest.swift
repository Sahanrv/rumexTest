import Foundation
import Alamofire
import SwiftyJSON

enum Result<T> {
    case Success(T, Int)
    case Invalid(String, Int)
    case Failure(Error, Int)
}


enum HeaderType {
    case Guest
    case UserSession
    case Contents
    case None
}


enum HTTPHeaderField: String {
    case authorization = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case bundleId = "X-Ios-Bundle-Identifier"
}


enum ContentType: String {
    case json = "application/json"
    case formData = "application/x-www-form-urlencoded"
    case multipartFormData = "multipart/form-data"
}


struct MaltipartData {
    var data: Data
    var name: String // profile_pic
    var fileName: String // file.jpg
    var mimeType: String // image/jpg
}


private func getHeaders(_ type: HeaderType) -> HTTPHeaders {
    
    switch type {
    case .Guest:
        return [
            HTTPHeaderField.authorization.rawValue: RestAPI.APIKey,
            HTTPHeaderField.acceptType.rawValue: ContentType.json.rawValue
        ]
    case .UserSession:
        return [
            HTTPHeaderField.authorization.rawValue: "Bearer \(LocalUser.current()?.accessToken ?? "")",
            HTTPHeaderField.acceptType.rawValue: ContentType.json.rawValue
        ]
    case .Contents:
        return [
            HTTPHeaderField.acceptType.rawValue: ContentType.json.rawValue, HTTPHeaderField.bundleId.rawValue: ApplicationServiceProvider.shared.bundleId
        ]
    case .None:
        return [:]
    }
}


struct URLDataRequest {
    
    private var urlString: String
    private var headerType: HeaderType
    private var parameters: [String : Any]?
    private var httpMethod: HTTPMethod
    private var arguments: String?
    private var multipartData: [MaltipartData]?
    
    
    //MARK: Normal form - Ex: base_url/end_point -> (GET, POST, PUT, DELETE)
    init(url: String, header: HeaderType, param: [String : Any]?, method: HTTPMethod = .get) {
        urlString = url.addingPercentEncoding(withAllowedCharacters : CharacterSet.urlQueryAllowed) ?? ""
        headerType = header
        parameters = param
        httpMethod = method
    }
    
    
    //MARK: Multipart form
    init(url: String, header: HeaderType, param: [String : Any]?, formData: [MaltipartData]) {
        urlString = url.addingPercentEncoding(withAllowedCharacters : CharacterSet.urlQueryAllowed) ?? ""
        headerType = header
        parameters = param
        httpMethod = .post
        multipartData = formData
    }
    
    
    /*//MARK: Check internet connection
    func checkInternetConnection() {
        if let manager = NetworkReachabilityManager(), !manager.isReachable {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                // Your code here
                let banner = StatusBarNotificationBanner(title: "The Internet connection appears to be offline.", style: .danger)
                banner.haptic = .heavy
                banner.show()
            }
        }
    }*/
    
    
    //MARK: Normal Request
    public func requestData(completion: @escaping (Result<Data>) -> Void) {
        // Check internet connection availability
        //checkInternetConnection()
        
        // Show Activity Indicator
        NetworkActivityIndicatorManager.networkOperationStarted()
        
        // Log API request info
        self.logAPIRequestInfo(isUpload: false)
        
        // Continue with Alamofire request
        AF.request(urlString, method: httpMethod, parameters: httpMethod == .get ? nil : parameters, encoding: JSONEncoding.default, headers: getHeaders(headerType))
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate()
            .responseJSON { response in
                // Hide Activity Indicator
                NetworkActivityIndicatorManager.networkOperationFinished()
                
                let _statusCode = response.response?.statusCode ?? 0
                
                switch response.result {
                case .success:
                    if let data = response.data {
                        switch _statusCode {
                        case 200...299:
                            completion(.Success(data, _statusCode))
                        default:
                            let json = JSON(data)
                            let message = json["message"].stringValue
                            completion(.Invalid(message, _statusCode))
                        }
                    }
                case .failure(let error):
                    //completion(.Failure(error, statusCode))
                    self.hadleErrorResponse(error, errorCode: _statusCode, completion: { (status, statusCode, message) in
                        let _error = CustomError.serverError(message: message)
                        completion(.Failure(_error, statusCode))
                    })
                }
        }
    }
    
    
    //MARK: Multipart Upload
    public func uploadData(completion: @escaping (Result<Data>) -> Void) {
        // Check internet connection availability
        //checkInternetConnection()

        // Show Activity Indicator
        NetworkActivityIndicatorManager.networkOperationStarted()
        
        // Log API request info
        //self.logAPIRequestInfo(isUpload: true)
        
        // Continue with Alamofire upload
        AF.upload(multipartFormData: { multipartFormData in
            
            if let multipartData = self.multipartData {
                
                multipartData.forEach({ multipartDataItem in
                    multipartFormData.append(multipartDataItem.data, withName: multipartDataItem.name, fileName: multipartDataItem.fileName, mimeType: multipartDataItem.mimeType)
                })
            }
            
            if let param = self.parameters {
                for (key, value) in param {
                    multipartFormData.append(("\(value)").data(using: String.Encoding.utf8)!, withName: key)
                }
            }
            
            print(multipartFormData)
        }, to: urlString, method: httpMethod, headers: getHeaders(headerType))
            .validate()
            .responseJSON { response in
                // Hide Activity Indicator
                NetworkActivityIndicatorManager.networkOperationFinished()
                
                let _statusCode = response.response?.statusCode ?? 0
                
                switch response.result {
                case .success:
                    if let data = response.data {
                        switch _statusCode {
                        case 200...299:
                            completion(.Success(data, _statusCode))
                        default:
                            let json = JSON(data)
                            let message = json["message"].stringValue
                            completion(.Invalid(message, _statusCode))
                        }
                    }
                case .failure(let error):
                    //completion(.Failure(error, statusCode))
                    self.hadleErrorResponse(error, errorCode: _statusCode, completion: { (status, statusCode, message) in
                        let _error = CustomError.serverError(message: message)
                        completion(.Failure(_error, statusCode))
                    })
                }
        }
    }
    
    
    //MARK: Log API request info
    func logAPIRequestInfo(isUpload: Bool) {
        
        print("**** UPLOAD INFO ****")
        print("URL: ========> \(urlString)")
        print("HTTP METHOD: ====> \(httpMethod)")
        print("HEADERS: ====> \(getHeaders(headerType))")
        print("PARAMETERS: => \(parameters ?? [:])")
        print("ARGUMENTS: => \(arguments ?? "")")
        
        if isUpload {
            print("MULTIPART DATA COUNT: => \(multipartData?.count ?? 0)")
        }
    }
    
    
    //MARK: Handle error response
    func hadleErrorResponse(_ error: Error?, errorCode: Int, completion: CompletionHandler) {
        
        if let errorResponse = error as? ErrorResponse {
            switch errorResponse {
            case .error(let statusCode, let data, _):
                guard let responseData = data else {
                    return
                }
                let errorJson = JSON(responseData)
                completion(false, statusCode, errorJson["message"].stringValue)
            }
        } else {
            completion(false, errorCode, .ServerErrorOccured)
        }
    }
    
}


public enum CustomError: Error {
    case serverError(message: String)
}


extension CustomError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .serverError(let message):
            return NSLocalizedString(message, comment: "")
        }
    }
}
