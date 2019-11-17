//
//  ShowTableViewCell.swift
//  S2oul
//
//  Created by baby1234 on 21/09/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit

class SearchShowTableViewCell: UITableViewCell {
    @IBOutlet weak var showNameLbl: UILabel!
    @IBOutlet weak var theaterNameLbl: UILabel!
    @IBOutlet weak var periodAndShowAgeLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(info: ShowInfo) {
        showNameLbl.text = info.showName
        theaterNameLbl.text = info.theaterName
        periodAndShowAgeLbl.text = info.period + " / " + info.showAge
    }
    
}
