//
//  UserModel.swift
//  Codable-Networking
//
//  Created by Abdurrahman Karaoluk on 28.04.2024.
//

import Foundation

class UserModel: Codable {
    var name: String?
    var salary: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "employee_name"
        case salary = "employee_salary"
    }
}
