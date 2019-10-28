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
    
    @IBOutlet weak var firstGenreCollectionView: UICollectionView!
    @IBOutlet weak var secondGenreCollectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: SoulSegmentedControl!
    
    private let firstTitles = ["전체", "연극", "뮤지컬"]
    private let secondTitles = ["콘서트/전시", "아동/가족"]
    private let firstImages = ["all", "play", "musical"]
    private let secondImages = ["concertAndShow", "childAndFamily"]

    private var beforeSelectedCell: (Int, GenreCollectionViewCell?) = (1, nil)
    
    private var selectedGenre = "전체"

    var delegate: SortAndGenreDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sortAndGenreAdjustBtn(_ sender: UIButton) {
        switch selectedGenre {
        case "전체":
            delegate?.getSortIndexAndFilterGenre(sort: segmentedControl.selectedSegmentIndex, filter: .all)
        case "연극":
            delegate?.getSortIndexAndFilterGenre(sort: segmentedControl.selectedSegmentIndex, filter: .play)
        case "뮤지컬":
            delegate?.getSortIndexAndFilterGenre(sort: segmentedControl.selectedSegmentIndex, filter: .musical)
        case "콘서트/전시":
            delegate?.getSortIndexAndFilterGenre(sort: segmentedControl.selectedSegmentIndex, filter: .concertAndShow)
        case "아동/가족":
            delegate?.getSortIndexAndFilterGenre(sort: segmentedControl.selectedSegmentIndex, filter: .childAndFamily)
        default:
            delegate?.getSortIndexAndFilterGenre(sort: segmentedControl.selectedSegmentIndex, filter: .all)
        }
        self.navigationController?.popViewController(animated: false)
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
        } else {
            cell.secondConfigure(img: secondImages[index], title: secondTitles[index])
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! GenreCollectionViewCell
        changeBeforeSelectedCellColor()

        if collectionView == firstGenreCollectionView {
            cell.changeFirstCellColor(tintColor: UIColor.white, backgroundColor: UIColor.seoul)
            beforeSelectedCell.0 = 1
            selectedGenre = cell.firstTitleLbl.text!
        } else {
            cell.changeSecondCellColor(tintColor: UIColor.white, backgroundColor: UIColor.seoul)
            beforeSelectedCell.0 = 2
            selectedGenre = cell.secondTitleLbl.text!
        }

        beforeSelectedCell.1 = cell

    }

    private func changeBeforeSelectedCellColor() {
        if let selectedCell = beforeSelectedCell.1 {
            if beforeSelectedCell.0 == 1 {
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
