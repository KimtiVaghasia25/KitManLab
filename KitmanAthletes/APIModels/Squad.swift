//
//  Squad.swift
//  KitmanAthletes
//
//  Created by Kimti Vaghasia on 16/08/2025.
//

import Foundation

public class Squad : NSObject, Codable {
    
    public var createdDate : String?
    public var updatedDate : String?
    public var iD : Int?
    public var name : String?
    public var orgID : Int?
    
    private enum CodingKeys: String, CodingKey {
        case createdDate = "created_at"
        case updatedDate = "updated_at"
        case iD = "id"
        case name = "name"
        case orgID = "organisation_id"
    }
    
    public required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.createdDate = try container.decodeIfPresent(String.self, forKey: .createdDate)
        self.updatedDate = try container.decodeIfPresent(String.self, forKey: .updatedDate)
        self.iD = try container.decodeIfPresent(Int.self, forKey: .iD)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.orgID = try container.decodeIfPresent(Int.self, forKey: .orgID)
        super.init()
    }
}
