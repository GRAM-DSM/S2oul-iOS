//
//  SearchTheaterTableViewCell.swift
//  S2oul
//
//  Created by baby1234 on 21/09/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit

class SearchTheaterTableViewCell: UITableViewCell {

    @IBOutlet weak var theaterName: UILabel!
    @IBOutlet weak var theaterDistance: UILabel!
    @IBOutlet weak var theaterLocation: UILabel!
    @IBOutlet weak var theaterTel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
