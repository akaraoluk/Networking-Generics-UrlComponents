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
                    print("\(user.name ?? "") => \(user.salary ?? "")")
                }
            case .failure(let error):
                print(error.userInfo[NSLocalizedDescriptionKey] as? String)
            }
        }
    }
}

