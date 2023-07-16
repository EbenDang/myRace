//
//  RaceView.swift
//  myRace.swiftui
//
//  Created by Yanbo Dang on 12/7/2023.
//

import SwiftUI
import Combine
import myRace_core

struct RaceView: View {
    
    private var serviceLocator: any ServiceLocator
    private var cancellables: Set<AnyCancellable> = []
    @ObservedObject private var viewModel: RaceViewModel
    
    var body: some View {
        VStack {
            NavigationStack {
                List(viewModel.nextRaceItems) {item in
                    HStack {
                        Text("\(item.meetingName)")
                        Spacer()
                        Spacer()
                        Text("\(item.raceNum)")
                        Spacer()
                        Text("\(self.getCountingDown(item.advertisedStart.seconds))")
                    }
                }
                .navigationTitle("Races")
                .toolbar {
                    NavigationLink(destination: RaceFilterView()) {
                        Text("Filter")
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .padding()
    }
    
    init(serviceLocator: any ServiceLocator) {
        self.serviceLocator = serviceLocator
        let httpService: HttpService? = self.serviceLocator.resolve()
        self.viewModel = RaceViewModel(httpService: httpService!)
        self.viewModel.initViewModel()
    }
    
    private func getCountingDown(_ timeInterval: TimeInterval) -> String {
        let currentTimeInterval = Date.now.timeIntervalSince1970
        let timeInterval = Int(timeInterval - currentTimeInterval)
        
        let seconds = timeInterval % 60
        let mins = (timeInterval / 60) % 60
        
        if mins == 0 {
            return "\(seconds)s"
        }
        
        return "\(mins)m\(seconds)s"
    }
}

struct RaceView_Previews: PreviewProvider {
    static var previews: some View {
        RaceView(serviceLocator: MyRaceCore.getServiceLocator())
    }
}
