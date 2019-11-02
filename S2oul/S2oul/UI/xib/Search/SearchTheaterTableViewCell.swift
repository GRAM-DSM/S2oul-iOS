//
//  SearchTheaterTableViewCell.swift
//  S2oul
//
//  Created by baby1234 on 21/09/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit

class SearchTheaterTableViewCell: UITableViewCell {

    @IBOutlet weak var theaterNameLbl: UILabel!
    @IBOutlet weak var theaterDistanceLbl: UILabel!
    @IBOutlet weak var theaterLocationLbl: UILabel!
    @IBOutlet weak var theaterPhoneNumberLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(info: SearchTheaterInfo) {
        theaterNameLbl.text = info.theaterName
        theaterLocationLbl.text = info.location
        theaterPhoneNumberLbl.text = info.phoneNumber
    }
    
}
