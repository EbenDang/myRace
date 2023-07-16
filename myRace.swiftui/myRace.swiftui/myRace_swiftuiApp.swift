//
//  myRace_swiftuiApp.swift
//  myRace.swiftui
//
//  Created by Yanbo Dang on 12/7/2023.
//

import SwiftUI
import myRace_core

@main
struct myRace_swiftuiApp: App {
    private let serviceLocator = MyRaceCore.getServiceLocator()
    
    var body: some Scene {
        WindowGroup {
            RaceView(serviceLocator: self.serviceLocator)
        }
    }
    
    init() {
        MyRaceCore.initMyRaceCore()
    }
}
