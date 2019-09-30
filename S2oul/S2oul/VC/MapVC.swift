//
//  MapVC.swift
//  S2oul
//
//  Created by baby1234 on 23/09/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit

class MapVC: UIViewController {

    @IBOutlet weak var mapView: Round22View!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarTitleView()
        tableView.backgroundColor = UIColor.white
    }

}
