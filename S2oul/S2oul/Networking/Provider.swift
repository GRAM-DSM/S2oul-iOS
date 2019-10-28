//
//  InfoAPI.swift
//  S2oul
//
//  Created by 이현욱 on 2019/10/11.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation

protocol InfoAPIProvider {
    func getShowEndDateInfo(genre: Genre)
    func getShowAlphabetInfo(genre: Genre)
    func getTheaterAlphabetInfo(genre: Genre)
}

protocol DetailShowInfoAPIProvider {
    func getShowDetailInfo(showId: String)
}

protocol DetailTheaterInfoAPIProvider {
    func getTheaterDetailInfo(theaterId: String)
}

protocol MapAPIProvider {
    func getMap(latAndLng: String)
}

protocol SearchAPIProvider {
    func searchShow(genre: Genre)
    func searchTheater(genre: Genre)
}
