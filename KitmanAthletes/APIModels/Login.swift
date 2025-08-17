//
//  LoginRequest.swift
//  KitmanAthletes
//
//  Created by Kimti Vaghasia on 16/08/2025.
//

import Foundation

struct Login: Encodable {
    let username: String
    let password: String
}

struct LoginResponse: Decodable {
    let status: String
}
