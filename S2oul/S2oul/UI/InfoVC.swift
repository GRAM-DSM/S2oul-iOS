//
//  InfoVC.swift
//  
//
//  Created by 이현욱 on 19/09/2019.
//

import UIKit
import Alamofire
import Kingfisher

class InfoVC : UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortBtn: RoundAndShadowButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    private let httpClient = HTTPClient()
    var showInfoArr = [ShowInfo]()
    var theaterInfoArr = [TheaterInfo]()
    var sortIndex = 0
    var filterGenre = Genre.all

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarTitleView()
        tableView.backgroundColor = UIColor.white
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SortAndGenreVC {
            vc.delegate = self
        }
    }
    
    @IBAction func showOrTheaterSegmented(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            if  {
                
            }
            
        } else {
            if {
                
            }
            
        }
    }
    

}

extension InfoVC : SortAndGenreDelegate {
    func getSortIndex(result: Int) {
        sortIndex = result
    }
    
    func getFilterGenre(result: Genre) {
        filterGenre = result
    }
}

extension InfoVC : InfoAPIProvider {
    
    func getShowEndDateInfo(genre: Genre) {
        httpClient.get(url: SoulURL.showEndDate(genre: genre.rawValue).getPath())
            .responseData { (data) in
                guard let data = data.data, let response = try? JSONDecoder().decode([ShowInfo].self, from: data) else { return }
                DispatchQueue.main.async {
                    self.showInfoArr = response
                    self.tableView.reloadData()
                }
            }
    }
    
    func getShowAlphabetInfo(genre: Genre) {
        httpClient.get(url: SoulURL.showAlphabet(genre: genre.rawValue).getPath())
            .responseData { (data) in
                guard let data = data.data, let response = try? JSONDecoder().decode([ShowInfo].self, from: data) else {
            return }
                DispatchQueue.main.async {
                    self.showInfoArr = response
                    self.tableView.reloadData()
                }
        }
    }
    
    func getTheaterAlphabetInfo(genre: Genre) {
        httpClient.get(url: SoulURL.theaterAlphabet(genre: genre.rawValue).getPath())
            .responseData { (data) in
                guard let data = data.data, let response = try? JSONDecoder().decode([TheaterInfo].self, from: data) else { return }
                    DispatchQueue.main.async {
                        self.theaterInfoArr = response
                        self.tableView.reloadData()
                    }
            }
    }
    
}

extension InfoVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return showInfoArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoShowTableViewCell") as! InfoShowTableViewCell
            let data = showInfoArr[indexPath.row]
            cell.showAgeLbl.text = data.showAge
            cell.theaterNameLbl.text = data.theaterName
            cell.showPeriodLbl.text = data.period
            cell.imageView?.kf.setImage(with: URL(string: data.showImage))
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTheaterTableViewCell") as! InfoTheaterTableViewCell
            let data = theaterInfoArr[indexPath.row]
            cell.theaterNameLbl.text = data.theaterName
            cell.theaterPhoneNumberLbl.text = data.phoneNumber
            cell.theaterLocationLbl.text = data.location
            cell.imageView?.kf.setImage(with: URL(string: data.theaterImage))
            return cell
        }
        
    }
}

    


