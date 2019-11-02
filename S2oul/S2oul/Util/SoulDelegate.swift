//
//  SoulDelegate.swift
//  S2oul
//
//  Created by 이현욱 on 2019/10/22.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation

protocol SortAndGenreDelegate {
    func getSortIndexAndFilterGenre(sort: Sort, genre: Genre)
}

protocol DetailInfoDelegate {
    func getId(id: String)
}
