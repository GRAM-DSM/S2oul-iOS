//
//  Shape.swift
//  S2oul
//
//  Created by 이현욱 on 19/09/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import Foundation
import UIKit

final class RoundButton: UIButton {
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height / 2
    }
}

final class Round22View: UIView {
    override func awakeFromNib() {
        self.layer.cornerRadius = 22
    }
}
