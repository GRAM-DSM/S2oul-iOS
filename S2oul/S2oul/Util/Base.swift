//
//  Base.swift
//  S2oul
//
//  Created by baby1234 on 23/09/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit
import Toaster

extension UIViewController {
    func configureNavigationBarTitleView() {
        let imgView = UIImageView(image: UIImage(named: "logo.png"))
        let maskLayer = CAGradientLayer()
        maskLayer.frame = imgView.bounds
        maskLayer.shadowRadius = 5
        maskLayer.shadowPath = CGPath(roundedRect: imgView.bounds.insetBy(dx: 5, dy: 5), cornerWidth: 10, cornerHeight: 10, transform: nil)
        maskLayer.shadowOpacity = 1
        maskLayer.shadowOffset = CGSize.zero
        maskLayer.shadowColor = UIColor.white.cgColor
        imgView.layer.mask = maskLayer

        self.navigationItem.titleView = imgView
    }

    func showToast(message: String) {
        Toast(text: message).show()
    }
}
