//
//  StatusViewModel.swift
//  KitmanAthletes
//
//  Created by Kimti Vaghasia on 18/08/2025.
//
import SwiftUI

class StatusViewModel: NSObject, ObservableObject {
    
    var atheletStatuses = [AtheletStatus]()
    let athelete: Athlete
    let statusService: StatusService
    
    var statuses = [Status]()
    
    init(athelete: Athlete, statusService: StatusService) {
        self.athelete = athelete
        self.statusService = statusService
    }
    
    func getStatus() {
        statusService.getStatus { response in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in

                if let statuses = response.data as? [AtheletStatus] {
                    if let error = response.error {
//                        self.state = .failed(error)

                    } else {
                        self.atheletStatuses = statuses
                        self.processSquadsForSelectedAthlete()
//                        self.state = .loaded

                    }
                }
            }
        }
    }
    
    func processSquadsForSelectedAthlete() {
        var filteredStatuses = [AtheletStatus]()

        filteredStatuses = atheletStatuses.filter({$0.athleteId == 12})
        print("filteredStatuses:\(filteredStatuses)")
    }
}
