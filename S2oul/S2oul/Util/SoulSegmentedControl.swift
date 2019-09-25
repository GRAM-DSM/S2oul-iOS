//
//  SoulSegmentedControl.swift
//  S2oul
//
//  Created by baby1234 on 23/09/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit

class SoulSegmentedControl: UISegmentedControl {

    override func awakeFromNib() {
        let selectedAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let normalAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkGray]

        self.setTitleTextAttributes(selectedAttributes, for: .selected)
        self.setTitleTextAttributes(normalAttributes, for:  .normal)
    }
}
