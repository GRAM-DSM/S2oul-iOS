//
//  InfoTheaterTableViewCell.swift
//  S2oul
//
//  Created by baby1234 on 22/09/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit

class InfoTheaterTableViewCell: UITableViewCell {

    @IBOutlet weak var theaterNameLbl: UILabel!
    @IBOutlet weak var theaterPhoneNumberLbl: UILabel!
    @IBOutlet weak var theaterLocationLbl: UILabel!
    @IBOutlet weak var theaterImgView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
