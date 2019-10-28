//
//  AShowInMotionCollectionViewCell.swift
//  S2oul
//
//  Created by baby1234 on 23/09/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit

import Kingfisher

class AShowInMotionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var showImgView: RoundImageView!
    @IBOutlet weak var showNameLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(info: SimpleShowInfo) {
        showImgView.kf.setImage(with: URL(string: info.showImage))
        showNameLbl.text = info.showName
    }

}
