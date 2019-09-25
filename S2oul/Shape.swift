//
//  Shape.swift
//  S2oul
//
//  Created by 이현욱 on 19/09/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit

final class RoundButton: UIButton {
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height / 2
    }
}

final class Round10Button: UIButton {
    override func awakeFromNib() {
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.seoul.cgColor
        self.layer.borderWidth = 1
    }
}

final class RoundAndShadowButton: UIButton {
    override func awakeFromNib() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.shadowOffset = CGSize(width: 6, height: 6)
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 4
    }
}

final class Round22View: UIView {
    override func awakeFromNib() {
        self.layer.cornerRadius = 22
    }
}

final class RoundImageView: UIImageView {
    override func awakeFromNib() {
        self.layer.cornerRadius = 10
    }
}
