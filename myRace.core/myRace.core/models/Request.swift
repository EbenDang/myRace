//
//  Request.swift
//  myRace.core
//
//  Created by Yanbo Dang on 12/7/2023.
//

import Foundation
import Alamofire

protocol Parcalable {
    func toParameters() -> Parameters
}

public struct Request {
    var url: String
    var params: Parameters?
    var method: Alamofire.HTTPMethod = .get
    
    init(url: String, params: Parcalable?, method: Alamofire.HTTPMethod = .get) {
        self.url = url
        self.params = params?.toParameters()
        self.method = method
    }
}
