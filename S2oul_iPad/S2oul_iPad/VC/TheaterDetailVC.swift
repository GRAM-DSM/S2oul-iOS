//
//  TheaterDetailVC.swift
//  S2oul
//
//  Created by baby1234 on 23/09/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit

class TheaterDetailVC: UIViewController {
    
    @IBOutlet weak var theaterImgView: RoundImageView!
    @IBOutlet weak var theaterNameLbl: UILabel!
    @IBOutlet weak var theaterPhoneNumberLbl: UILabel!
    @IBOutlet weak var theaterLocationLbl: UILabel!
    @IBOutlet weak var numberOfSeatsLbl: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var shows = Dummy.shared.theaterDetails[0]
    private var theaterId = 0
    
    var delegate: DetailInfoDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarTitleView()
        setData(Dummy.shared.theaterDetails[theaterId])
    }

    private func setData(_ data: TheaterDetailInfo) {
        theaterImgView.kf.setImage(with: URL(string: data.theaterImage))
        theaterNameLbl.text = data.theaterName
        theaterPhoneNumberLbl.text = data.phoneNumber
        theaterLocationLbl.text = data.location
        numberOfSeatsLbl.text = "\(data.seatNumber)석"
        shows = data
    }
    
}

extension TheaterDetailVC: DetailInfoDelegate {
    func getId(id: Int) {
        theaterId = id
    }
}

extension TheaterDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AShowInMotionCollectionViewCell", for: indexPath) as! AShowInMotionCollectionViewCell
        cell.configure(info: shows)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ShowDetailVC") as! ShowDetailVC
        delegate = vc
        delegate?.getId(id: shows.shows[0].showId)
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

class AShowInMotionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var showImgView: UIImageView!
    @IBOutlet weak var showNameLbl: UILabel!

    func configure(info: TheaterDetailInfo) {
        showImgView.kf.setImage(with: URL(string: info.shows[0].showImage))
        showNameLbl.text = info.shows[0].showName
    }
}
