//
//  SortAndFirterVC.swift
//  S2oul
//
//  Created by baby1234 on 24/09/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit

class SortAndGenreVC: UIViewController {

    typealias SelectedGenre = (tableView: Int, index: Int, cell: GenreCollectionViewCell?)

    @IBOutlet weak var sortView: UIView!
    @IBOutlet weak var sectionView: UIView!
    @IBOutlet weak var genreView: UIView!
    
    @IBOutlet weak var firstGenreCollectionView: UICollectionView!
    @IBOutlet weak var secondGenreCollectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: SoulSegmentedControl!
    
    private let firstTitles = ["전체", "연극", "뮤지컬"]
    private let secondTitles = ["콘서트/전시", "아동/가족"]
    private let firstImages = ["all", "play", "musical"]
    private let secondImages = ["concertAndShow", "childAndFamily"]

    private var selectedGenre: SelectedGenre = (0, 0, nil)
    private var selectedSort = 0
    
    var delegate: SortAndGenreDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.selectedSegmentIndex = selectedSort
    }
    
    @IBAction func sortAndGenreAdjustBtn(_ sender: UIButton) {
        delegate?.getSortIndexAndFilterGenre(sort: Sort.getGenre(index: segmentedControl.selectedSegmentIndex),
                                             genre: Genre.getGenre(index: selectedGenre.index))
        self.navigationController?.popViewController(animated: true)
    }
}

extension SortAndGenreVC: SortAndGenreDelegate {
    func getSortIndexAndFilterGenre(sort: Sort, genre: Genre) {
        switch genre {
        case .all, .play, .musical:
            selectedGenre = (0, genre.getIndex(), nil)
        default:
            selectedGenre = (1, genre.getIndex(), nil)
        }
        selectedSort = sort.getIndex()
    }
}

extension SortAndGenreVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == firstGenreCollectionView ? 3 : 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCollectionViewCell", for: indexPath) as! GenreCollectionViewCell
        let index = indexPath.item

        if collectionView == firstGenreCollectionView {
            cell.firstConfigure(img: firstImages[index], title: firstTitles[index])
            if selectedGenre.index == index {
                cell.changeFirstCellColor(tintColor: UIColor.white, backgroundColor: UIColor.seoul)
                selectedGenre.cell = cell
            }
        } else {
            cell.secondConfigure(img: secondImages[index], title: secondTitles[index])
            if selectedGenre.index == index + 3 {
                cell.changeSecondCellColor(tintColor: UIColor.white, backgroundColor: UIColor.seoul)
                selectedGenre.cell = cell
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! GenreCollectionViewCell
        changeBeforeSelectedCellColor()

        if collectionView == firstGenreCollectionView {
            cell.changeFirstCellColor(tintColor: UIColor.white, backgroundColor: UIColor.seoul)
            selectedGenre.tableView = 0
            selectedGenre.index = indexPath.row
        } else {
            cell.changeSecondCellColor(tintColor: UIColor.white, backgroundColor: UIColor.seoul)
            selectedGenre.tableView = 1
            selectedGenre.index = indexPath.row + 3
        }
        selectedGenre.cell = cell
    }

    private func changeBeforeSelectedCellColor() {
        if let selectedCell = selectedGenre.cell {
            if selectedGenre.tableView == 0 {
                selectedCell.changeFirstCellColor(tintColor: UIColor.seoul, backgroundColor: UIColor.white)
            } else {
                selectedCell.changeSecondCellColor(tintColor: UIColor.seoul, backgroundColor: UIColor.white)
            }
        }
    }
}

class GenreCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var firstIconImgView: UIImageView!
    @IBOutlet weak var firstTitleLbl: UILabel!
    @IBOutlet weak var secondIconImgView: UIImageView!
    @IBOutlet weak var secondTitleLbl: UILabel!

    func firstConfigure(img: String, title: String) {
        firstIconImgView.image = UIImage(named: "\(img).png")
        firstTitleLbl.text = title
        configureBorder()
    }

    func secondConfigure(img: String, title: String) {
        secondIconImgView.image = UIImage(named: "\(img).png")
        secondTitleLbl.text = title
        configureBorder()
    }

    func changeFirstCellColor(tintColor: UIColor, backgroundColor: UIColor) {
        firstIconImgView.tintColor = tintColor
        firstTitleLbl.textColor = tintColor
        contentView.backgroundColor = backgroundColor
    }

    func changeSecondCellColor(tintColor: UIColor, backgroundColor: UIColor) {
        secondIconImgView.tintColor = tintColor
        secondTitleLbl.textColor = tintColor
        contentView.backgroundColor = backgroundColor
    }

    private func configureBorder() {
        contentView.layer.borderColor = UIColor.seoul.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 12
    }

}
