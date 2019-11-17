//
//  SearchShowInfoModel.swift
//  S2oul
//
//  Created by 이현욱 on 2019/10/11.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation

struct SearchShowInfo: Codable {
    let showName: String
    let theaterName: String
    let genre: String
    let age: String
    let showId: Int
}

struct SearchTheaterInfo: Codable {
    let theaterName: String
    let location: String
    let phoneNumber: String
    let theaterId: Int
}
