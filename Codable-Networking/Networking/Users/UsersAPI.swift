//
//  UsersAPI.swift
//  Codable-Networking
//
//  Created by Abdurrahman Karaoluk on 28.04.2024.
//

import Foundation

protocol UsersAPIProtocol {
    func getUsers(completion: @escaping (Result<UsersResponse?, NSError>) -> Void)
}

class UsersAPI: BaseAPI<UsersNetworking>, UsersAPIProtocol {
        
    //MARK: - Request
    
    func getUsers(completion: @escaping (Result<UsersResponse?, NSError>) -> Void) {
        self.fetchData(target: .getUsers, responseClass: UsersResponse.self) { result in
            completion(result)
        }
    }
}
