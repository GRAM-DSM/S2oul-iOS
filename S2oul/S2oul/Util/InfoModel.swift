//
//  ShowInfo.swift
//  S2oul
//
//  Created by 이현욱 on 2019/10/11.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation

struct ShowInfo : Codable {
    let showImage : String
    let showName : String
    let period : String
    let theaterName : String
    let showAge : String
    let showId : String
}

struct TheaterInfo : Codable {
    let theaterImage : String
    let theaterName : String
    let phoneNumber : String
    let location : String
    let theaterId : String
}
