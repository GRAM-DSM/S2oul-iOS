//
//  InfoShowTableViewCell.swift
//  S2oul
//
//  Created by baby1234 on 22/09/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit

class InfoShowTableViewCell: UITableViewCell {

    @IBOutlet weak var showImgView: RoundImageView!
    @IBOutlet weak var showNameLbl: UILabel!
    @IBOutlet weak var showPeriodLbl: UILabel!
    @IBOutlet weak var theaterNameLbl: UILabel!
    @IBOutlet weak var showAgeLbl: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(data: ShowInfo) {
        self.showImgView.kf.setImage(with: URL(string: data.showImage))
        self.showNameLbl.text = data.showName
        self.showPeriodLbl.text = data.period
        self.theaterNameLbl.text = data.theaterName
        self.showAgeLbl.text = data.showImage
    }
    
}
