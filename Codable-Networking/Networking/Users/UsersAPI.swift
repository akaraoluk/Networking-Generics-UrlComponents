//
//  UsersAPI.swift
//  Codable-Networking
//
//  Created by Abdurrahman Karaoluk on 28.04.2024.
//

import Foundation

protocol UsersAPIProtocol {
    func getUsers(completion: @escaping (Result<BaseResponse<[UserModel]>?, NSError>) -> Void)
}

class UsersAPI: BaseAPI<UsersNetworking>, UsersAPIProtocol {
        
    //MARK: - Request
    
    func getUsers(completion: @escaping (Result<BaseResponse<[UserModel]>?, NSError>) -> Void) {
        self.fetchData(target: .getUsers, responseClass: BaseResponse<[UserModel]>.self) { result in
            completion(result)
        }
    }
}

