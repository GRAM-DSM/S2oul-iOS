//
//  MapVC.swift
//  S2oul
//
//  Created by baby1234 on 23/09/2019.
//  Copyright © 2019 baby1234. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapVC: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!

    private var aroundTheater = [AroundTheaterInfo]()

    private let httpClient = HTTPClient()
    private let locationManager = CLLocationManager()

    var delegate: DetailInfoDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBarTitleView()
        tableView.backgroundColor = UIColor.white
        tableView.register(UINib(nibName: "InfoTheaterTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoTheaterTableViewCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        configureMap()
    }

    private func configureMap() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        if !canUseCurrentLocation(status: CLLocationManager.authorizationStatus()) {
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.startUpdatingLocation()
        guard let coordinate = locationManager.location?.coordinate else {
            showToast(message: "현재위치확인불가")
            return
        }
        moveCurrentLocation(at: coordinate)
        getMap(latitude: "\(coordinate.latitude)", longtitude: "\(coordinate.longitude)")
    }

    private func moveCurrentLocation(at coordinate: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        let camera = MKMapCamera(lookingAtCenter: coordinate,
                                 fromEyeCoordinate: coordinate,
                                 eyeAltitude: 1000)
        mapView.setRegion(region, animated: true)
        mapView.setCamera(camera, animated: true)
    }

    private func canUseCurrentLocation(status: CLAuthorizationStatus) -> Bool {
        switch status{
        case .notDetermined, .restricted, .denied:
            return false
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        @unknown default:
            return false
        }
    }

    private func makeAnnotaion(lat: Double, lng: Double, name: String) -> MKPointAnnotation {
        let annotaion = MKPointAnnotation()
        annotaion.title = name
        annotaion.coordinate.latitude = lat
        annotaion.coordinate.longitude = lng
        return annotaion
    }
}

extension MapVC: MapAPIProvider {
    func getMap(latitude: String, longtitude: String) {
        let param = latitude + ";" + longtitude
        httpClient.get(url: SoulURL.map(latAndLng: param).getPath()).responseData { [weak self] (data) in
            guard let strongSelf = self else { return }
            guard let data = data.data, let response = try? JSONDecoder().decode([AroundTheaterInfo].self, from: data) else { return }
            DispatchQueue.main.async {
                strongSelf.aroundTheater = response
            }
        }
    }
}

extension MapVC: CLLocationManagerDelegate, MKMapViewDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let firstLocation = locations.first else { return }
        moveCurrentLocation(at: firstLocation.coordinate)
    }
}

extension MapVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTheaterTableViewCell") as! InfoTheaterTableViewCell
        let theater = aroundTheater[indexPath.row]
        let info = TheaterInfo(theaterImage: theater.theaterImage,
                               theaterName: theater.theaterName,
                               phoneNumber: theater.phoneNumber,
                               location: theater.location,
                               theaterId: theater.theaterId)
        cell.configure(data: info)
        mapView.addAnnotation(makeAnnotaion(lat: theater.latitude, lng: theater.longtitude, name: theater.theaterName))
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "TheaterDetailVC") as! TheaterDetailVC
        delegate = vc
        delegate?.getId(id: aroundTheater[indexPath.row].theaterId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
