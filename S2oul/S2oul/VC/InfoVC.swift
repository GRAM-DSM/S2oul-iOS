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
    
    private var showInfoArr = [ShowInfo]()
    private var theaterInfoArr = [TheaterInfo]()
    private var sort = Sort.alphabetical
    private var genre = Genre.all
    
    var detailDelegate: DetailInfoDelegate?
    var genreDelegate: SortAndGenreDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarTitleView()
        tableView.backgroundColor = UIColor.white
        tableView.register(UINib(nibName: "InfoShowTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoShowTableViewCell")
        tableView.register(UINib(nibName: "InfoTheaterTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoTheaterTableViewCell")
        showOrTheaterSegmentedControlIsChanged(segmentedControl)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SortAndGenreVC {
            vc.delegate = self
            genreDelegate = vc
            genreDelegate?.getSortIndexAndFilterGenre(sort: sort, genre: genre)
        }
    }
    
    @IBAction func showOrTheaterSegmentedControlIsChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            switch sort {
            case .alphabetical:
                getShowAlphabetInfo()
            case .endDate:
                getShowEndDateInfo()
            }
            sortBtn.isHidden = false
        } else {
            getTheaterAlphabetInfo()
            sortBtn.isHidden = true
        }
    }
    
}

extension InfoVC : SortAndGenreDelegate {
    func getSortIndexAndFilterGenre(sort: Sort, genre: Genre) {
        self.sort = sort
        self.genre = genre
    }
}

extension InfoVC : InfoAPIProvider {
    func getShowEndDateInfo() {
        httpClient.get(url: SoulURL.showEndDate(genre: genre.rawValue).getPath())
            .responseData { (data) in
                guard let data = data.data, let response = try? JSONDecoder().decode([ShowInfo].self, from: data) else { return }
                DispatchQueue.main.async {
                    self.showInfoArr = response
                    self.tableView.reloadData()
                }
        }
    }
    
    func getShowAlphabetInfo() {
        httpClient.get(url: SoulURL.showAlphabet(genre: genre.rawValue).getPath())
            .responseData { (data) in
                guard let data = data.data, let response = try? JSONDecoder().decode([ShowInfo].self, from: data) else { return }
                DispatchQueue.main.async {
                    self.showInfoArr = response
                    self.tableView.reloadData()
                }
        }
    }
    
    func getTheaterAlphabetInfo() {
        httpClient.get(url: SoulURL.theaterAlphabet.getPath())
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return segmentedControl.selectedSegmentIndex == 0 ? showInfoArr.count : theaterInfoArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentedControl.selectedSegmentIndex == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoShowTableViewCell") as! InfoShowTableViewCell
            cell.configure(data: showInfoArr[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTheaterTableViewCell") as! InfoTheaterTableViewCell
            cell.configure(data: theaterInfoArr[indexPath.row])
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segmentedControl.selectedSegmentIndex == 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ShowDetailVC") as! ShowDetailVC
            detailDelegate = vc
            detailDelegate?.getId(id: showInfoArr[indexPath.row].showId)
            self.navigationController?.pushViewController(vc, animated: false)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TheaterDetailVC") as! TheaterDetailVC
            detailDelegate = vc
            detailDelegate?.getId(id: theaterInfoArr[indexPath.row].theaterId)
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
}




