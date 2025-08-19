//
//  AthleteListViewModel.swift
//  KitmanAthletes
//
//  Created by Kimti Vaghasia on 16/08/2025.
//
import Foundation
import UIKit


class AthleteListViewModel: NSObject, AthleteListBaseViewModel {
    @objc var listType: ListType = .FlatList
    @Published var state: ListState = .idle

    var sectionedList = [AthleteListResultsSectionData]()
    var listLoadingStatus =  ListLoadingStatus()
    
    private var athletesService : AthletesService

    private var athletes = [Athlete]()

    private var isLoading : Bool = false

    override init() {
        self.athletesService = AthletesService(apiClient: APIClient())
    }
    
    
    func fetchAthletes() {
        if (self.athletes.count > 0 && isLoading == false) {
            self.state = .loaded
        } else {
            self.state = .loading
            isLoading = true
            self.athletesService.getAthletes(completion: { response in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in

                    if let resultAthletes = response.data as? [Athlete] {
                        if let error = response.error {
                            self.state = .failed(error)
                            print("Error While fetching thletes data")
                        } else {
                            self.athletes = resultAthletes
                            self.state = .loaded
                            processSection(athletes: self.athletes)
                            
                            StatusViewModel(athelete: athletes.first!, statusService: StatusService(apiClient: APIClient())).getStatus()
                        }
                    }
                }
            })
        }
    }
    
    func processSection(athletes: [Athlete]) {

        var athObjs = [AthleteListResultObject]()

        for athlete in athletes {
            let athObj = AthleteListResultObject(athlete: athlete)
            athObjs.append(athObj)
            
            let section = AthleteListResultsSectionData(key: athlete.userName ?? "", displayValue: athObj.athlete.userName ?? "", items: [athObj])
            sectionedList.append(section)
        }
    }
    
    
    
    func refreshOnPull(completion: (([Athlete], Error?) -> ()))  {
        self.isLoading = true
        self.fetchAthletes()
    }
}
