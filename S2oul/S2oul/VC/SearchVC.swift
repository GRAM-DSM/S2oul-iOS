//
//  SearchVC.swift
//  S2oul
//
//  Created by baby1234 on 21/09/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    typealias searchShowResult = (showName: String, theater: String)
    typealias searchTheaterRewult = (theaterName: String, theaterDistance: String, theaterLocation: String, theaterTel: String)

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    let searchController = UISearchController(searchResultsController: nil)

    var searchShowResults = [searchShowResult]()
    var searchTheaterResults = [searchTheaterRewult]()
    var searchHistory = [String]()
}

extension SearchVC: UISearchResultsUpdating {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarTitleView()
        searchControllerConfigure()
    }

    func filterContent(for searchText: String) {

    }

    func searchControllerConfigure() {
        searchController.searchResultsUpdater = self
        self.definesPresentationContext = true
        self.navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false

        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
    }

    func getCurrentSearchState() -> SearchState{
        if searchController.searchBar.text == nil {
            return .none
        } else if segmentedControl.selectedSegmentIndex == 0 {
            return .show
        } else {
            return .theater
        }
    }

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }

}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int { return 1 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // If the search bar is active, use the searchResults data.
//        return searchController.isActive ? searchResults.count : entries.count
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

enum SearchState {
    case none, show, theater
}
