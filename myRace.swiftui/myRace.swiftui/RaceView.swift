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

    @State var cancellables: Set<AnyCancellable> = []
    @State var raceItems: [RaceSummaryItem] = []
    @State private var viewDidLoad = false
    @State private var selFilters: [RaceFilterModel] = []
    
    private var serviceLocator: any ServiceLocator
    private var viewModel: RaceViewModel
    
    var body: some View {
        VStack {
            NavigationStack {
                RaceListView(raceItems: $raceItems)
                .navigationTitle("Races")
                .toolbar {
                    NavigationLink {
                        RaceFilterView(viewModel: RaceFilterViewModel(existedFilters: selFilters), selFilters: $selFilters)
                            .navigationTitle("Race filters")
                            .onChange(of: selFilters) { newValue in
                                //print(selFilters)
                                self.viewModel.setFilters(filters: newValue)
                            }
                    } label: {
                        Text("Filter")
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .padding()
        .onAppear {
            print("dddd")
            if !viewDidLoad {
                viewDidLoad = true
                self.selFilters = self.viewModel.getFitlers()
                self.viewModel.$refreshedDate
                    .receive(on: RunLoop.main)
                    .sink { _  in
                        raceItems = self.viewModel.nextRaceItems
                    }.store(in: &self.cancellables)
            }
        }
    }
    
    init(serviceLocator: any ServiceLocator) {
        self.serviceLocator = serviceLocator
        let httpService: HttpService? = self.serviceLocator.resolve()
        self.viewModel = RaceViewModel(httpService: httpService!)
        self.viewModel.initViewModel()
    }
}

struct RaceListView: View {
    @Binding var raceItems: [RaceSummaryItem]
    
    var body: some View {
        VStack {
            List(raceItems) {item in
                HStack {
                    Text("\(item.meetingName)")
                    Spacer()
                    Spacer()
                    Text("\(item.raceNum)")
                    Spacer()
                    Text("\(self.getCountingDown(item.advertisedStart.seconds))")
                }
            }
        }
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
