//
//  AthletesService.swift
//  KitmanAthletes
//
//  Created by Kimti Vaghasia on 16/08/2025.
//

import Foundation

public class AthletesService : AthletesServiceProtocol {
    
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    class func baseURL() -> String {
        return "https://kitmanlabs.github.io/mobile-tech-challenge/api"
    }
    
    static var endPoint: String {
        return "/athletes.json"
    }
    
    func getAthletes(completion: @escaping ServiceClosure) {
      
        let path = "\(AthletesService.baseURL())/\(AthletesService.endPoint)"
        apiClient.httpGetRequest(path: path, responseType: [Athlete].self, headers: nil, completion:  completion)
    }
}

protocol AthletesServiceProtocol : ServiceProtocol {
    func getAthletes(completion: @escaping ServiceClosure)
}


