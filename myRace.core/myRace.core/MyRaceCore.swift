//
//  MyRaceCore.swift
//  myRace.core
//
//  Created by Yanbo Dang on 13/7/2023.
//

import Foundation

open class MyRaceCore {
    
    private static let serviceLocator = ServiceLocatorImpl.shareInstance()
    
    public static func initMyRaceCore() {
        self.registerServices()
    }
    
    public static func getServiceLocator() -> ServiceLocator {
        return Self.serviceLocator
    }

    private static func registerServices() {
        var httpService: HttpService = HttpServiceImpl()
        Self.serviceLocator.register(instance: httpService)
    }
    
}
