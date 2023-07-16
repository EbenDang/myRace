//
//  MockHttpService.swift
//  myRace.core
//
//  Created by Yanbo Dang on 17/7/2023.
//

import Foundation

class MockHttpService: HttpService {
    
    func request<T>(request: Request, completion: @escaping (Result<Response<T>, EnError>) -> Void) where T : Decodable {
        if request.url != ApiEndPoint.raceEndPoint {
            return
        }
        
        let mockData = self.createMockRaceItemData()
        let response = Response(status: 200, message: "Success", data: mockData)
        // completion(.success(MockIncidentsDataSource().incidents as! T))
        completion(.success(response as! Response<T>))
    }
    
    private func createMockRaceItemData() -> RaceThumbModel {
        let nextIds = ["1", "2", "3"]
        var items: [String: RaceSummaryItem] = [:]
        var item = RaceSummaryItem(id: "1", raceName: nil, raceNum: 5, meetingId: "1", meetingName: "Mock Data1", categoryId: "", advertisedStart: Advertised(seconds: self.getAdvertisedData(timeInterval: 10)))
        items[item.id] = item
        
        item = RaceSummaryItem(id: "2", raceName: nil, raceNum: 3, meetingId: "2", meetingName: "Mock Data2", categoryId: "", advertisedStart: Advertised(seconds: self.getAdvertisedData(timeInterval: 50)))
        items[item.id] = item
        item = RaceSummaryItem(id: "3", raceName: nil, raceNum: 4, meetingId: "3", meetingName: "Mock Data3", categoryId: "", advertisedStart: Advertised(seconds: self.getAdvertisedData(timeInterval: 20)))
        items[item.id] = item
        
        return RaceThumbModel(nextIds: nextIds, raceSummeries: items)
    }
    
    private func getAdvertisedData(timeInterval: TimeInterval) -> TimeInterval {
        return Date.now.addingTimeInterval(timeInterval).timeIntervalSince1970
    }
}
