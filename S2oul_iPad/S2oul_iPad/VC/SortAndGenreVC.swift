//
//  SortAndFirterVC.swift
//  S2oul
//
//  Created by baby1234 on 24/09/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit

class SortAndGenreVC: UIViewController {

    @IBOutlet weak var sortView: UIView!
    @IBOutlet weak var sectionView: UIView!
    @IBOutlet weak var genreView: UIView!
    
    @IBOutlet weak var allBtn: Round12Button!
    @IBOutlet weak var allLbl: UILabel!
    @IBOutlet weak var playBtn: Round12Button!
    @IBOutlet weak var playLbl: UILabel!
    @IBOutlet weak var musicalBtn: Round12Button!
    @IBOutlet weak var musicalLbl: UILabel!
    @IBOutlet weak var concertAndShowBtn: Round12Button!
    @IBOutlet weak var concertAndShowLbl: UILabel!
    @IBOutlet weak var childAndFamilyBtn: Round12Button!
    @IBOutlet weak var childAndFamilyLbl: UILabel!

    @IBOutlet weak var segmentedControl: SoulSegmentedControl!

    private var selectedGenre = Genre.all
    private var selectedSort = 0
    
    var delegate: SortAndGenreDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.selectedSegmentIndex = selectedSort
        changeSelectedGenreColor(isCurrentSelected: true)
        allBtn.addTarget(self, action: #selector(selectedGenreAction(_:)), for: .touchUpInside)
        playBtn.addTarget(self, action: #selector(selectedGenreAction(_:)), for: .touchUpInside)
        musicalBtn.addTarget(self, action: #selector(selectedGenreAction(_:)), for: .touchUpInside)
        concertAndShowBtn.addTarget(self, action: #selector(selectedGenreAction(_:)), for: .touchUpInside)
        childAndFamilyBtn.addTarget(self, action: #selector(selectedGenreAction(_:)), for: .touchUpInside)
    }

    private func changeGenreColor(_ isSelected: Bool, btn: UIButton, lbl: UILabel) {
        if isSelected {
            btn.tintColor = UIColor.white
            btn.backgroundColor = UIColor.seoul
            lbl.textColor = UIColor.white
        } else {
            btn.tintColor = UIColor.seoul
            btn.backgroundColor = UIColor.white
            lbl.textColor = UIColor.seoul
        }
    }

    private func changeSelectedGenreColor(isCurrentSelected: Bool) {
        switch selectedGenre {
        case .all: changeGenreColor(isCurrentSelected, btn: allBtn, lbl: allLbl)
        case .play: changeGenreColor(isCurrentSelected, btn: playBtn, lbl: playLbl)
        case .musical: changeGenreColor(isCurrentSelected, btn: musicalBtn, lbl: musicalLbl)
        case .concertAndShow: changeGenreColor(isCurrentSelected, btn: concertAndShowBtn, lbl: concertAndShowLbl)
        case .childAndFamily: changeGenreColor(isCurrentSelected, btn: childAndFamilyBtn, lbl: childAndFamilyLbl)
        }
    }
    
    @IBAction func sortAndGenreAdjustBtnAction(_ sender: UIButton) {
        delegate?.getSortIndexAndFilterGenre(sort: Sort.getGenre(index: segmentedControl.selectedSegmentIndex),
                                             genre: selectedGenre)
        self.navigationController?.popViewController(animated: true)
    }

    @objc func selectedGenreAction(_ sender: UIButton) {
        changeSelectedGenreColor(isCurrentSelected: false)
        switch sender.tag {
        case 0: selectedGenre = .all
        case 1: selectedGenre = .play
        case 2: selectedGenre = .musical
        case 3: selectedGenre = .concertAndShow
        case 4: selectedGenre = .childAndFamily
        default: print(sender.tag)
        }
        changeSelectedGenreColor(isCurrentSelected: true)
    }
}

extension SortAndGenreVC: SortAndGenreDelegate {
    func getSortIndexAndFilterGenre(sort: Sort, genre: Genre) {
        selectedGenre = genre
        selectedSort = sort.getIndex()
    }
}
