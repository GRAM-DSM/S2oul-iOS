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
    @IBOutlet weak var summaryImgViewHeightConstraint: NSLayoutConstraint!

    private var reservationLink = ""
    private var theaterInfo: ShowDetailInfo?
    private var showId = 0

    var delegate: DetailInfoDelegate?

    private let httpClient = HTTPClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarTitleView()
        tableView.register(UINib(nibName: "ShowDetailTheaterCell", bundle: nil), forCellReuseIdentifier: "ShowDetailTheaterCell")
        setData(Dummy.shared.showDetails[showId])
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
        let summary = Dummy.shared.summaryImgs[showId]
        summaryImgViewHeightConstraint.constant = summary.size.height
        summaryImgView.image = summary
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

extension ShowDetailVC: DetailInfoDelegate {
    func getId(id: Int) {
        showId = id
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
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TheaterDetailVC") as! TheaterDetailVC
        guard let info = theaterInfo else { return }
        delegate = vc
        delegate?.getId(id: info.theaterId)
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

