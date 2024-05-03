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
                let error = NSError(domain: target.baseUrl, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                completion(.failure(error))
                return
                
            }
            
            if statusCode == 200 {
                // Successful Request
                guard let responseData = response.data else {
                    let error = NSError(domain: target.baseUrl, code: statusCode, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                    completion(.failure(error))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let responseObj = try decoder.decode(M.self, from: responseData)
                    completion(.success(responseObj))
                    
                } catch let error {
                    print(error)
                    completion(.failure(NSError(domain: "com.yourapp.error", code: 1, userInfo: ["message": "JSON kod çözülürken hata oluştu"])))
                    let error = NSError(domain: target.baseUrl, code: statusCode, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                    completion(.failure(error))
                }
                
            } else {
                // Add Custom Error Base on Status Code 404 / 401
                // Error Parsing For The Error Message From the Back-End
                let message = "Error Message Parsed From Back-End"
                completion(.failure(NSError()))
                let error = NSError(domain: "HTTPError", code: statusCode, userInfo: nil)
                
                let error2 = NSError(domain: target.baseUrl, code: statusCode, userInfo: [NSLocalizedDescriptionKey: message])
                completion(.failure(error2))
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
