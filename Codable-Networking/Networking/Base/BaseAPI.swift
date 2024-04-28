//
//  BaseAPI.swift
//  Codable-Networking
//
//  Created by Abdurrahman Karaoluk on 28.04.2024.
//

import Foundation
import Alamofire

class BaseAPI<T: TargetType> {
    
    func fetchData<M: Decodable>(target: T, responseClass: M.Type, completion:@escaping(Result<M?, NSError>) -> Void) {
        let method = Alamofire.HTTPMethod(rawValue: target.methods.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params = buildParams(task: target.task)
        AF.request(target.baseUrl + target.path, method: method, parameters: params.0, encoding: params.1, headers: headers).responseDecodable(of: M.self) { response in
            guard let statusCode = response.response?.statusCode else {
                //ADD Custom Error
                completion(.failure(NSError()))
                return
                
            }
            
            if statusCode == 200 {
                // Successful Request
                guard let jsonResponse = try? response.result.get() else {
                    //ADD Custom Error
                    completion(.failure(NSError()))
                    return
                }
                guard let theJSONData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else {
                    //ADD Custom Error
                    completion(.failure(NSError()))
                    return
                }
                guard let responseObj = try? JSONDecoder().decode(M.self, from: theJSONData) else {
                    //ADD Custom Error
                    completion(.failure(NSError()))
                    return
                }
                completion(.success(responseObj))
                
            } else {
                // ADD Custom Error base on status code 404 / 401 /
                completion(.failure(NSError()))
            }
        }
        
        
    }
    
    private func buildParams(task: Task) -> ([String:Any], ParameterEncoding) {
        switch task {
            
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
}
