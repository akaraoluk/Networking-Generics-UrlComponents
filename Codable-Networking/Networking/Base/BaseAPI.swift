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
                // Success
                guard let responseData = response.data else {
                    completion(.failure(NSError()))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let responseObj = try decoder.decode(M.self, from: responseData)
                    completion(.success(responseObj))
                    
                } catch let error {
                    print(error)
                    completion(.failure(NSError(domain: "com.yourapp.error", code: 1, userInfo: ["message": "JSON kod çözülürken hata oluştu"])))
                }
                
            } else {
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
