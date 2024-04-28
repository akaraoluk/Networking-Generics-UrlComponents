//
//  UsersResponse.swift
//  Codable-Networking
//
//  Created by Abdurrahman Karaoluk on 28.04.2024.
//

import Foundation

class UsersResponse: Codable {
    var data: [UserModel]?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}
