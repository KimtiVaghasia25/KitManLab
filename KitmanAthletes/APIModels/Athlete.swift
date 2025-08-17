//
//  Athlete.swift
//  KitmanAthletes
//
//  Created by Kimti Vaghasia on 16/08/2025.
//
import Foundation

public struct Athlete : Codable {
    
    public var firstName : String?
    public var lastName : String?
    public var iD : Int?
    public var athleteImage: AthleteImage?
    public var userName : String?
    public var squadIDs : [Int]?
    
    private enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case userName = "username"
        case athleteImage = "image"
        case iD = "id"
        case squadIDs = "squad_ids"
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        self.userName = try container.decodeIfPresent(String.self, forKey: .userName)
        self.iD = try container.decode(Int.self, forKey: .iD)
        self.squadIDs = try container.decodeIfPresent([Int].self, forKey: .squadIDs)
        self.athleteImage = try container.decodeIfPresent(AthleteImage.self, forKey: .athleteImage)
    }
    
    init(firstName: String, lastName: String, userName: String, athleteImage: AthleteImage? = nil){
        self.firstName = firstName
        self.lastName = lastName
        self.userName = userName
        self.athleteImage = athleteImage
    }
}


public struct AthleteImage : Codable {
    public var url : String?
}

