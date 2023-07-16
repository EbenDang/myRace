//
//  RaceFilterViewModel.swift
//  myRace.core
//
//  Created by Yanbo Dang on 16/7/2023.
//

import Foundation

public class RaceFilterViewModel: BaseViewModel, ViewModel, ObservableObject {
    
    @Published public private(set) var selFilters: [RaceFilterModel] = []
    @Published public private(set) var filters: [RaceFilterModel] = []
    
    private var existedFilters:[RaceFilterModel] = []
    
    
    public override init() {
        super.init()
    }
    
    public init(existedFilters: [RaceFilterModel]) {
        self.existedFilters = existedFilters
        super.init()
    }
    
    public func initViewModel() {
        self.filters.removeAll()
        self.filters.append(RaceFilterModel(id: "9daef0d7-bf3c-4f50-921d-8e818c60fe61", filteName: "Greyhound", selected: false))
        self.filters.append(RaceFilterModel(id: "161d9be2-e909-4326-8c2c-35ed71fb460b", filteName: "Harness", selected: false))
        self.filters.append(RaceFilterModel(id: "4a2788f8-e825-4d36-9894-efd4baf1cfae", filteName: "Horse", selected: false))
        
        self.existedFilters.forEach { item in
            guard let index = self.filters.firstIndex(where: {$0.id == item.id}) else {
                return
            }
            
            if index != -1 {
                var filterItem = self.filters[index]
                filterItem.selFilter(true)
                self.filters[index] = filterItem
            }
        }
    }
    
    // MARK: - Public functions
    public func selFilter(filterIndex: Int, selected: Bool) -> RaceFilterModel? {
        guard self.filters.validIndex(index: filterIndex) else {
            return nil
        }
        
        var filterModel = self.filters[filterIndex]
        filterModel.selFilter(selected)
        self.filters[filterIndex] = filterModel
        self.selFilters = self.getSelectedFilters()
        return filterModel
    }
    
    public func selFilter(filter: RaceFilterModel, selected: Bool) -> RaceFilterModel? {
        guard let filterIndex = self.filters.firstIndex(where: {$0.id == filter.id}) else {
            return nil
        }
        
        var filterModel = self.filters[filterIndex]
        filterModel.selFilter(selected)
        self.filters[filterIndex] = filterModel
        print(self.filters)
        self.selFilters = self.getSelectedFilters()
        return filterModel
    }
    
    public func getSelectedFilters() -> [RaceFilterModel] {
        return self.filters.filter { $0.selected }
    }
    
    public func getFilters() -> [RaceFilterModel] {
        return self.filters
    }
    
    public func getFilterByIndex(index: Int) -> RaceFilterModel?{
        guard self.filters.validIndex(index: index) else {
            return nil
        }
        return self.filters[index]
    }
    
}
