//
//  Genre.swift
//  S2oul
//
//  Created by 이현욱 on 2019/10/11.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation

enum Genre: String {
    case all
    case play
    case musical
    case concertAndShow
    case childAndFamily

    func getIndex() -> Int {
        switch self {
        case .all: return 0
        case .play: return 1
        case .musical: return 2
        case .concertAndShow: return 3
        case .childAndFamily: return 4
        }
    }

    static func getGenre(index: Int) -> Self {
        switch index {
        case 0: return .all
        case 1: return .play
        case 2: return .musical
        case 3: return .concertAndShow
        case 4: return .childAndFamily
        default: return .all
        }
    }
}

enum Sort: String {
    case alphabetical
    case endDate

    func getIndex() -> Int {
        switch self {
        case .alphabetical: return 0
        case .endDate: return 1
        }
    }

    static func getGenre(index: Int) -> Self {
        switch index {
        case 0: return .alphabetical
        case 1: return .endDate
        default: return .alphabetical
        }
    }
}
