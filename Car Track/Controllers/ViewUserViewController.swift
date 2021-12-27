//
//  ViewUserViewController.swift
//  Car Track
//
//  Created by Thapelo on 2021/12/26.
//


import UIKit
import Hero
import FontBlaster
import MapKit
import SDWebImage
import NVActivityIndicatorView

class Annotation: MKPointAnnotation
{
    
    var custom_image: Bool = true
    var lastLocation: Bool = true
    
}

class ViewUserViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    lazy var contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 155)
    
    var ownerId: String!
    var carLicense: String!
    
    var pastLocations = [CarLocation]()
    var annotations = [MKPointAnnotation]()
    
    lazy var topScrollView: UIScrollView = {
        
        let sV = UIScrollView(frame: .zero)
        sV.translatesAutoresizingMaskIntoConstraints = false
        sV.backgroundColor = .clear
        sV.contentSize = contentSize
        sV.frame = self.view.bounds
        sV.layer.zPosition = 1
        
        
        return sV
        
    }()
    
    let scrollContainer: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        return vw
    }()
    
    lazy var backBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        let img = UIImage(named: "fi_corner-up-left")
        
        btn.setImage(img, for: .normal)
        
        btn.addTarget(self, action: #selector(backF), for: .touchUpInside)
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        
        return btn
        
    }()
    
    let mapViewContainer: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.layer.masksToBounds = true
        vw.layer.cornerRadius = 24
        
        vw.layer.borderWidth = 2
        vw.layer.borderColor = UIColor(red: 234/255, green: 233/255, blue: 232/255, alpha: 1).cgColor
        
        return vw
        
    }()
    
    let userImage: UIImageView = {
        
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.image = UIImage(named: "benzo")
        
        img.contentMode = .scaleAspectFit
        
        return img
        
    }()
    
    lazy var userFullName: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        
        lbl.text = "Toyota"
        
        lbl.font = UIFont(name: "JosefinSans-Bold", size: 24)
        
        lbl.textAlignment = .left
        
        
        
        return lbl
        
    }()
    
    lazy var userName: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        
        lbl.text = "Hilux, 2019"
        
        lbl.font = UIFont(name: "JosefinSans-SemiBold", size: 24)
        
        lbl.textAlignment = .left
        
        
        return lbl
        
    }()
    
    lazy var userEmail: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        
        lbl.text = "Toyota"
        
        lbl.font = UIFont(name: "JosefinSans-Regular", size: 16)
        
        lbl.textAlignment = .left
        
        
        
        return lbl
        
    }()
    
    lazy var userPhone: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        
        lbl.text = "Toyota"
        
        lbl.font = UIFont(name: "JosefinSans-Regular", size: 16)
        
        lbl.textAlignment = .left
        
        
        
        return lbl
        
    }()
    
    let companyView: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.layer.masksToBounds = true
        vw.layer.cornerRadius = 26
        
        vw.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        return vw
        
    }()
    
    
    let companyIcon: UIImageView = {
        
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.image = UIImage(named: "companyBuilding")
        
        img.contentMode = .scaleAspectFit
        
        return img
        
    }()
    
    let companySeparator: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        
        return vw
        
    }()
    
    lazy var companyName: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        
        lbl.text = "Hilux, 2019"
        
        lbl.font = UIFont(name: "JosefinSans-SemiBold", size: 18)
        
        lbl.textAlignment = .left
        
        
        return lbl
        
    }()
    
    lazy var catchPhrase: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        
        lbl.text = "Hilux, 2019"
        
        lbl.font = UIFont(name: "JosefinSans-Regular", size: 14)
        
        lbl.textAlignment = .left
        
        
        return lbl
        
    }()
    
    lazy var bsLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        
        lbl.text = "Hilux, 2019"
        
        lbl.font = UIFont(name: "JosefinSans-Regular", size: 16)
        
        lbl.textAlignment = .left
        
        lbl.numberOfLines = 0
        
        
        return lbl
        
    }()
    
    
    let infoView: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.layer.masksToBounds = true
        vw.layer.cornerRadius = 26
        
        vw.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        return vw
        
    }()
    
    let calendarIcon: UIImageView = {
        
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.image = UIImage(named: "u_schedule")
        
        img.contentMode = .scaleAspectFit
        
        return img
        
    }()
    
    lazy var currentDateValue: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1)
        
        lbl.text = "30 Sept, 2021"
        
        lbl.font = UIFont(name: "JosefinSans-Regular", size: 21)
        
        lbl.textAlignment = .left
        
        
        return lbl
        
    }()
    
    let clockIcon: UIImageView = {
        
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.image = UIImage(named: "u_clock-nine")
        
        img.contentMode = .scaleAspectFit
        
        return img
        
    }()
    
    lazy var currentTimeValue: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1)
        
        lbl.text = "20:30"
        
        lbl.font = UIFont(name: "JosefinSans-Regular", size: 21)
        
        lbl.textAlignment = .right
        
        
        return lbl
        
    }()
    
    let topSeperator: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        
        return vw
        
    }()
    
    lazy var streetLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1)
        
        lbl.text = "Street"
        
        lbl.font = UIFont(name: "JosefinSans-Bold", size: 18)
        
        lbl.textAlignment = .left
        
        
        return lbl
        
    }()
    
    lazy var streetValue: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1)
        
        lbl.text = "-"
        
        lbl.font = UIFont(name: "JosefinSans-Regular", size: 18)
        
        lbl.textAlignment = .left
        
        
        return lbl
        
    }()
    
    let leftSeperator: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        
        return vw
        
    }()
    
    lazy var suiteLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1)
        
        lbl.text = "Suite"
        
        lbl.font = UIFont(name: "JosefinSans-Bold", size: 18)
        
        lbl.textAlignment = .left
        
        
        return lbl
        
    }()
    
    lazy var suiteValue: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1)
        
        lbl.text = "-"
        
        lbl.font = UIFont(name: "JosefinSans-Regular", size: 18)
        
        lbl.textAlignment = .left
        
        
        return lbl
        
    }()
    
    let rightSeperator: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        
        return vw
        
    }()
    
    lazy var cityLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1)
        
        lbl.text = "City"
        
        lbl.font = UIFont(name: "JosefinSans-Bold", size: 18)
        
        lbl.textAlignment = .left
        
        
        return lbl
        
    }()
    
    lazy var cityValue: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1)
        
        lbl.text = "-"
        
        lbl.font = UIFont(name: "JosefinSans-Regular", size: 18)
        
        lbl.textAlignment = .left
        
        
        return lbl
        
    }()
    
    lazy var mapBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8
        
        btn.setTitle("Map", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        
        btn.titleLabel?.font = UIFont(name: "JosefinSans-SemiBold", size: 21)
        
        btn.backgroundColor = UIColor(red: 248/255, green: 216/255, blue: 74/255, alpha: 1)
        
        btn.addTarget(self, action: #selector(trackF), for: .touchUpInside)
        
        return btn
        
    }()
    
    lazy var visitWebsiteBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 12
        
        btn.layer.borderWidth = 1.5
        btn.layer.borderColor = UIColor(red: 191/255, green: 191/255, blue: 191/255, alpha: 1).cgColor
        
        btn.setTitle("Visit Website", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        
        btn.titleLabel?.font = UIFont(name: "JosefinSans-SemiBold", size: 21)
        
        btn.addTarget(self, action: #selector(visitWebF), for: .touchUpInside)
        
        return btn
        
    }()
    
    let loadingLoader: NVActivityIndicatorView = {
        
        let vw = NVActivityIndicatorView(frame: .zero, type: .ballScaleMultiple, color: UIColor(red: 248/255, green: 216/255, blue: 74/255, alpha: 1), padding: 0)
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.layer.zPosition = 10
        
        vw.startAnimating()
        
        
        vw.isHidden = true
        
        return vw
        
    }()
    
    lazy var map: MKMapView = {
        
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        
        
        return map
    }()
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
    }
    

    func setup(){
        
        view.hero.isEnabled = true
        
        view.backgroundColor = .white
        
        FontBlaster.blast()
        
        view.addSubview(topScrollView)
        topScrollView.addSubview(scrollContainer)
        
        scrollContainer.addSubview(backBtn)
        
        scrollContainer.addSubview(userImage)
        
        scrollContainer.addSubview(mapBtn)
        scrollContainer.addSubview(visitWebsiteBtn)
        
        scrollContainer.addSubview(userFullName)
        scrollContainer.addSubview(userName)
        scrollContainer.addSubview(userPhone)
        scrollContainer.addSubview(userEmail)
        
        scrollContainer.addSubview(companyView)
        
        companyView.addSubview(companyIcon)
        companyView.addSubview(companySeparator)
        companyView.addSubview(companyName)
        companyView.addSubview(catchPhrase)
        companyView.addSubview(bsLbl)
        
        scrollContainer.addSubview(infoView)
        
        infoView.addSubview(calendarIcon)
        infoView.addSubview(currentDateValue)
        infoView.addSubview(currentTimeValue)
        infoView.addSubview(clockIcon)
        infoView.addSubview(topSeperator)
        infoView.addSubview(streetLbl)
        infoView.addSubview(streetValue)
        
        infoView.addSubview(suiteLbl)
        infoView.addSubview(suiteValue)
        
        infoView.addSubview(cityLbl)
        infoView.addSubview(cityValue)
        
        scrollContainer.addSubview(loadingLoader)
        
        map.delegate = self
        
        topScrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topScrollView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        topScrollView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        topScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        
        scrollContainer.centerXAnchor.constraint(equalTo: topScrollView.centerXAnchor).isActive = true
        scrollContainer.heightAnchor.constraint(equalToConstant: view.frame.height + 180).isActive = true
        scrollContainer.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        scrollContainer.topAnchor.constraint(equalTo: topScrollView.topAnchor, constant: -45).isActive = true
        
        
        backBtn.leftAnchor.constraint(equalTo: scrollContainer.leftAnchor, constant: 24).isActive = true
        backBtn.topAnchor.constraint(equalTo: scrollContainer.topAnchor, constant: 48).isActive = true
        backBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        backBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        userFullName.leftAnchor.constraint(equalTo: backBtn.rightAnchor, constant: 12).isActive = true
        userFullName.centerYAnchor.constraint(equalTo: backBtn.centerYAnchor, constant: 0).isActive = true
        userFullName.rightAnchor.constraint(equalTo: scrollContainer.rightAnchor, constant: -24).isActive = true
        userFullName.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        userImage.leftAnchor.constraint(equalTo: backBtn.leftAnchor, constant: 0).isActive = true
        userImage.topAnchor.constraint(equalTo: backBtn.bottomAnchor, constant: 12).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: 170).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        userName.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 12).isActive = true
        userName.topAnchor.constraint(equalTo: userImage.topAnchor, constant: 16).isActive = true
        userName.rightAnchor.constraint(equalTo: scrollContainer.rightAnchor, constant: -24).isActive = true
        userName.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        userPhone.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 12).isActive = true
        userPhone.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 12).isActive = true
        userPhone.rightAnchor.constraint(equalTo: scrollContainer.rightAnchor, constant: -24).isActive = true
        userPhone.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        userEmail.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 12).isActive = true
        userEmail.topAnchor.constraint(equalTo: userPhone.bottomAnchor, constant: 12).isActive = true
        userEmail.rightAnchor.constraint(equalTo: scrollContainer.rightAnchor, constant: -24).isActive = true
        userEmail.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        visitWebsiteBtn.leftAnchor.constraint(equalTo: scrollContainer.leftAnchor, constant: 24).isActive = true
        visitWebsiteBtn.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 9).isActive = true
        visitWebsiteBtn.widthAnchor.constraint(equalToConstant: view.frame.width / 1.8).isActive = true
        visitWebsiteBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        mapBtn.rightAnchor.constraint(equalTo: scrollContainer.rightAnchor, constant: -24).isActive = true
        mapBtn.centerYAnchor.constraint(equalTo: visitWebsiteBtn.centerYAnchor, constant: 0).isActive = true
        mapBtn.leftAnchor.constraint(equalTo: visitWebsiteBtn.rightAnchor, constant: 12).isActive = true
        mapBtn.heightAnchor.constraint(equalToConstant: 60).isActive = true
       
        companyView.leftAnchor.constraint(equalTo: scrollContainer.leftAnchor, constant: 24).isActive = true
        companyView.topAnchor.constraint(equalTo: mapBtn.bottomAnchor, constant: 12).isActive = true
        companyView.rightAnchor.constraint(equalTo: scrollContainer.rightAnchor, constant: -24).isActive = true
        companyView.heightAnchor.constraint(equalToConstant: 155).isActive = true
        
        companyIcon.leftAnchor.constraint(equalTo: companyView.leftAnchor, constant: 24).isActive = true
        companyIcon.topAnchor.constraint(equalTo: companyView.topAnchor, constant: 24).isActive = true
        companyIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        companyIcon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        companyName.leftAnchor.constraint(equalTo: companyIcon.rightAnchor, constant: 24).isActive = true
        companyName.topAnchor.constraint(equalTo: companyIcon.topAnchor, constant: 0).isActive = true
        companyName.rightAnchor.constraint(equalTo: companyView.rightAnchor, constant: -12).isActive = true
        companyName.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        catchPhrase.leftAnchor.constraint(equalTo: companyIcon.rightAnchor, constant: 24).isActive = true
        catchPhrase.topAnchor.constraint(equalTo: companyName.bottomAnchor, constant: 0).isActive = true
        catchPhrase.rightAnchor.constraint(equalTo: companyView.rightAnchor, constant: -12).isActive = true
        catchPhrase.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        companySeparator.leftAnchor.constraint(equalTo: companyView.leftAnchor, constant: 12).isActive = true
        companySeparator.topAnchor.constraint(equalTo: companyIcon.bottomAnchor, constant: 24).isActive = true
        companySeparator.rightAnchor.constraint(equalTo: companyView.rightAnchor, constant: -12).isActive = true
        companySeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        bsLbl.leftAnchor.constraint(equalTo: companyIcon.leftAnchor, constant: 0).isActive = true
        bsLbl.topAnchor.constraint(equalTo: companySeparator.bottomAnchor, constant: 12).isActive = true
        bsLbl.rightAnchor.constraint(equalTo: companyView.rightAnchor, constant: -12).isActive = true
        bsLbl.bottomAnchor.constraint(equalTo: companyView.bottomAnchor, constant: -12).isActive = true
        
        infoView.leftAnchor.constraint(equalTo: scrollContainer.leftAnchor, constant: 24).isActive = true
        infoView.topAnchor.constraint(equalTo: companyView.bottomAnchor, constant: 12).isActive = true
        infoView.rightAnchor.constraint(equalTo: scrollContainer.rightAnchor, constant: -24).isActive = true
        infoView.heightAnchor.constraint(equalToConstant: 335).isActive = true
        
        currentTimeValue.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: -24).isActive = true
        currentTimeValue.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 24).isActive = true
        currentTimeValue.widthAnchor.constraint(equalToConstant: 50).isActive = true
        currentTimeValue.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        clockIcon.rightAnchor.constraint(equalTo: currentTimeValue.leftAnchor, constant: -12).isActive = true
        clockIcon.centerYAnchor.constraint(equalTo: currentTimeValue.centerYAnchor, constant: 0).isActive = true
        clockIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        clockIcon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        calendarIcon.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 24).isActive = true
        calendarIcon.centerYAnchor.constraint(equalTo: clockIcon.centerYAnchor, constant: 0).isActive = true
        calendarIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        calendarIcon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        currentDateValue.leftAnchor.constraint(equalTo: calendarIcon.rightAnchor, constant: 12).isActive = true
        currentDateValue.centerYAnchor.constraint(equalTo: calendarIcon.centerYAnchor, constant: 0).isActive = true
        currentDateValue.rightAnchor.constraint(equalTo: clockIcon.leftAnchor, constant: -12).isActive = true
        currentDateValue.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        topSeperator.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 12).isActive = true
        topSeperator.topAnchor.constraint(equalTo: calendarIcon.bottomAnchor, constant: 24).isActive = true
        topSeperator.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: -12).isActive = true
        topSeperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        suiteLbl.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 24).isActive = true
        suiteLbl.topAnchor.constraint(equalTo: topSeperator.bottomAnchor, constant: 24).isActive = true
        suiteLbl.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: -24).isActive = true
        suiteLbl.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        suiteValue.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 24).isActive = true
        suiteValue.topAnchor.constraint(equalTo: suiteLbl.bottomAnchor, constant: 12).isActive = true
        suiteValue.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: -24).isActive = true
        suiteValue.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        streetLbl.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: -24).isActive = true
        streetLbl.topAnchor.constraint(equalTo: suiteValue.bottomAnchor, constant: 16).isActive = true
        streetLbl.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 24).isActive = true
        streetLbl.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        streetValue.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: -24).isActive = true
        streetValue.topAnchor.constraint(equalTo: streetLbl.bottomAnchor, constant: 12).isActive = true
        streetValue.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 24).isActive = true
        streetValue.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        cityLbl.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 24).isActive = true
        cityLbl.topAnchor.constraint(equalTo: streetValue.bottomAnchor, constant: 16).isActive = true
        cityLbl.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: -24).isActive = true
        cityLbl.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        cityValue.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 24).isActive = true
        cityValue.topAnchor.constraint(equalTo: cityLbl.bottomAnchor, constant: 12).isActive = true
        cityValue.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: -24).isActive = true
        cityValue.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        loadingLoader.centerXAnchor.constraint(equalTo: visitWebsiteBtn.centerXAnchor, constant: 0).isActive = true
        loadingLoader.centerYAnchor.constraint(equalTo: visitWebsiteBtn.centerYAnchor, constant: 0).isActive = true
        loadingLoader.widthAnchor.constraint(equalToConstant: 35).isActive = true
        loadingLoader.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        loadingLoader.isHidden = true
        
        let date = Date()
        
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        currentTimeValue.text = "\(hour):\(minutes)"
        
        currentDateValue.text = getCurrentDate()
        
    }
    
    var websiteToVisit: String!
    
    @objc func visitWebF(){
        
        let finalUrl = "https://" + websiteToVisit
        
        if let url = URL(string: finalUrl) {
            
            UIApplication.shared.open(url)
            
        }
        
    }
    
    func setLocationF(lat: Double, long: Double){
        
        let carLocation = CarLocation()
        
        let pastLocation = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        carLocation.latValue = lat
        carLocation.longValue = long
        
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
        
        self.map.showsCompass = true
        
        let lastLat = self.pastLocations.last!.latValue!
        let lastLong = self.pastLocations.last!.longValue!
        
        let lastLocation = CLLocationCoordinate2D(latitude: lastLat, longitude: lastLong)
        
        let lastLoc = CLLocation(latitude: lastLat, longitude: lastLong)
        
        lastLoc.fetchCityAndCountry { city, country, error in
            
            guard let city = city, let _ = country, error == nil else { return }
            
            self.cityValue.text = city
            
        }
        
        let viewRegion = MKCoordinateRegion(center: lastLocation, latitudinalMeters: 200, longitudinalMeters: 200)
        
        self.map.setRegion(viewRegion, animated: true)
        
    }
    
    var totalSpeed = 0.0
    
    var isEngineOn = true
    
    @objc func getCurrentDate() -> String {
        
        let date = Date()
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)

        let year =  components.year!
        let month = components.month!
        let day = components.day!
        
        var finalDate = "\(day)"
        
        if month == 01 || month == 1 {
            
            finalDate += " Jan, \(year)"
            
        }else if month == 02 || month == 2 {
            
            finalDate += " Feb, \(year)"
            
        }else if month == 03 || month == 3 {
            
            finalDate += " Mar, \(year)"
            
        }else if month == 04 || month == 4 {
            
            finalDate += " Apr, \(year)"
            
        }else if month == 05 || month == 5 {
            
            finalDate += " May, \(year)"
            
        }else if month == 06 || month == 6 {
            
            finalDate += " Jun, \(year)"
            
        }else if month == 07 || month == 7 {
            
            finalDate += " Jul, \(year)"
            
        }else if month == 08 || month == 8 {
            
            finalDate += " Aug, \(year)"
            
        }else if month == 09 || month == 9 {
            
            finalDate += " Sep, \(year)"
            
        }else if month == 010 || month == 10 {
            
            finalDate += " Oct, \(year)"
            
        }else if month == 011 || month == 11 {
            
            finalDate += " Nov, \(year)"
            
        }else if month == 012 || month == 12 {
            
            finalDate += " Dec, \(year)"
            
        }
        
        return finalDate
    }
    
    @objc func backF(){
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func trackF(){
        
        let vc = LiveUsersViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.newLocation = map.annotations.first!.coordinate
        
        present(vc, animated: true, completion: nil)
        
    }
    
    @objc func errorAlertF(){
        
        let alert = UIAlertController(title: "An Error Occured", message: "There was an error trying to reach the database, please try again later.", preferredStyle: .alert)
        
        let okayAction = UIAlertAction(title: "Okay", style: .default) { (action) in
            
        }
        
        alert.addAction(okayAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            
            return nil
        
        }
        
        let reuseId = "CarLocationId"
        
        var anView = map.dequeueReusableAnnotationView(withIdentifier: reuseId)
        
            if anView == nil {
                
                
                anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                
                
                anView!.canShowCallout = true
                
                let newAnnotation = annotation as! Annotation
                
                if newAnnotation.lastLocation == true {
                    
                    anView!.image = UIImage(named:"currentLocation2")?.withRenderingMode(.alwaysTemplate)
                    anView?.tintColor = .red
                    
                }else {
                    
                    anView!.image = UIImage(named:"pastLocation2")?.withRenderingMode(.alwaysTemplate)
                    anView?.tintColor = .red
                }
                
            }
            else {
                anView!.annotation = annotation
            }

        
        print("annotaiton...")
            return anView
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        /*if let location = locations.first {
            
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            
            map.setRegion(region, animated: true)
        
        }*/
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("error:: \(error)")
    }
    

}

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
