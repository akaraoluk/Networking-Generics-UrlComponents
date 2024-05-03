//
//  BaseResponse.swift
//  Codable-Networking
//
//  Created by Abdurrahman Karaoluk on 3.05.2024.
//

import Foundation

class BaseResponse<T: Codable>: Codable {
    var status: String?
    var data: T? 
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case data = "data"
    }
}
