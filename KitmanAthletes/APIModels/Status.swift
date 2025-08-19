//
//  Status.swift
//  KitmanAthletes
//
//  Created by Kimti Vaghasia on 18/08/2025.
//
import SwiftUI


public struct AtheletStatus: Codable  {
    public var name: String?
    public var statuses: [Status]?
    public var athleteId : Int
}

public struct Status: Codable  {
    public var name: String?
    public var alarms: [Alarm]?
    public var statusId : Int?
    public var value: Float?
}


public struct Alarm: Codable  {
    public var alarmid : Int?
    public var condition: String?
    public var color: String?
    public var threshold: Float?
}

protocol StatusListResultProtocol: Identifiable, ObservableObject {
    var id: UUID { get }
    var status: Status { get }

}


class StatusResultObject : StatusListResultProtocol {
    var id = UUID()
    var status: Status
    
    init(id: UUID = UUID(), status: Status) {
        self.id = id
        self.status = status
    }
    
}
