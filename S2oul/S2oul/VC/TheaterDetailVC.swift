//
//  TheaterDetailVC.swift
//  S2oul
//
//  Created by baby1234 on 23/09/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit

class TheaterDetailVC: UIViewController {

    @IBOutlet weak var theaterImgView: RoundImageView!
    @IBOutlet weak var theaterNameLbl: UILabel!
    @IBOutlet weak var theaterPhoneNumberLbl: UILabel!
    @IBOutlet weak var theaterLocation: UILabel!
    @IBOutlet weak var numberOfSeatsLbl: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBarTitleView()
    }

}
