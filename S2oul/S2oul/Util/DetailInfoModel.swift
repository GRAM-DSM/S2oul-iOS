//
//  DetailInfo.swift
//  S2oul
//
//  Created by 이현욱 on 2019/10/11.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation

struct ShowDetailInfo : Codable {
    let showImage : String
    let summaryImage : String
    let theaterImage : String
    let showName : String
    let period : String
    let cost : String
    let runningTime : String
    let link : String
    let theaterName : String
    let location : String
    let phoneNumber : String
    let theaterId : String
}

struct TheaterDetailInfo : Codable {
    let theaterImage : String
    let theaterName : String
    let phoneNumber : String
    let location : String
    let seatNumber : String
    let shows : [SimpleShowInfo]
}

struct SimpleShowInfo : Codable {
    let showImage : String
    let showName : String
    let showId : String
}
