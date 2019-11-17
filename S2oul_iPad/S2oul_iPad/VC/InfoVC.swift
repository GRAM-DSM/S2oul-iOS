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

    private var sort = Sort.alphabetical
    private var genre = Genre.all

    private var shows = Dummy.shared.shows
    private var theaters = Dummy.shared.theaters
    
    var detailDelegate: DetailInfoDelegate?
    var genreDelegate: SortAndGenreDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarTitleView()
        tableView.backgroundColor = UIColor.white
        tableView.register(UINib(nibName: "InfoShowTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoShowTableViewCell")
        tableView.register(UINib(nibName: "InfoTheaterTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoTheaterTableViewCell")

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
            tableView.reloadData()
            sortBtn.isHidden = false
        } else {
            tableView.reloadData()
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

extension InfoVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return segmentedControl.selectedSegmentIndex == 0 ? shows.count : theaters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentedControl.selectedSegmentIndex == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoShowTableViewCell") as! InfoShowTableViewCell
            cell.configure(data: shows[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTheaterTableViewCell") as! InfoTheaterTableViewCell
            cell.configure(data: theaters[indexPath.row])
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segmentedControl.selectedSegmentIndex == 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ShowDetailVC") as! ShowDetailVC
            detailDelegate = vc
            detailDelegate?.getId(id: shows[indexPath.row].showId)
            self.navigationController?.pushViewController(vc, animated: false)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TheaterDetailVC") as! TheaterDetailVC
            detailDelegate = vc
            detailDelegate?.getId(id: theaters[indexPath.row].theaterId)
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
}




