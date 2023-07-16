//
//  RaceFilterView.swift
//  myRace.swiftui
//
//  Created by Yanbo Dang on 16/7/2023.
//

import SwiftUI
import Combine
import myRace_core

struct RaceFilterView: View {
    
    @StateObject var viewModel: RaceFilterViewModel
    @State var cancellables: Set<AnyCancellable> = []
    @State private var viewDidLoad = false
    @State private var filters: [RaceFilterModel] = []
    @Binding var selFilters: [RaceFilterModel]
    
    var body: some View {
        VStack {
            NavigationStack {
                List {
                    ForEach(filters) { filter in
                        HStack {
                            Button {
                                self.didFilterTouched(filter: filter)
                            } label: {
                                HStack {
                                    Text(filter.filteName)
                                    if filter.selected {
                                        Spacer()
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            if !viewDidLoad {
                self.viewDidLoad = true
                self.viewModel.initViewModel()
                self.viewModel.$filters
                    .receive(on: RunLoop.main)
                    .sink { filters in
                        self.filters = filters
                    }.store(in: &self.cancellables)
                
                self.viewModel.$selFilters
                    .receive(on: RunLoop.main)
                    .sink { filters in
                        self.selFilters = filters
                    }.store(in: &self.cancellables)
            }

        }
    }

    
    private func didFilterTouched(filter: RaceFilterModel) {
        _ = self.viewModel.selFilter(filter: filter, selected: !filter.selected)
    }
    
}

struct RaceFilterView_Previews: PreviewProvider {
    static var previews: some View {
        //RaceFilterView(viewModel: RaceFilterViewModel())
        let selFitler: [RaceFilterModel] = []
        RaceFilterView(viewModel: RaceFilterViewModel(), selFilters: .constant(selFitler))
    }
}
