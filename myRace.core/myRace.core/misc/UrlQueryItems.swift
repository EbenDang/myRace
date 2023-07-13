//
//  QueryItems.swift
//  myRace.core
//
//  Created by Yanbo Dang on 13/7/2023.
//

import Foundation
import Alamofire

struct UrlQueryItems: Parcalable {
    private var item: [String: Any] = [:]
    
    mutating func addQueryItem(name: String, value: Any) {
        self.item[name] = value
    }
    
    func toParameters() -> Parameters {
        return item
    }
}
