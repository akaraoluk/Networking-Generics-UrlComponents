//
//  ViewController.swift
//  Codable-Networking
//
//  Created by Abdurrahman Karaoluk on 19.04.2024.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let api: UsersAPIProtocol = UsersAPI()
        
        api.getUsers { result in
            switch result {
                
            case .success(let response):
                let users = response?.data
                for user in users ?? [] {
                    print(user.firtsName)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

//        fetchData(url: "https://jsonplaceholder.typicode.com/users", responseClass: [UserModel].self) { (response) in
//            switch response {
//            case .success(let users):
//                guard let users = users else {return}
//                for user in users {
//                    print("id -> \(user.id), name -> \(user.name), email -> \(user.email)")
//                    print("test")
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//
//    }
//
//    func fetchData<T: Decodable>(url: String, responseClass: T.Type, completion: @escaping (Result<T?, NSError>) -> Void) {
//        AF.request(url, method: .get, parameters: [:], headers: [:]).response { (response) in
//            guard let statusCode = response.response?.statusCode else {return}
//            if statusCode == 200 {
//                guard let jsonResponse = try? response.result.get() else {return}
//                guard let theJsonData = try? JSONSerialization.jsonObject(with: jsonResponse, options: []) else {return}
//                guard let theJsonData = try? JSONSerialization.data(withJSONObject: theJsonData, options: []) else {return}
//                guard let responseObj = try? JSONDecoder().decode(T.self, from: theJsonData) else {return}
//                completion(.success(responseObj))
//            }
//        }
//    }
    
//    func fetchUserData(completion: @escaping (Result<[UserModel]?, NSError>) -> Void) {
//        let url = "https://jsonplaceholder.typicode.com/users"
//        AF.request(url, method: .get, parameters: [:], headers: [:]).response { (response) in
//            guard let statusCode = response.response?.statusCode else {return}
//            if statusCode == 200 {
//                guard let jsonResponse = try? response.result.get() else {return}
//                guard let theJsonData = try? JSONSerialization.jsonObject(with: jsonResponse, options: []) else {return}
//                guard let theJsonData = try? JSONSerialization.data(withJSONObject: theJsonData, options: []) else {return}
//                guard let responseObj = try? JSONDecoder().decode([UserModel].self, from: theJsonData) else {return}
//                completion(.success(responseObj))
//            }
//        }
//    }
//
//    func fetchPostsData(completion: @escaping (Result<[PostModel]?, NSError>) -> Void) {
//        let url = "https://jsonplaceholder.typicode.com/posts"
//        AF.request(url, method: .get, parameters: [:], headers: [:]).response { (response) in
//            guard let statusCode = response.response?.statusCode else {return}
//            if statusCode == 200 {
//                guard let jsonResponse = try? response.result.get() else {return}
//                guard let theJsonData = try? JSONSerialization.jsonObject(with: jsonResponse, options: []) else {return}
//                guard let theJsonData = try? JSONSerialization.data(withJSONObject: theJsonData, options: []) else {return}
//                guard let responseObj = try? JSONDecoder().decode([PostModel].self, from: theJsonData) else {return}
//                completion(.success(responseObj))
//            }
//        }
//    }


}

//class UserModel: Decodable {
//    //MARK: - Properties
//    var id: Int?
//    var name: String?
//    var email: String?
//    var userName: String?
//    var company: CompanyModel
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case email
//        case userName = "username"
//        case company
//
//    }
//}
//
//class CompanyModel: Decodable {
//
//}
//
//class PostModel: Decodable {
//    var title: String?
//    var body: String?
//}
