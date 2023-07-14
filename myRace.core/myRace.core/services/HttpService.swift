//
//  HttpService.swift
//  myRace.core
//
//  Created by Yanbo Dang on 12/7/2023.
//

import Foundation

public protocol HttpService {
    func request<T: Decodable>(request: Request, completion: @escaping (Result<Response<T>, EnError>) -> Void)
}
