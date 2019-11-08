//
//  ShowDetailTheaterCell.swift
//  S2oul
//
//  Created by baby1234 on 2019/10/28.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit

import Kingfisher

class ShowDetailTheaterCell: UITableViewCell {

    @IBOutlet weak var theaterNameLbl: UILabel!
    @IBOutlet weak var theaterDistanceLbl: UILabel!
    @IBOutlet weak var theaterLocationLbl: UILabel!
    @IBOutlet weak var theaterPhoneNumberLbl: UILabel!
    @IBOutlet weak var theaterImgView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(info: ShowDetailInfo) {
        theaterNameLbl.text = info.theaterName
        theaterDistanceLbl.text = info.location
        theaterLocationLbl.text = info.location
        theaterPhoneNumberLbl.text = info.phoneNumber
        theaterImgView.kf.setImage(with: URL(string: info.theaterImage))
    }
}
