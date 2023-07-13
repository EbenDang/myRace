//
//  HttpServiceImpl.swift
//  myRace.core
//
//  Created by Yanbo Dang on 12/7/2023.
//

import Foundation
import Alamofire

class HttpServiceImpl: HttpService {
    
    func request<T: Decodable>(request: Request, completion: @escaping (Result<Response<T>, EnError>) -> Void) {
        let endPoint = "\(ApiEndPoint.basePoint)\(ApiEndPoint.apiVer)\(request.url)"
        
        AF.request(endPoint, method: request.method, parameters: request.params)
            .validate()
            .responseData { result in
                if let error = result.error {
                    print("\(error)")
                    completion(.failure(.invalidResData))
                    return
                }
                
                guard let jsonData = result.data else {
                    completion(.failure(.invalidResData))
                    return
                }
                
                print(String(data: jsonData, encoding: .utf8)!)
                do {
                    let response = try JSONDecoder().decode(Response<T>.self, from: jsonData)
                    completion(.success(response))
                } catch let error {
                    print(error)
                    completion(.failure(.invalidResData))
                }
                
            }
    }
}
