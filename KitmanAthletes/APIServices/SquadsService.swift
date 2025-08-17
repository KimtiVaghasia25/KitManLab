//
//  Untitled.swift
//  KitmanAthletes
//
//  Created by Kimti Vaghasia on 16/08/2025.
//

import Foundation

public class SquadsService: SquadsServiceProtocol {
  
    private let apiClient: APIClient
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    class func baseURL() -> String {
        return "https://kitmanlabs.github.io/mobile-tech-challenge/api"
    }
    
    static var endPoint: String {
        return "/squads.json"
    }
    
    func getSquads(completion: @escaping ServiceClosure) {
        let path = "\(SquadsService.baseURL())/\(SquadsService.endPoint)"
        apiClient.httpGetRequest(path: path, responseType: [Squad].self, headers: nil, completion:  completion)
    }
}

protocol SquadsServiceProtocol : ServiceProtocol {
    func getSquads(completion: @escaping ServiceClosure)
}

