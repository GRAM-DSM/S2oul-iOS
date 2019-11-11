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

    var searchShowResults = [SearchShowInfo]()
    var searchTheaterResults = [SearchTheaterInfo]()
    var searchHistory: [String]? = UserDefaults.standard.stringArray(forKey: "SearchHistory")
    var delegate: SortAndGenreDelegate?
    var detailDelegate: DetailInfoDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarTitleView()
        searchBarConfigure()
        tableView.backgroundColor = UIColor.white
        tableView.register(UINib(nibName: "SearchShowTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchShowTableViewCell")
        tableView.register(UINib(nibName: "SearchTheaterTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTheaterTableViewCell")
        tableView.register(UINib(nibName: "SearchHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchHistoryTableViewCell")
    }

    override func viewWillDisappear(_ animated: Bool) {
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
        searchHistory?.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }

    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        searchBar.placeholder = sender.titleForSegment(at: sender.selectedSegmentIndex)! + "검색"
        tableView.reloadData()
    }
}

extension SearchVC: SearchAPIProvider {
    func searchShow(keyword: String) {
        let query = "?searchType=" + genre.rawValue + "&searchType=" + sort.rawValue + "&keyword=" + keyword
        httpClient.get(url: SoulURL.searchShow(search: query).getPath())
            .responseData { [weak self] (response) in
                guard let strongSelf = self else { return }
                DispatchQueue.main.async {
                    guard let response = response.data, let data = try? JSONDecoder().decode([SearchShowInfo].self, from: response) else {
                        strongSelf.placeholderLbl.text = "검색결과가 없습니다"
                        strongSelf.tableView.reloadData()
                        return
                    }
                    strongSelf.searchShowResults = data
                    strongSelf.tableView.reloadData()
                    strongSelf.searchHistory?.forEach({ (history) in
                        if history == keyword { return }
                        strongSelf.searchHistory?.append(keyword)
                    })
                }
        }
    }

    func searchTheater(keyword: String) {
        let query = "?keyword=" + keyword
        httpClient.get(url: SoulURL.searchShow(search: query).getPath())
            .responseData { [weak self] (response) in
                guard let strongSelf = self else { return }
                DispatchQueue.main.async {
                    guard let response = response.data, let data = try? JSONDecoder().decode([SearchTheaterInfo].self, from: response) else {
                        strongSelf.placeholderLbl.text = "검색결과가 없습니다"
                        strongSelf.tableView.reloadData()
                        return
                    }
                    strongSelf.searchTheaterResults = data
                    strongSelf.tableView.reloadData()
                    strongSelf.searchHistory?.forEach({ (history) in
                        if history == keyword { return }
                        strongSelf.searchHistory?.append(keyword)
                    })
                }
        }
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
        definesPresentationContext = true
        let searchBarWrapper = SearchBarContainerView(customSearchBar: searchBar)
        searchBarWrapper.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        navigationItem.titleView = searchBarWrapper
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
            guard let history = searchHistory else { placeholderLbl.isHidden = false; return 0 }
            placeholderLbl.isHidden = true
            return history.count
        case .show:
            if searchShowResults.count == 0 { placeholderLbl.isHidden = false; return 0 }
            placeholderLbl.isHidden = true
            return searchShowResults.count
        case .theater:
            if searchTheaterResults.count == 0 { placeholderLbl.isHidden = false; return 0 }
            placeholderLbl.isHidden = true
            return searchTheaterResults.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row

        switch getCurrentSearchState() {
        case .none:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchHistoryTableViewCell") as! SearchHistoryTableViewCell
            guard let history = searchHistory else { return cell }
            cell.configure(history: history[index])
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
            guard let history = searchHistory else { return }
            searchBar.text = history[indexPath.row]
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

class SearchBarContainerView: UIView {
    let searchBar: UISearchBar
    init(customSearchBar: UISearchBar) {
        searchBar = customSearchBar
        super.init(frame: CGRect.zero)
        addSubview(searchBar)
    }

    override convenience init(frame: CGRect) {
        self.init(customSearchBar: UISearchBar())
        self.frame = frame
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        searchBar.frame = bounds
    }
}
