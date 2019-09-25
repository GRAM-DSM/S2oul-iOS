//
//  DetailVC.swift
//  S2oul
//
//  Created by baby1234 on 23/09/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    @IBOutlet weak var detailView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarTitleView()
        let vc = storyboard?.instantiateViewController(identifier: "ShowDetailVC") as! ShowDetailVC
        detailView.addSubview(vc.view)
    }

}
