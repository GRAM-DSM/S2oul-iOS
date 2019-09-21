//
//  HomeVC.swift
//  S2oul
//
//  Created by baby1234 on 20/09/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit

import expanding_collection

class HomeVC: ExpandingViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionBtn: UIButton!
    @IBOutlet weak var pageLbl: UILabel!

    fileprivate let items: [String] = ["극장 동국", "나온씨어터", "노을소극장", "대학로 스튜디오 76", "드림시어터", "선돌극장", "소극장 공유", "소극장 혜화당", "아름다운극장", "연극실험실 혜화동1번지", "연우소극장", "예술공간 서울", "예술공간 오르다", "예술공간 혜화"]

    override func viewDidLoad() {
        itemSize = CGSize(width: 256, height: 350)
        super.viewDidLoad()
        descriptionBtn.addTarget(self, action: #selector(descriptionBtnTaps), for: .touchUpInside)

        registerCell()
        layoutConfigure()
    }

    @objc func descriptionBtnTaps() {

    }

    private func registerCell() {
        let nib = UINib(nibName: String(describing: homeCollectionViewCell.self), bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: "homeCollectionViewCell")
    }

    private func layoutConfigure() {
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        descriptionBtn.translatesAutoresizingMaskIntoConstraints = false
        pageLbl.translatesAutoresizingMaskIntoConstraints = false

        titleLbl.bottomAnchor.constraint(equalTo: collectionView?.topAnchor ?? self.view.safeAreaLayoutGuide.topAnchor, constant: -4).isActive = true
        titleLbl.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        descriptionBtn.leadingAnchor.constraint(equalTo: titleLbl.trailingAnchor).isActive = true
        descriptionBtn.bottomAnchor.constraint(equalTo: titleLbl.topAnchor).isActive = true
        descriptionBtn.heightAnchor.constraint(equalToConstant: 12).isActive = true
        descriptionBtn.widthAnchor.constraint(equalTo: descriptionBtn.heightAnchor).isActive = true
        pageLbl.topAnchor.constraint(equalTo: collectionView?.bottomAnchor ?? self.view.safeAreaLayoutGuide.bottomAnchor, constant: 20).isActive = true
        pageLbl.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }

    func scrollViewDidScroll(_: UIScrollView) {
        pageLbl.text = "\(currentIndex + 1)/\(items.count)"
    }
}

extension HomeVC {

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! homeCollectionViewCell
        cell.cellIsOpen(!cell.isOpened)
    }

    override func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionViewCell", for: indexPath) as! homeCollectionViewCell

        let index = indexPath.row
        let info = items[index]
        cell.theaterImgView.image = UIImage(named: info + ".jpg")
        cell.theaterName.text = info
        return cell
    }
}
