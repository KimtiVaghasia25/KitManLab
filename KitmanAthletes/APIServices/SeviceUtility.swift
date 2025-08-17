//
//  SeviceUtility.swift
//  KitmanAthletes
//
//  Created by Kimti Vaghasia on 16/08/2025.
//

import UIKit

public enum HeaderKeys:String {
    case apiVersion = "Accept"
}

public class ServiceReponse: NSObject {
    
    @objc public var data:Any?
    @objc public var error:Error?
    @objc public var metaData:Any?
    @objc public var messages:Any?
    
    public init(response:Any?, error:Error?, metaData:Any? = nil, messages:Any? = nil) {
        self.data = response
        self.error = error
        self.metaData = metaData
        self.messages = messages
    }
    
}

public typealias ServiceClosure = (ServiceReponse) -> Void

public enum APIHTTPMethod:String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public enum APIErrorType: Int {
    case parseError
    case emptyData
    case noClaims
    case apiError
    case connectionError
    case accessTokenError
    case noContent
    case clientError
    case cancelled
    case notFound
}

public struct APIError: LocalizedError {

    public var code: Int
    public var errorDescription: String
    public var errorTitle: String
    
    init(type: APIErrorType, title: String, errorDescription: String) {
        self.code = type.rawValue
        self.errorTitle = title
        self.errorDescription = errorDescription
    }
}

protocol ServiceProtocol {
    static func baseURL() -> String
    static var endPoint : String { get }
}

protocol APIClientProtocol {
    func httpGetRequest<T:Decodable>(path:String,
                                            responseType:T.Type,
                                            headers:[String:String]?,
                                            completion:@escaping ServiceClosure)
    func makeRequest<T:Decodable>(request:URLRequest, responseType:T.Type, completion:@escaping ServiceClosure)
}

@objc open class APIClient: NSObject, URLSessionDelegate, APIClientProtocol {
        
    private var requestTimeout:TimeInterval = 60
    private var urlSession:URLSession!
    
    private var operationQueue:OperationQueue = OperationQueue()
    
    @objc class func APIDefaultConfig() -> URLSessionConfiguration {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 360
        sessionConfig.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return sessionConfig
    }
        
    @objc required public init(config:URLSessionConfiguration? = nil){
        super.init()
        
        var urlConfig = config
        
        if config == nil {
            urlConfig = APIClient.APIDefaultConfig()
        }
        
        if let apiConfig = config {
            self.requestTimeout = apiConfig.timeoutIntervalForRequest
            urlConfig = apiConfig
        }
        
        self.urlSession = URLSession(configuration: urlConfig!, delegate: self, delegateQueue: nil)
        
    }
                    
    //MARK: - URL Request realted
    
    public func getAccessToken() -> String? {
        
        return "Bearer abcd"
    }
    
    public func getSession() -> URLSession {
        return self.urlSession
    }
    
    func sanitizeURL(url:URL) -> URL? {
        
        var components = URLComponents.init(string: url.absoluteString)
        if let path = components?.path {
            let sanitizedPath = path.replacingOccurrences(of: "//", with: "/")
            components?.path = sanitizedPath
        }
        
        if let cleanURL = components?.url {
            return cleanURL
        }
        
        return nil
        
    }
    
    public func getRequest(forURL url:URL, httpMethod:APIHTTPMethod = .get, headers:[String:String]? = nil) -> URLRequest? {
        
        guard let url = self.sanitizeURL(url: url) else {
            return nil
        }
        
        guard let accessToken = self.getAccessToken() else {
            return nil
        }
        
        var request:URLRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: self.requestTimeout)
        request.httpMethod = httpMethod.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //If we have custom headers, process them here
        if let headers = headers {
            for (key,value) in headers {
                if key != "Accept" {
                    request.addValue(value, forHTTPHeaderField: key)
                }
            }
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
        }else{
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        }
        
        request.addValue(accessToken, forHTTPHeaderField: "Authorization")
        return request
        
    }
    
    //MARK: - Error handling
    
    open class func error(of type:APIErrorType) -> APIError {
        return APIError.init(type: type, title: self.errorTitle(error: type), errorDescription: self.errorDescription(error: type))
    }
            
    open class func errorDescription(error:APIErrorType) -> String {
        switch error {
            
        case .parseError:
            return NSLocalizedString("Unable to parse data", comment: "JSON Parsing error")
            
        case .emptyData:
            return NSLocalizedString("No content to display", comment: "empty data response")
            
        case .noClaims:
             return NSLocalizedString("You do not have permission to view data", comment: "permission error")
            
        case .apiError:
            return NSLocalizedString("Server Error", comment: "API error")
            
        case .connectionError:
            return NSLocalizedString("Error connecting to the server. This could be due to network or connectivity issues or an invalid URL.", comment: "Network error")
            
        case .accessTokenError:
            return NSLocalizedString("Error loading data", comment: "Auth error")
            
        case .noContent:
            return NSLocalizedString("No content to display", comment: "No content - 204")
            
        case .clientError:
            return NSLocalizedString("Client error, bad request", comment: "400 range error")
        
        case .cancelled:
            return NSLocalizedString("Request cancelled", comment: "Client cancelled request")
        
        case .notFound:
            return NSLocalizedString("Not found", comment: "Not found")
            
        }
        
    }
    
    open class func errorTitle(error:APIErrorType) -> String {
        return "Data Unavailable"; // for client overrride
    }
    
    //MARK: - Session task and response
    
    public func makeRequest<T:Decodable>(request:URLRequest, responseType:T.Type, completion:@escaping ServiceClosure) {
        
        let urlString = request.url?.absoluteString

         self.getSession().dataTask(with: request) { (data, response, error) in
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        print("[RESPONSE] [\(httpResponse.statusCode)] : \(urlString ?? "")")
                        
                             
                        if let data = data {
                            let responseString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
//                            print("ResponseString>>>>: \(String(describing: responseString))")
                        }
                        switch httpResponse.statusCode {
                        
                        case 200:
                            do {
                    
                                guard let data = data else {
                                    let response = ServiceReponse(response: nil, error: error)
                                    completion(response)
                                    return
                                }
                                                                
                                let jsonDecoder = JSONDecoder()
//                                jsonDecoder.keyDecodingStrategy = .convertToLowerCamelCase
                                let results = try jsonDecoder.decode(responseType, from: data)
                                
                                let response = ServiceReponse(response: results, error: error)
                                completion(response)
                            }
                            catch {
                                
                                if data?.count == 0 {
                                    let response = ServiceReponse(response: nil, error: nil)
                                    completion(response)
                                }
                                
                                print("JSON Parsing error. The response format received was not what was expected")
                                print(error)
                                completion(self.generateErrorResponseObject(for: .parseError))
                            }
                            
                        case 201,204:
                            let apiClientResponse:ServiceReponse = ServiceReponse(response: nil, error: error)
                            completion(apiClientResponse)
                        
                        case 400, 422:
                            self.printErrorToConsole(data: data)
                            let apiClientResponse:ServiceReponse = self.generateErrorResponseObject(for: .clientError)
                            completion(apiClientResponse)
             
                        case 404:
                            self.printErrorToConsole(data: data)
                            let apiClientResponse:ServiceReponse = self.generateErrorResponseObject(for: .notFound)
                            completion(apiClientResponse)
                        case 401,403:
                            self.printErrorToConsole(data: data)
                            let apiClientResponse:ServiceReponse = self.generateErrorResponseObject(for: .noClaims)
                            completion(apiClientResponse)
                            
                        case 500...:
                            self.printErrorToConsole(data: data)
                            completion(self.generateErrorResponseObject(for: .apiError))
                        default:
                            completion(self.generateErrorResponseObject(for: .apiError))
                        }
                   }
                   
                }.resume()
    }

    private func printErrorToConsole(data:Data?) {
        if let data = data {
            if let response = String(data: data, encoding: .utf8) {
                print(response)
            }
        }
    }
    
    public func generateErrorResponseObject(for apiErrorType:APIErrorType) -> ServiceReponse {
        let apiClientResponse = ServiceReponse(response: nil, error: type(of: self).error(of: apiErrorType))
        return apiClientResponse
    }
    
    //MARK: HTTP Methods
    
    public func httpPostRequest<T:Decodable>(path:String, responseType:T.Type,
                                             httpBody:Data?,
                                             headers:[String:String]?,
                                             completion:@escaping ServiceClosure) {
        
        if let url:URL = URL(string: path) {

            if var request = self.getRequest(forURL: url, httpMethod: .post, headers: headers) {
                
                request.httpBody = httpBody
                
                self.makeRequest(request: request, responseType: responseType) { (response) in
                    completion(response)
                }

            }

        }
        
    }
    
    public func httpGetRequest<T:Decodable>(path:String,
                                            responseType:T.Type,
                                            headers:[String:String]?,
                                            completion:@escaping ServiceClosure) {
        
        if let url:URL = URL(string: path) {

            if let request = self.getRequest(forURL: url, httpMethod: .get, headers: headers) {

                self.makeRequest(request: request, responseType: responseType) { (response) in
                    completion(response)
                }
            }
        }
        
    }
    
    public func httpPutRequest<T:Decodable>(path:String, responseType:T.Type,
                                             httpBody:Data?,
                                             headers:[String:String]?,
                                             completion:@escaping ServiceClosure) {
        
        if let url:URL = URL(string: path) {

            if var request = self.getRequest(forURL: url, httpMethod: .put, headers: headers) {
                
                request.httpBody = httpBody
                self.makeRequest(request: request, responseType: responseType) { (response) in
                    completion(response)
                }

            }

        }
        
    }
    
    public func httpDeleteRequest<T:Decodable>(path:String, responseType:T.Type,
                                             httpBody:Data?,
                                             headers:[String:String]?,
                                             completion:@escaping ServiceClosure) {
        
        if let url:URL = URL(string: path) {

            if var request = self.getRequest(forURL: url, httpMethod: .delete, headers: headers) {
                
                request.httpBody = httpBody
                
                self.makeRequest(request: request, responseType: responseType) { (response) in
                    completion(response)
                }

            }

        }
        
    }
    
    //MARK: - URL Session delegates
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if let trust = challenge.protectionSpace.serverTrust {
            let creds = URLCredential.init(trust: trust)
            completionHandler(.useCredential, creds)
        }
    }
        
}


