//
//  InfoVC.swift
//  
//
//  Created by 이현욱 on 19/09/2019.
//

import UIKit

class InfoVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortBtn: RoundAndShadowButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarTitleView()
        performSegue(withIdentifier: "InfoToDetail", sender: nil)
    }

}


    


