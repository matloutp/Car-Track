//
//  LiveUsersViewController.swift
//  Car Track
//
//  Created by Thapelo on 2021/12/26.
//

import UIKit
import MapKit

class LiveUsersViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var backBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        let img = UIImage(named: "fi_arrow-left")
        
        btn.setImage(img, for: .normal)
        
        btn.addTarget(self, action: #selector(backF), for: .touchUpInside)
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        
        return btn
        
    }()
    
    lazy var map: MKMapView = {
        
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        
        
        return map
    }()
    
    let locationManager = CLLocationManager()
    
    lazy var killWakeEngineBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 16
        
        btn.setTitle("Kill Engine", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        
        btn.titleLabel?.font = UIFont(name: "JosefinSans-Bold", size: 21)
        
        btn.backgroundColor = UIColor(red: 248/255, green: 216/255, blue: 74/255, alpha: 1)
        
        btn.addTarget(self, action: #selector(killWakeEngineF), for: .touchUpInside)
        
        return btn
        
    }()
    
    let trackedCarsCV: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(LiveUsersCollectionViewCell.self, forCellWithReuseIdentifier: "LiveTrackedCarsId")
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cv.backgroundColor = .clear
        
        cv.layer.masksToBounds = true
        cv.layer.cornerRadius = 12
        
        return cv
        
    }()
    
    
    var newLocation = CLLocationCoordinate2D()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    
    var pastLocations = [CarLocation]()
    var annotations = [MKPointAnnotation]()
    
    func setup(){
        
        view.backgroundColor = .white
        
        view.addSubview(map)
        view.addSubview(backBtn)
        
        map.delegate = self
        map.showsUserLocation = true
        
        trackedCarsCV.delegate = self
        trackedCarsCV.dataSource = self
        
        backBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        backBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        backBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        backBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        map.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        map.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        map.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        map.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        let viewRegion = MKCoordinateRegion(center: newLocation, latitudinalMeters: 200, longitudinalMeters: 200)
        map.setRegion(viewRegion, animated: false)
        map.showsUserLocation = true
        
        let carLocation = CarLocation()
        
        let pastLocation = newLocation
        
        carLocation.latValue = newLocation.latitude
        carLocation.longValue = newLocation.longitude
        
        let annotation = Annotation()
        annotation.coordinate = pastLocation
        annotation.lastLocation = true
        annotation.title = "Car Location"
        
        self.annotations.append(annotation)
        
        carLocation.annotation = annotation
        
        self.pastLocations.append(carLocation)
        
        let lastAnnotation = self.pastLocations.last!.annotation
        
        self.annotations = []
        
        for carLocation in self.pastLocations {
            
            let an = carLocation.annotation
            
            an!.lastLocation = false
            an!.title = "History Location"
            
            self.annotations.append(an!)
        }
        
        lastAnnotation!.lastLocation = true
        lastAnnotation!.title = "Current Location"
        
        
        self.map.showAnnotations(self.annotations, animated: true)
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        
        }
        
        //Zoom to user location
        
        if let userLocation = locationManager.location?.coordinate {
            
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 200, longitudinalMeters: 200)
                map.setRegion(viewRegion, animated: false)
        
        }
        
        DispatchQueue.main.async {
            
            self.locationManager.startUpdatingLocation()
        
        }
        
    }
    
    @objc func backF(){
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func killWakeEngineF(){
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            
            map.setRegion(region, animated: true)
        
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("error:: \(error)")
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 9
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LiveTrackedCarsId", for: indexPath) as! LiveUsersCollectionViewCell
        
        cell.backgroundColor = .white
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 32
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: view.frame.width - 48, height: 150)
        
        return size
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }

}
