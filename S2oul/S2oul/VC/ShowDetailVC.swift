//
//  ShowDetailVC.swift
//  S2oul
//
//  Created by baby1234 on 23/09/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit

class ShowDetailVC: UIViewController {

    @IBOutlet weak var showImgView: RoundImageView!
    @IBOutlet weak var showNameLbl: UILabel!
    @IBOutlet weak var showPeriodLbl: UILabel!
    @IBOutlet weak var showAgeLbl: UILabel!
    @IBOutlet weak var showPriceLbl: UILabel!
    @IBOutlet weak var theaterNameLbl: UILabel!
    @IBOutlet weak var runningTimeLbl: UILabel!

    @IBOutlet weak var summaryImgView: UIImageView!

    @IBOutlet weak var theaterName: UILabel!
    @IBOutlet weak var theaterDistance: UILabel!
    @IBOutlet weak var theaterLocation: UILabel!
    @IBOutlet weak var theaterPhoneNumber: UILabel!
    @IBOutlet weak var theaterImgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarTitleView()
    }

}
