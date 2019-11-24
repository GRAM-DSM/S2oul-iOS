//
//  DummyData.swift
//  S2oul_iPad
//
//  Created by baby1234 on 2019/11/16.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation
import UIKit

class Dummy {
    static let shared = Dummy()

    var shows = [ShowInfo]()
    var theaters = [TheaterInfo]()
    var showDetails = [ShowDetailInfo]()
    var theaterDetails = [TheaterDetailInfo]()
    var summaryImgs = [UIImage]()

    private init() {

        for i in 0..<10 {
            if let summaryImg = UIImage(contentsOfFile: "/Users/baby1234/Documents/GitHub/S2oul-iOS/S2oul_iPad/S2oul_iPad/Resource/\(i).jpg") {
                summaryImgs.append(summaryImg)
            } else {
                print("image fail")
            }
        }

        if let shows = Bundle.main.url(forResource: "Show", withExtension: "json") {
            guard let data = try? Data(contentsOf: shows),
                let json = try? JSONDecoder().decode([ShowInfo].self, from: data) else { return }
            self.shows = json
        } else { print("shows fail") }

        if let theaters = Bundle.main.url(forResource: "Theater", withExtension: "json") {
            guard let data = try? Data(contentsOf: theaters),
                let json = try? JSONDecoder().decode([TheaterInfo].self, from: data) else { return }
            self.theaters = json
        } else { print("theaters fail") }

        if let showDetails = Bundle.main.url(forResource: "ShowDetails", withExtension: "json") {
            guard let data = try? Data(contentsOf: showDetails),
                let json = try? JSONDecoder().decode([ShowDetailInfo].self, from: data)  else { print("showDetails fail"); return }
            self.showDetails = json
        } else { print("showDetails fail") }

        if let theaterDetails = Bundle.main.url(forResource: "TheaterDetails", withExtension: "json") {
            guard let data = try? Data(contentsOf: theaterDetails),
                let json = try? JSONDecoder().decode([TheaterDetailInfo].self, from: data) else { print("theaterDetails fail"); return }
            self.theaterDetails = json
        } else { print("theaterDetails fail") }
    }
}
