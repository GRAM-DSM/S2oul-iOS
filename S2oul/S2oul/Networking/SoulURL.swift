//
//  URL.swift
//  S2oul
//
//  Created by 이현욱 on 11/10/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation

enum SoulURL {
    case showEndDate(genre: String)
    case showAlphabet(genre: String)
    case theaterAlphabet(genre: String)
    case detailInfoShow(showId: String)
    case detailInfoTheater(theaterId: String)
    case map(latAndLng: String)
    case searchShow(genre: String)
    case searchTheater(genre: String)
    
    func getPath() -> String {
        switch self {
        case .showEndDate(let genre):
            return "/Info/showEndDate/\(genre)"
        case .showAlphabet(let genre):
            return "/Info/showAlphabet/\(genre)"
        case .theaterAlphabet(let genre):
            return "/Info/theaterAlphabet/\(genre)"
        case .detailInfoShow(let showId):
            return "/detailInfo/show/showId\(showId)"
        case .detailInfoTheater(let theaterId):
            return "/detailInfo/theater/theaterId\(theaterId)"
        case .map(let latAndLng):
            return "/map/\(latAndLng)"
        case .searchShow(let genre):
            return "/searchShow/\(genre)"
        case .searchTheater(let genre):
            return "/searchTheater/\(genre)"
        }
    }
}
