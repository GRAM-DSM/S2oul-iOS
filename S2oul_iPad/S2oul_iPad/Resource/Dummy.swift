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
    var summaryImages = [UIImage]()

    private init() {
        for i in 0..<3 {
            if let img = UIImage(named: "\(i).jpg") {
                summaryImages.append(img)
            }
        }

        if let shows = Bundle.main.url(forResource: "Shows", withExtension: "json") {
            guard let data = try? Data(contentsOf: shows),
                let json = try? JSONDecoder().decode([ShowInfo].self, from: data) else { return }
            self.shows = json
        } else { print("shows fail") }

        if let theaters = Bundle.main.url(forResource: "Theaters", withExtension: "json") {
            guard let data = try? Data(contentsOf: theaters),
                let json = try? JSONDecoder().decode([TheaterInfo].self, from: data) else { return }
            self.theaters = json
        } else { print("theaters fail") }

        if let showDetails = Bundle.main.url(forResource: "ShowDetails", withExtension: "json") {
            guard let data = try? Data(contentsOf: showDetails),
                let json = try? JSONDecoder().decode([ShowDetailInfo].self, from: data)  else { print("showDetails fail"); return }
            self.showDetails = json
        }

        if let theaterDetails = Bundle.main.url(forResource: "TheaterDetails", withExtension: "json") {
            guard let data = try? Data(contentsOf: theaterDetails),
                let json = try? JSONDecoder().decode([TheaterDetailInfo].self, from: data) else { print("theaterDetails fail"); return }
            self.theaterDetails = json
        }
    }
}
