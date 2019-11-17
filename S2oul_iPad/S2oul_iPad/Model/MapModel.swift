//
//  MapModel.swift
//  S2oul_iPad
//
//  Created by baby1234 on 2019/11/16.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation

struct AroundTheaterInfo: Codable {
    let theaterImage: String
    let theaterName: String
    let location: String
    let latitude: Double
    let longitude: Double
    let phoneNumber: String
    let theaterId: Int
}
