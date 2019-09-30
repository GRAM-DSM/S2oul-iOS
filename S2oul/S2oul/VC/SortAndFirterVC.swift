//
//  SortAndFirterVC.swift
//  S2oul
//
//  Created by baby1234 on 24/09/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit

class SortAndFirterVC: UIViewController {

    @IBOutlet weak var sortView: UIView!
    @IBOutlet weak var sectionView: UIView!
    @IBOutlet weak var genreView: UIView!
    
    @IBOutlet weak var firstGenreCollectionView: UICollectionView!
    @IBOutlet weak var secondGenreCollectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: SoulSegmentedControl!
    
    let firstTitles = ["전체", "연극", "뮤지컬"]
    let secondTitles = ["콘서트/전시", "아동/가족"]
    let firstImages = ["all", "play", "musical"]
    let secondImages = ["concertAndShow", "childAndFamily"]

    var beforeSelectedCell: (Int, GenreCollectionViewCell?) = (1, nil)
    var isSuperViewIsSearchVC = false

    override func viewDidLoad() {
        super.viewDidLoad()
        if isSuperViewIsSearchVC {
            sortView.isHidden = true
            sectionView.isHidden = true
        }
    }
    
}

extension SortAndFirterVC: UICollectionViewDataSource, UICollectionViewDelegate {
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
        } else {
            cell.changeSecondCellColor(tintColor: UIColor.white, backgroundColor: UIColor.seoul)
            beforeSelectedCell.0 = 2
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
