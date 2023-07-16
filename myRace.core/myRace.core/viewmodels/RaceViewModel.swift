//
//  RaceViewModel.swift
//  myRace.core
//
//  Created by Yanbo Dang on 12/7/2023.
//

import Foundation
import Combine

public protocol ViewModel {
    func initViewModel()
}

public class RaceViewModel: BaseViewModel, ViewModel, SimpleDataSource, ObservableObject {
    public typealias ItemType = RaceSummaryItem
    
    private static let MaxNextRaceItemCount = 5
    private static let RefreshNextRoundTimeInterval: TimeInterval = 60 // 60 seconds
    private static let RefreshTimeInterval: TimeInterval = 1 // 1 second
    
    @Published public var isLoading: Bool = false
    @Published public var refreshedDate: Date = Date.now
    
    private var publisherRefresh: Timer.TimerPublisher
    private var queue: DispatchQueue
    private var cancellableNextRoundRaces: Cancellable?
    private var httpService: HttpService?
    private var allOfRaceItems: [RaceSummaryItem] = []
    private var nextRaceItems: [RaceSummaryItem] = []
    private var filters: [RaceFilterModel] = []
    
    public init(httpService: HttpService) {
        self.httpService = httpService;
        self.queue = DispatchQueue(label: "com.entain.app.race.queue.race")
        self.publisherRefresh = Timer.publish(every: Self.RefreshTimeInterval, on: .main, in: .common)
    }
    
    public func initViewModel() {
        self.loadRaceItems()
    }
    
    public func setFilters(filters: [RaceFilterModel]) {
        self.filters = filters
    }
    
    public func getFitlers() -> [RaceFilterModel] {
        return self.filters
    }
    
    // MARK: - SimpleDataSource
    public func getSectionCount() -> Int {
        return 1
    }
    
    public func getRowCount(sectionIndex: Int) -> Int {
        return self.nextRaceItems.count
    }
    
    public func getItem(sectionIndex: Int, rowIndex: Int) -> ItemType? {
        guard self.nextRaceItems.validIndex(index: rowIndex) else {
            return nil
        }
        return self.nextRaceItems[rowIndex]
    }
    
    // MARK: - Private functions
    private static func getRequest(method: String, count: Int) -> Request {
        var queryItems = UrlQueryItems()
        queryItems.addQueryItem(name: "method", value: method)
        queryItems.addQueryItem(name: "count", value: count)
    
        return Request(url: ApiEndPoint.raceEndPoint, params: queryItems)
    }
    
    private func loadRaceItems() {
        self.isLoading = true
        let request = Self.getRequest(method: "nextraces", count: Constants.pageSize)
        self.httpService?.request(request: request, completion: { [weak self] (result: Result<Response<RaceThumbModel>, EnError>) in
            self?.isLoading = false
            switch result {
            case .success(let response):
                self?.onReaceItemLoaded(response)
            case .failure(let error):
                self?.handelError(error: error)
            }
        })
    }
    
    private func onReaceItemLoaded(_ response: Response<RaceThumbModel>) {
        guard response.status == 200,
              let model = response.data else {
            self.handelError(error: .invalidResData)
            return
        }
        
        var tmp = Array(self.allOfRaceItems)
        tmp.append(contentsOf: model.raceSummeries.values)
        
        self.allOfRaceItems.append(contentsOf: tmp.sorted{$0.advertisedStart.seconds < $1.advertisedStart.seconds})
        
        self.printRaceItems(raceItem: self.allOfRaceItems, message: "allOfRaceItems")
        
        self.fillNextRoundRacesIfNeeded()
        
        self.triggeNextRoundPublisherIfNeeded()
    }
    
    private func triggeNextRoundPublisherIfNeeded() {
        if self.cancellableNextRoundRaces != nil {
            return // timer started already
        }
        
        self.cancellableNextRoundRaces = self.publisherRefresh
            .autoconnect()
            .receive(on: self.queue)
            .sink(receiveValue: { [weak self] date in
                self?.onTimer(date)
            })
    }
    
    private func fillNextRoundRacesIfNeeded() {

        var allRaceItems: [RaceSummaryItem] = []
        if !self.filters.isEmpty {
            allRaceItems = self.applyFilter(raceItems: self.allOfRaceItems, filters: self.filters)
        } else {
            allRaceItems = self.allOfRaceItems
        }
        
        self.nextRaceItems.removeAll()
        let availableCount = min(allRaceItems.count, Self.MaxNextRaceItemCount)
        
        let raceItems = allRaceItems[0..<availableCount]
        self.nextRaceItems.append(contentsOf: raceItems)
        
        self.printRaceItems(raceItem: self.nextRaceItems, message: "nextRaceItems")
        self.printRaceItems(raceItem: self.allOfRaceItems, message: "allOfRaceItems after fill")
    }
    
    private func applyFilter(raceItems: [RaceSummaryItem], filters: [RaceFilterModel]) -> [RaceSummaryItem] {
        let filteredItems = raceItems.filter { raceItem in
            return filters.contains { filter in
                filter.filterId == raceItem.categoryId
            }
        }
        
        return filteredItems
    }
    
    @objc private func onTimer(_ date: Date) {
        let currentTimeInterval = date.timeIntervalSince1970
        
        self.allOfRaceItems.removeAll { item in
            currentTimeInterval - item.advertisedStart.seconds > Self.RefreshNextRoundTimeInterval
        }
        
        self.nextRaceItems.removeAll { item in
            currentTimeInterval - item.advertisedStart.seconds > Self.RefreshNextRoundTimeInterval
        }
        
        self.fillNextRoundRacesIfNeeded()
        if self.allOfRaceItems.count <= Self.MaxNextRaceItemCount {
            self.loadRaceItems()
        }
        
        self.refreshedDate = date
    }
    
    private func printRaceItems(raceItem: [RaceSummaryItem], message: String) {
        print("\n\n************* \(message) (\(raceItem.count)) **************")
        raceItem.forEach { item in
            let strTime = Utils.formatFromTimeInterval(timeInterval: item.advertisedStart.seconds, dateFormat: Constants.defaultDateFormat)
            print("\(item.meetingName)          start: \(strTime)")
        }
        
        print("******************************************")
    }
    
}
