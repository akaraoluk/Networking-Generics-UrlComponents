//
//  TargetType.swift
//  Codable-Networking
//
//  Created by Abdurrahman Karaoluk on 28.04.2024.
//

import Foundation
import Alamofire

enum HTTPMethod: String {
    case get = "GET"
    case post = "PSOT"
    case put = "PUT"
    case delete = "DELETE"
}

enum Task {
    case requestPlain
    
    case requestParameters(parameters: [String:Any], encoding: ParameterEncoding)
}

protocol TargetType {
    
    var baseUrl: String {get}
    
    var path: String {get}
    
    var methods: HTTPMethod {get}
    
    var task: Task {get}
    
    var headers: [String:String]? {get}
}
