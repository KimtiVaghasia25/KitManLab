//
//  SquadListBaseViewModel.swift
//  KitmanAthletes
//
//  Created by Kimti Vaghasia on 16/08/2025.
//
import SwiftUI

protocol SquadListBaseViewModel : ObservableObject {
    
    var state: ListState { get set }
    var listType: ListType { get set }
    var squadResultObjects: [SquadListResultObject] { get set }
    var listLoadingStatus: ListLoadingStatus { get set }

    func fetchSquads()
}

class SquadListResultObject: SquadListResultProtocol {
    let id = UUID()
    var squad: Squad
    
    init(squad: Squad) {
        self.squad = squad
    }
}

protocol SquadListResultProtocol: Identifiable, ObservableObject {
    var id: UUID { get }
}
   
