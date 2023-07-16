//
//  RaceFilterView.swift
//  myRace.swiftui
//
//  Created by Yanbo Dang on 16/7/2023.
//

import SwiftUI
import myRace_core

struct RaceFilterView: View {
    @ObservedObject private var viewModel: RaceFilterViewModel
    
    var body: some View {
        VStack {
            NavigationStack {
                List {
                    ForEach(viewModel.getFilters()) { filter in
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
    }
    
    init(viewModel: RaceFilterViewModel) {
        self.viewModel = viewModel
        self.viewModel.initViewModel()
    }
    
    private func didFilterTouched(filter: RaceFilterModel) {
        _ = self.viewModel.selFilter(filter: filter, selected: !filter.selected)
    }
    
}

struct RaceFilterView_Previews: PreviewProvider {
    static var previews: some View {
        RaceFilterView(viewModel: RaceFilterViewModel())
    }
}
