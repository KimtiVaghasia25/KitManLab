//
//  AuthService.swift
//  KitmanAthletes
//
//  Created by Kimti Vaghasia on 16/08/2025.
//

public class LoginService : LoginServiceProtocol {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    class func baseURL() -> String {
        return "https://kitmanlabs.github.io/mobile-tech-challenge/api"
    }
    
    static var endPoint: String {
        return "/session.json"
    }
    
    func authenticateUser(userName: String, password: String , completion: @escaping ServiceClosure) {
        let path = "\(LoginService.baseURL())/\(LoginService.endPoint)"
        apiClient.httpGetRequest(path: path, responseType: LoginResponse.self, headers: nil, completion:  completion)
    }
}

protocol LoginServiceProtocol : ServiceProtocol {
    func authenticateUser(userName: String, password: String , completion: @escaping ServiceClosure)
}
