//
//  Untitled.swift
//  KitmanAthletes
//
//  Created by Kimti Vaghasia on 18/08/2025.
//

import Foundation

public class StatusService : StatusServiceProtocol {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    class func baseURL() -> String {
        return "https://kitmanlabs.github.io/mobile-tech-challenge/api"
    }
    
    static var endPoint: String {
        return "/statuses/statuses.json"
    }

    func getStatus(completion: @escaping ServiceClosure) {
      
        let path = "\(StatusService.baseURL())/\(StatusService.endPoint)"
        apiClient.httpGetRequest(path: path, responseType: [AtheletStatus].self, headers: nil, completion:  completion)
    }
}

protocol StatusServiceProtocol : ServiceProtocol {
    func getStatus(completion: @escaping ServiceClosure)
}
