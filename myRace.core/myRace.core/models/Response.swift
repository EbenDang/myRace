//
//  Response.swift
//  myRace.core
//
//  Created by Yanbo Dang on 12/7/2023.
//

import Foundation

struct Response<T>: Decodable where T: Decodable {
    let status: Int
    let message: String
    let data: T?
    
    enum CodingKeys: String, CodingKey {
        case status
        case message
        case data
    }
}
