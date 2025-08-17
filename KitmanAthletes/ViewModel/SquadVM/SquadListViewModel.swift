//
//  SquadListViewModel.swift
//  KitmanAthletes
//
//  Created by Kimti Vaghasia on 16/08/2025.
//

import SwiftUI

class SquadListViewModel : SquadListBaseViewModel {    
    
    @objc var listType: ListType = .FlatList
    @Published var state: ListState = .idle
    var listLoadingStatus =  ListLoadingStatus()
    var atheleteObj : AthleteListResultObject

    private var squadService : SquadsService
    private var squads = [Squad]()
    var squadResultObjects = [SquadListResultObject]()

    init(atheleteObj: AthleteListResultObject, squadService : SquadsService) {
        self.atheleteObj = atheleteObj
        self.squadService = squadService
    }
    
    func fetchSquads() {
        self.state = .loading

        self.squadService.getSquads(completion: { response in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in

                if let resultSquads = response.data as? [Squad] {
                    if let error = response.error {
                        self.state = .failed(error)

                    } else {
                        self.squads = resultSquads
                        self.squadResultObjects = self.processSquadsForSelectedAthlete()
                        self.state = .loaded

                    }
                }
            }
        })
    }
    
    func processSquadsForSelectedAthlete() -> [SquadListResultObject] {
        var athleteSquads = [Squad]()
        var sqdObjs = [SquadListResultObject]()

        if let squadIDs = self.atheleteObj.athlete.squadIDs {
            for squadID in squadIDs {
                let filterSuqads = self.squads.filter({$0.iD == squadID})
                athleteSquads.append(contentsOf:filterSuqads)
            }
        }
        for each in athleteSquads {
            let sqdObj = SquadListResultObject(squad: each)
            sqdObjs.append(sqdObj)
        }
        return sqdObjs
    }
    
}
