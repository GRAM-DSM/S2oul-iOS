//
//  SearchVC.swift
//  S2oul
//
//  Created by baby1234 on 21/09/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var sortAndGenreBtn: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var placeholderLbl: UILabel!

    private let httpClient = HTTPClient()

    private var genre = Genre.all
    private var sort = Sort.alphabetical

    let searchBar = UISearchBar()

    var searchShowResults = [ShowInfo]()
    var searchTheaterResults = [TheaterInfo]()
    var searchHistory = [String]()
    var delegate: SortAndGenreDelegate?
    var detailDelegate: DetailInfoDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarTitleView()
        searchBarConfigure()
        if let history = UserDefaults.standard.array(forKey: "SearchHistory") as? [String]{
            searchHistory = history
        }
        tableView.backgroundColor = UIColor.white
        tableView.register(UINib(nibName: "SearchShowTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchShowTableViewCell")
        tableView.register(UINib(nibName: "SearchTheaterTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTheaterTableViewCell")
        tableView.register(UINib(nibName: "SearchHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchHistoryTableViewCell")
    }

    override func viewWillDisappear(_ animated: Bool) {
        print(searchHistory)
        UserDefaults.standard.set(searchHistory, forKey: "SearchHistory")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SortAndGenreVC {
            vc.delegate = self
            delegate = vc
            delegate?.getSortIndexAndFilterGenre(sort: sort, genre: genre)
        }
    }

    @objc func deleteRows(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        guard let indexPath = tableView.indexPathForRow(at: point) else { return }
        searchHistory.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }

    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        searchBar.placeholder = sender.titleForSegment(at: sender.selectedSegmentIndex)! + "검색"
        searchBar.text = nil
        tableView.reloadData()
    }
}

extension SearchVC: SortAndGenreDelegate {
    func getSortIndexAndFilterGenre(sort: Sort, genre: Genre) {
        self.sort = sort
        self.genre = genre
    }
}

extension SearchVC: UISearchBarDelegate {
    private func searchBarConfigure() {
        searchBar.placeholder = "공연검색"
        searchBar.tintColor = UIColor.white
        searchBar.delegate = self
        searchBar.searchTextField.textColor = .white
        self.definesPresentationContext = true
        self.navigationItem.titleView = searchBar
    }

    private func searchShow(keyword: String) {
        let dummy = Dummy.shared.shows
        searchShowResults = [ShowInfo]()
        let result = dummy.contains(where: { [weak self] (info) -> Bool in
            guard let strongSelf = self else { return false }
            if info.showName.contains(keyword) {
                strongSelf.searchShowResults.append(info)
                return true
            } else { return false }
        })
        if result && !searchHistory.contains(keyword) {
            searchHistory.append(keyword)
        } else {
            placeholderLbl.text = "검색결과가 없습니다"
        }
        tableView.reloadData()
    }

    private func searchTheater(keyword: String) {
        let dummy = Dummy.shared.theaters
        searchTheaterResults = [TheaterInfo]()
        let result = dummy.contains(where: { [weak self] (info) -> Bool in
            guard let strongSelf = self else { return false }
            if info.theaterName.contains(keyword) {
                strongSelf.searchTheaterResults.append(info)
                return true
            } else { return false}
        })
        if result && !searchHistory.contains(keyword) {
            searchHistory.append(keyword)
        } else {
            placeholderLbl.text = "검색결과가 없습니다"
        }
        tableView.reloadData()
    }

    private func getCurrentSearchState() -> SearchState {
        if let txt = searchBar.text, txt.isEmpty { return .none }
        return segmentedControl.selectedSegmentIndex == 0 ? .show : .theater
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        switch getCurrentSearchState() {
        case .none:
            showToast(message: "검색할 단어를 입력해주세요")
        case .show:
            searchShow(keyword: searchBar.text!)
        case .theater:
            searchTheater(keyword: searchBar.text!)
        }
        searchBar.resignFirstResponder()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty { tableView.reloadData() }
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch getCurrentSearchState() {
        case .none:
            if searchHistory.isEmpty { placeholderLbl.isHidden = false; return 0 }
            placeholderLbl.isHidden = true
            return searchHistory.count
        case .show:
            if searchShowResults.isEmpty { placeholderLbl.isHidden = false; return 0 }
            placeholderLbl.isHidden = true
            return searchShowResults.count
        case .theater:
            if searchTheaterResults.isEmpty { placeholderLbl.isHidden = false; return 0 }
            placeholderLbl.isHidden = true
            return searchTheaterResults.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        switch getCurrentSearchState() {
        case .none:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchHistoryTableViewCell") as! SearchHistoryTableViewCell
            cell.configure(history: searchHistory[index])
            cell.deleteBtn.addTarget(self, action: #selector(deleteRows(_:)), for: .touchUpInside)
            return cell
        case .show:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchShowTableViewCell") as! SearchShowTableViewCell
            cell.configure(info: searchShowResults[index])
            return cell
        case .theater:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTheaterTableViewCell") as! SearchTheaterTableViewCell
            cell.configure(info: searchTheaterResults[index])
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch getCurrentSearchState() {
        case .none:
            searchBar.text = searchHistory[indexPath.row]
            searchBarSearchButtonClicked(searchBar)
        case .show:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ShowDetailVC") as! ShowDetailVC
            detailDelegate = vc
            detailDelegate?.getId(id: searchShowResults[indexPath.row].showId)
            self.navigationController?.pushViewController(vc, animated: false)
        case .theater:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TheaterDetailVC") as! TheaterDetailVC
            detailDelegate = vc
            detailDelegate?.getId(id: searchTheaterResults[indexPath.row].theaterId)
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }

}

enum SearchState {
    case none, show, theater
}
