//
//  InfoVC.swift
//  
//
//  Created by 이현욱 on 19/09/2019.
//

import UIKit
import Foundation


class InfoVC: UIViewController {
    
    @IBOutlet weak var showBtn: UIButton!
    @IBOutlet weak var theaterBtn: UIButton!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func whenTouchedShowBtn(_ sender: UIButton) {
    theaterBtn.backgroundColor = UIColor.white
    
    }
    @IBAction func whenTouchedTheaterBtn(_ sender: UIButton) {
        
    }
}


    


