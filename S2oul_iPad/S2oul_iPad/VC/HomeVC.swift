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
    
    @IBOutlet weak var titleBtn: UIButton!
    @IBOutlet weak var pageLbl: UILabel!
    
    fileprivate let items: [String] = ["극장 동국", "나온씨어터", "노을소극장", "대학로 스튜디오 76", "드림시어터", "선돌극장", "소극장 공유", "소극장 혜화당", "아름다운극장", "연극실험실 혜화동1번지", "연우소극장", "예술공간 서울", "예술공간 오르다", "예술공간 혜화"]

    override func viewDidLoad() {
        itemSize = CGSize(width: 400, height: 600)
        super.viewDidLoad()
        configureNavigationBarTitleView()
        registerCell()
        layoutConfigure()
    }
}

extension HomeVC {
    private func registerCell() {
        let nib = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: "HomeCollectionViewCell")
    }

    private func layoutConfigure() {
        titleBtn.translatesAutoresizingMaskIntoConstraints = false
        pageLbl.translatesAutoresizingMaskIntoConstraints = false

        guard let collectionView = collectionView else { return }
        titleBtn.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -16).isActive = true
        titleBtn.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        pageLbl.topAnchor.constraint(equalTo:  collectionView.bottomAnchor, constant: 16).isActive = true
        pageLbl.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    }

    func scrollViewDidScroll(_: UIScrollView) {
        pageLbl.text = "\(currentIndex + 1)/\(items.count)"
    }

    @IBAction func descriptionBtnAction(_ sender: UIButton) {
        let modal = UIViewController(nibName: "HomeModalVC", bundle: nil)
        modal.modalPresentationStyle = .popover
        let popover: UIPopoverPresentationController = modal.popoverPresentationController!
        popover.sourceView = sender
        popover.sourceRect = sender.bounds
        popover.permittedArrowDirections = [.down, .up]
        present(modal, animated: true, completion: nil)
    }
}

extension HomeVC {

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! HomeCollectionViewCell
        cell.cellIsOpen(!cell.isOpened)
    }

    override func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell

        let index = indexPath.row
        let info = items[index]
        cell.theaterImgView.image = UIImage(named: info + ".jpg")
        cell.theaterNameLbl.text = info
        return cell
    }
}
