//
//  UserModel.swift
//  Codable-Networking
//
//  Created by Abdurrahman Karaoluk on 28.04.2024.
//

import Foundation

class UserModel: Codable {
    var firtsName: String?
    var lastName: String?
    
    enum CodingKeys: String, CodingKey {
        case firtsName = "first_name"
        case lastName = "last_name"
    }
}
