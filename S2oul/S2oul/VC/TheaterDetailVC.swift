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
    
    private var simpleShowArr = [SimpleShowInfo]()
    
    var delegate: DetailInfoDelegate?
    
    private let httpClient = HTTPClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarTitleView()
        collectionView.register(UINib(nibName: "AShowInMotionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AShowInMotionCollectionViewCell")
    }
    
}

extension TheaterDetailVC: DetailTheaterInfoAPIProvider {
    
    func getTheaterDetailInfo(theaterId: String) {
        httpClient.get(url: SoulURL.detailInfoTheater(theaterId: theaterId).getPath())
            .responseData { [weak self] (data) in
                guard let strongSelf = self else { return }
                guard let data = data.data, let response = try? JSONDecoder().decode(TheaterDetailInfo.self, from: data) else { return }
                DispatchQueue.main.async {
                    strongSelf.theaterImgView.kf.setImage(with: URL(string: response.theaterImage))
                    strongSelf.theaterNameLbl.text = response.theaterName
                    strongSelf.theaterPhoneNumberLbl.text = response.phoneNumber
                    strongSelf.theaterLocationLbl.text = response.location
                    strongSelf.numberOfSeatsLbl.text = response.seatNumber
                    strongSelf.simpleShowArr = response.shows
                }
        }
    }
}


extension TheaterDetailVC: DetailInfoDelegate {
    func getId(id: String) {
        getTheaterDetailInfo(theaterId: id)
    }
}

extension TheaterDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AShowInMotionCollectionViewCell", for: indexPath) as! AShowInMotionCollectionViewCell
        cell.configure(info: simpleShowArr[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ShowDetailVC") as! ShowDetailVC
        delegate = vc
        delegate?.getId(id: simpleShowArr[indexPath.row].showId)
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
