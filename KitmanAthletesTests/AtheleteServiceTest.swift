//
//  AtheleteServiceTest.swift
//  KitmanAthletes
//
//  Created by Kimti Vaghasia on 17/08/2025.
//

import XCTest

import KitmanAthletes

class ServiceUtilityTest : XCTestCase {
    
    func testGetAthletes () {
        let expectation = XCTestExpectation(description: "Fetch Athletes...")

        let atheletService = AthletesService(apiClient: MockServiceUtility())
        atheletService.getAthletes { response in
            if let error = response.error {
                XCTFail("Error: \(error.localizedDescription)")

            } else {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)


    }
}

class MockServiceUtility: APIClient {
    
    override func makeRequest<T>(request: URLRequest, responseType: T.Type, completion: @escaping ServiceClosure) where T : Decodable {
        let jsonString = """
                  [{
              "first_name": "Adam"
              "last_name": "Beard"
              "id": 1964,
              "image": {
              ,
              ,
              "url": "https://kitman.imgix.net/avatar.jpg"
              },
              "username": "abeardathlete"
              "squad_ids": [78]
              ,
              }
                  ]
              """
              if let data = jsonString.data(using: .utf8) {
                  let response = ServiceReponse(response: data, error: nil)
                  completion(response)
              
              } else {
                  let error = NSError(domain: "MockNetworkingServiceErrorDomain", code: -1, userInfo: nil)
                  let response = ServiceReponse(response: nil, error: error)
                  completion(response)
              }
    }
    
    
    
    
}
