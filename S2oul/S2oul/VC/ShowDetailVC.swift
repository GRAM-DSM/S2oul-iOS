//
//  ShowDetailVC.swift
//  S2oul
//
//  Created by baby1234 on 23/09/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit
import SafariServices
import Kingfisher

class ShowDetailVC: UIViewController {

    @IBOutlet weak var showImgView: RoundImageView!
    @IBOutlet weak var showNameLbl: UILabel!
    @IBOutlet weak var showPeriodLbl: UILabel!
    @IBOutlet weak var showAgeLbl: UILabel!
    @IBOutlet weak var showPriceLbl: UILabel!
    @IBOutlet weak var theaterNameLbl: UILabel!
    @IBOutlet weak var runningTimeLbl: UILabel!
    @IBOutlet weak var reservationBtn: Round10Button!

    @IBOutlet weak var summaryImgView: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    private var reservationLink = ""
    private var theaterInfo: ShowDetailInfo?

    var delegate: DetailInfoDelegate?

    private let httpClient = HTTPClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarTitleView()
        tableView.register(UINib(nibName: "ShowDetailTheaterCell", bundle: nil), forCellReuseIdentifier: "ShowDetailTheaterCell")
    }

    private func setData(_ data: ShowDetailInfo) {
        showImgView.kf.setImage(with: URL(string: data.showImage))
        showNameLbl.text = data.showName
        showPeriodLbl.text = data.period
        showAgeLbl.text = data.age
        showPriceLbl.text = data.cost
        theaterNameLbl.text = data.theaterName
        runningTimeLbl.text = data.runningTime
        reservationLink = data.link
        summaryImgView.kf.setImage(with: URL(string: data.summaryImage))
        theaterInfo = data
        tableView.reloadData()
    }

    @IBAction func reservationBtnAction(_ sender: Round10Button) {
        if let url = URL(string: reservationLink) {
            let vc = SFSafariViewController(url: url)
            self.present(vc, animated: true, completion: nil)
        }
    }

}

extension ShowDetailVC: DetailShowInfoAPIProvider {
    func getShowDetailInfo(showId: String) {
        httpClient.get(url: SoulURL.detailInfoShow(showId: showId).getPath())
            .responseData { [weak self] (data) in
                guard let strongSelf = self else { return }
                guard let data = data.data, let response = try? JSONDecoder().decode(ShowDetailInfo.self, from: data) else { return }
                DispatchQueue.main.async {
                    strongSelf.setData(response)
                }
        }
    }
}


extension ShowDetailVC: DetailInfoDelegate {
    func getId(id: String) {
        getShowDetailInfo(showId: id)
    }
}

extension ShowDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowDetailTheaterCell") as! ShowDetailTheaterCell
        guard let info = theaterInfo else { return cell }
        cell.configure(info: info)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TheaterDetail") as! TheaterDetailVC
        guard let info = theaterInfo else { return }
        delegate = vc
        delegate?.getId(id: info.theaterId)
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

