//
//  RaceThumbModel.swift
//  myRace.core
//
//  Created by Yanbo Dang on 12/7/2023.
//

import Foundation

public struct RaceThumbModel: Model, Decodable {
    let nextIds:[String]
    let raceSummeries: [String: RaceSummaryItem]
    
    enum CodingKeys: String, CodingKey {
        case nextIds = "next_to_go_ids"
        case raceSummeries = "race_summaries"
    }
    
}

public struct RaceSummaryItem: Model, Decodable, Identifiable {
    
    public let id: String
    public let raceName: String?
    public let raceNum: Int
    public let meetingId: String
    public let meetingName: String
    public let categoryId: String
    public let advertisedStart: Advertised
    
    enum CodingKeys: String, CodingKey {
        case id = "race_id"
        case raceName = "race_name"
        case raceNum = "race_number"
        case meetingId = "meeting_id"
        case meetingName = "meeting_name"
        case categoryId = "category_id"
        case advertisedStart = "advertised_start"
    }
}


public struct Advertised: Decodable {
    public let seconds: Double
}
