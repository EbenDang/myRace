//
//  RaceViewModel.swift
//  myRace.core
//
//  Created by Yanbo Dang on 12/7/2023.
//

import Foundation

public protocol ViewModel {
    func initViewModel()
}

public class RaceViewModelImpl: BaseViewModel, ViewModel, SimpleDataSource, ObservableObject {
    public typealias ItemType = RaceSummaryItem
    
    private static let MaxNextRaceItemCount = 5
    
    
    private var raceThumb: RaceThumbModel?
    private var httpService: HttpService?
    
    public init(httpService: HttpService) {
        self.httpService = httpService;
    }
    
    public func initViewModel() {
        self.loadRaceItems()
    }
    
    // MARK: - SimpleDataSource
    public func getSectionCount() -> Int {
        return 1
    }
    
    public func getRowCount(sectionIndex: Int) -> Int {
        guard let model = self.raceThumb else {
            return 0
        }
        
        return max(model.raceSummeries.values.count, Self.MaxNextRaceItemCount)
    }
    
    public func getItem(sectionIndex: Int, rowIndex: Int) -> ItemType? {
        
        guard let models = self.raceThumb?.raceSummeries.map({ $0.1 }),
              models.validIndex(index: rowIndex) else {
            return nil;
        }
        
        return models[rowIndex]
    }
    
    // MARK: - Private functions
    private static func getRequest(method: String, count: Int) -> Request {
        var queryItems = UrlQueryItems()
        queryItems.addQueryItem(name: "method", value: method)
        queryItems.addQueryItem(name: "count", value: count)
    
        return Request(url: ApiEndPoint.raceEndPoint, params: queryItems)
    }
    
    private func loadRaceItems() {
        let request = Self.getRequest(method: "nextraces", count: Constants.pageSize)
        self.httpService?.request(request: request, completion: { [weak self] (result: Result<Response<RaceThumbModel>, EnError>) in
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
        
        // TODO: sort
        
        self.raceThumb = model
    }
    
}
