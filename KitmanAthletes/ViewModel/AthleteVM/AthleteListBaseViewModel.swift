//
//  AthleteListBaseViewModel.swift
//  LoadPatients
//
//  Created by Kimti Vaghasia on 10/07/2025.
//

import UIKit
import Foundation
import SwiftUI


protocol AthleteListBaseViewModel : ObservableObject{
    
    var state: ListState { get set }
    var listType: ListType { get set }
    var sectionedList: [AthleteListResultsSectionData] { get set }
    var listLoadingStatus: ListLoadingStatus { get set }

    func fetchAthletes()
}

class AthleteListResultObject: AthleteListResultProtocol {
    let id = UUID()
    var athlete: Athlete
    
    init(athlete: Athlete) {
        self.athlete = athlete
    }
    
    func formattedInfo() -> NSAttributedString {
        let formattedText = NSMutableAttributedString(string: "")
        let newLineText = NSMutableAttributedString(string: "\n")

        if let firstName = athlete.firstName, let lastName = athlete.lastName {
            let fullName = "\(firstName) \(lastName)"
            let nameAttribute = [ NSAttributedString.Key.font : StyleManager.boldApplicationFont(size: AppFontSize.body)]
            let attfullName = NSAttributedString(string: fullName , attributes: nameAttribute)
            formattedText.append(attfullName)
            formattedText.append(newLineText)
        }
        return formattedText
    }
}

protocol AthleteListResultProtocol: Identifiable, ObservableObject {
    var id: UUID { get }
    
    func formattedInfo() -> NSAttributedString
}

struct AthleteListResultsSectionData: Identifiable
{
    var key: String
    var displayValue: String
    var items: [any AthleteListResultProtocol]
    
    var id: String {
        get {
            key
        }
    }
}

enum ListState: Equatable {
    
    static func == (lhs: ListState, rhs: ListState) -> Bool {
        
        switch (lhs, rhs) {
        
            case (.idle, .idle),
                    (.loading, .loading),
                    (.loaded, .loaded):
                    return true
            case (.failed(let lhsType), .failed(let rhsType)):
                guard type(of: lhsType) == type(of: rhsType) else { return false }

                if let lhs = lhsType as? NSError, let rhs = rhsType as? NSError {
                    return lhs.domain == rhs.domain && lhs.code == rhs.code
                }
                return false
            default:
                    return false
        }
    }
    
    case idle
    case loading
    case failed(Error?)
    case loaded
}


@objc enum ListType : Int {
    case FlatList
    case SectionList
}

struct ListLoadingStatus
{
    var loadingStatus: String
    var loadingDescription: String
    
    init(loadingStatus: String = "No Data Found", loadingDescription: String = "There are no athletes on this list") {
        self.loadingStatus = loadingStatus
        self.loadingDescription = loadingDescription
    }
}
