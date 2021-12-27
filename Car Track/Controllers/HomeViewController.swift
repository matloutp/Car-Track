//
//  HomeViewController.swift
//  Car Track
//
//  Created by Thapelo on 2021/12/25.
//

import UIKit
import Loaf
import FontBlaster
import Hero
import SDWebImage
import NVActivityIndicatorView

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    var verticalMenuIcons = ["logout"]
    var verticalMenuTitles = ["Logout"]
    
    var allUsers = APIUser()
    
    var trackedImageHeights = [CGFloat]()
    var trackedImageWidths = [CGFloat]()
    
    var carLicense = [String]()
    
    var carStatus = [String]()
    var carImages = [String]()
    var carModelNames = [String]()
    var carOwnerNames = [String]()
    var carBrandNames = [String]()
    
    var carOwnerIds = [String]()
    
    
    let topView: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.backgroundColor = UIColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 1)
        
        return vw
        
    }()
    
    lazy var menuBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        let img = UIImage(named: "menu")
        
        btn.setImage(img, for: .normal)
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        btn.addTarget(self, action: #selector(menuF), for: .touchUpInside)
        
        return btn
        
    }()
    
    let curvedView: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.backgroundColor = UIColor(red: 245/255, green: 244/255, blue: 249/255, alpha: 1)
        
        vw.layer.masksToBounds = true
        vw.layer.cornerRadius = 46
        
        vw.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return vw
        
    }()
    
    lazy var currentLocationLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = .white
        
        lbl.text = "current location"
        
        lbl.font = UIFont(name: "JosefinSans-Regular", size: 18)
        
        lbl.textAlignment = .center
        
        return lbl
        
    }()
    
    let navigationIcon: UIImageView = {
        
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.image = UIImage(named: "fi_navigation")
        
        img.contentMode = .scaleAspectFit
        
        return img
        
    }()
    
    lazy var currentLocationValue: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = .white
        
        lbl.text = "Typicode"
        
        lbl.font = UIFont(name: "JosefinSans-Medium", size: 21)
        
        lbl.textAlignment = .center
        
        return lbl
        
    }()
    
    lazy var notificationBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        let img = UIImage(named: "fi_bell")
        
        btn.setImage(img, for: .normal)
        
        btn.addTarget(self, action: #selector(notificationF), for: .touchUpInside)
        
        return btn
        
    }()
    
    let notificationDot: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.layer.masksToBounds = true
        vw.layer.cornerRadius = 10
        
        vw.backgroundColor = UIColor(red: 248/255, green: 216/255, blue: 74/255, alpha: 1)
        
        return vw
        
    }()
    
    lazy var numberOfNotifications: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = .black
        
        lbl.text = "1"
        
        lbl.font = UIFont(name: "JosefinSans-SemiBold", size: 14)
        
        lbl.textAlignment = .center
        
        return lbl
        
    }()
    
    let searchContainer: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.backgroundColor = .white
        
        vw.isHidden = true
        
        return vw
        
    }()
    
    lazy var cancelSearchBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.setTitle("cancel", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        
        btn.backgroundColor = .clear
        
        btn.titleLabel?.font = UIFont(name: "JosefinSans-Regular", size: 21)
        
        btn.addTarget(self, action: #selector(cancelSearchF), for: .touchUpInside)
        
        
        return btn
        
    }()
    
    let searchSeparator: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.backgroundColor = UIColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 1)
        
        vw.isHidden = true
        
        return vw
        
    }()
    
    
    let searchResultsCV: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(SearchResultsCollectionViewCell.self, forCellWithReuseIdentifier: "SearchResultsId")
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cv.backgroundColor = .white
        
        cv.isHidden = true
        
        return cv
        
    }()
    
    lazy var trackCarLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = .white
        
        lbl.text = "Track User Profiles"
        
        lbl.font = UIFont(name: "JosefinSans-SemiBold", size: 32)
        
        lbl.textAlignment = .center
        
        return lbl
        
    }()
    
    lazy var trackingNumberLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = .white
        
        lbl.text = "Please enter a name"
        
        lbl.font = UIFont(name: "JosefinSans-Regular", size: 18)
        
        lbl.textAlignment = .center
        
        return lbl
        
    }()
    
    let trackingNumberBackground: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.backgroundColor = .white
        
        vw.layer.masksToBounds = true
        vw.layer.cornerRadius = 16
        
        return vw
        
    }()
    
    let mapMarkerIcon: UIImageView = {
        
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.image = UIImage(named: "u_map-marker-plus")
        
        img.contentMode = .scaleAspectFit
        
        return img
        
    }()
    
    let searchIcon: UIImageView = {
        
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.image = UIImage(named: "fi_search")
        
        img.contentMode = .scaleAspectFit
        
        return img
        
    }()
    
    lazy var trackingNumberValue: UITextField = {
        
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        
        txt.placeholder = "Enter a name"
        
        txt.font = UIFont(name: "JosefinSans-Regular", size: 16)
        
        return txt
        
    }()
    
    let scannerBackground: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.layer.masksToBounds = true
        vw.layer.cornerRadius = 12
        
        vw.backgroundColor = .white
        
        return vw
        
    }()
    
    lazy var filterBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        let img = UIImage(named: "filter2")?.withRenderingMode(.alwaysTemplate)
        
        btn.setImage(img, for: .normal)
        
        btn.tintColor = UIColor(red: 248/255, green: 216/255, blue: 74/255, alpha: 1)
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        btn.addTarget(self, action: #selector(filterF), for: .touchUpInside)
        
        return btn
        
    }()
    
    lazy var trackedCarsLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = .black
        
        lbl.text = "All Users"
        
        lbl.font = UIFont(name: "JosefinSans-SemiBold", size: 26)
        
        lbl.textAlignment = .left
        
        return lbl
        
    }()
    
    let blackSearchIcon: UIImageView = {
        
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.image = UIImage(named: "fi_search_black")
        
        img.contentMode = .scaleAspectFit
        
        return img
        
    }()
    
    lazy var searchLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = .black
        
        lbl.text = "Search"
        
        lbl.font = UIFont(name: "JosefinSans-SemiBold", size: 21)
        
        lbl.textAlignment = .center
        
        return lbl
        
    }()
    
    lazy var searchBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 16
        
        btn.layer.borderWidth = 1.5
        btn.layer.borderColor = UIColor(red: 191/255, green: 191/255, blue: 191/255, alpha: 1).cgColor
        
        btn.addTarget(self, action: #selector(searchF), for: .touchUpInside)
        
        return btn
        
    }()
    
    let trackedCarsCV: UICollectionView = {
        
        let layout = PinterestLayout()
        layout.cellPadding = 8
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UsersCollectionViewCell.self, forCellWithReuseIdentifier: "TrackedCarsId")
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cv.backgroundColor = .clear
        
        cv.layer.masksToBounds = true
        cv.layer.cornerRadius = 12
        
        return cv
        
    }()
    
    let loadingLoader: NVActivityIndicatorView = {
        
        let vw = NVActivityIndicatorView(frame: .zero, type: .ballScaleMultiple, color: UIColor(red: 248/255, green: 216/255, blue: 74/255, alpha: 1), padding: 0)
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.layer.zPosition = 10
        
        vw.startAnimating()
        
        
        vw.isHidden = false
        
        return vw
        
    }()
    
    lazy var retryBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.setTitle("Retry", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        
        btn.backgroundColor = UIColor(red: 248/255, green: 216/255, blue: 74/255, alpha: 1)
        
        btn.titleLabel?.font = UIFont(name: "JosefinSans-Regular", size: 21)
        
        btn.addTarget(self, action: #selector(callUsersF), for: .touchUpInside)
        
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 16
        
        btn.isHidden = true
        
        return btn
        
    }()
    
    let menuBackground: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.backgroundColor = .black
        
        vw.alpha = 0.7
        
        vw.isHidden = true
        
        vw.layer.zPosition = 2
        
        return vw
        
    }()
    
    let menuSlider: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.backgroundColor = .white
        
        vw.layer.zPosition = 3
        
        
        return vw
        
    }()
    
    let verticalMenuCV: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(VerticalMenuCollectionViewCell.self, forCellWithReuseIdentifier: "VerticalMenuId")
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        cv.backgroundColor = .clear
        
        
        cv.layer.zPosition = 2
        
        return cv
        
    }()
    
    lazy var verticalMenuBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        let img = UIImage(named: "cancel")?.withRenderingMode(.alwaysTemplate)
        
        btn.setImage(img, for: .normal)
        
        btn.tintColor = .black
        
        btn.contentEdgeInsets = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
        
        btn.layer.zPosition = 5
        
        btn.addTarget(self, action: #selector(menuF), for: .touchUpInside)
        
        return btn
        
    }()
    
    let menuLine: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.backgroundColor = UIColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 1)
        
        return vw
        
    }()
    
    
    
    var rightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*if let userName = UserDefaults.standard.object(forKey: "userName") as? String {
            
            self.welcomeLbl.text = "Hi, " + userName
            
        }*/
        
        setup()
    }
    
    var style:UIStatusBarStyle = .lightContent
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return style
        
    }
    
    var bottomToCurvedConstraint: NSLayoutConstraint!
    var bottomToSearchContainerConstraint: NSLayoutConstraint!

    func setup(){
        
        //view.hero.isEnabled = true
        
        FontBlaster.blast()
        
        view.backgroundColor = .white
        
        view.addSubview(topView)
        
        topView.addSubview(menuBtn)
        
        view.addSubview(curvedView)
        
        topView.addSubview(currentLocationLbl)
        topView.addSubview(navigationIcon)
        topView.addSubview(currentLocationValue)
        topView.addSubview(notificationBtn)
        topView.addSubview(notificationDot)
        topView.addSubview(numberOfNotifications)
        topView.addSubview(searchContainer)
        
        searchContainer.addSubview(cancelSearchBtn)
        
        
        topView.addSubview(trackCarLbl)
        topView.addSubview(trackingNumberLbl)
        topView.addSubview(trackingNumberBackground)
        trackingNumberBackground.addSubview(mapMarkerIcon)
        trackingNumberBackground.addSubview(searchIcon)
        trackingNumberBackground.addSubview(trackingNumberValue)
        topView.addSubview(scannerBackground)
        scannerBackground.addSubview(filterBtn)
        
        trackingNumberValue.delegate = self
        
        curvedView.addSubview(trackedCarsLbl)
        curvedView.addSubview(blackSearchIcon)
        curvedView.addSubview(searchLbl)
        curvedView.addSubview(searchBtn)
        
        curvedView.addSubview(trackedCarsCV)
        
        curvedView.addSubview(loadingLoader)
        curvedView.addSubview(retryBtn)
        
        view.addSubview(searchSeparator)
        view.addSubview(searchResultsCV)
        
        view.addSubview(menuBackground)
        view.addSubview(menuSlider)
        menuSlider.addSubview(verticalMenuCV)
        menuSlider.addSubview(verticalMenuBtn)
        menuSlider.addSubview(menuLine)
        
        trackedCarsCV.delegate = self
        trackedCarsCV.dataSource = self
        
        searchResultsCV.delegate = self
        searchResultsCV.dataSource = self
        
        verticalMenuCV.delegate = self
        verticalMenuCV.dataSource = self
        
        topView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        topView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        topView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 395).isActive = true

        menuBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 55).isActive = true
        menuBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        menuBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        menuBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true

        curvedView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -60).isActive = true
        curvedView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        curvedView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        curvedView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        
        notificationDot.topAnchor.constraint(equalTo: menuBtn.topAnchor, constant: 0).isActive = true
        notificationDot.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        notificationDot.widthAnchor.constraint(equalToConstant: 20).isActive = true
        notificationDot.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        numberOfNotifications.centerYAnchor.constraint(equalTo: notificationDot.centerYAnchor, constant: 0).isActive = true
        numberOfNotifications.centerXAnchor.constraint(equalTo: notificationDot.centerXAnchor, constant: 0).isActive = true
        numberOfNotifications.widthAnchor.constraint(equalToConstant: 20).isActive = true
        numberOfNotifications.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        notificationBtn.topAnchor.constraint(equalTo: notificationDot.centerYAnchor, constant: -24).isActive = true
        notificationBtn.rightAnchor.constraint(equalTo: notificationDot.centerXAnchor, constant: 24).isActive = true
        notificationBtn.widthAnchor.constraint(equalToConstant: 70).isActive = true
        notificationBtn.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        
        currentLocationLbl.topAnchor.constraint(equalTo: menuBtn.topAnchor, constant: 6).isActive = true
        currentLocationLbl.leftAnchor.constraint(equalTo: menuBtn.rightAnchor, constant: 12).isActive = true
        currentLocationLbl.rightAnchor.constraint(equalTo: notificationBtn.leftAnchor, constant: -12).isActive = true
        currentLocationLbl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        currentLocationValue.topAnchor.constraint(equalTo: currentLocationLbl.bottomAnchor, constant: 0).isActive = true
        currentLocationValue.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        currentLocationValue.widthAnchor.constraint(equalToConstant: 100).isActive = true
        currentLocationValue.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        navigationIcon.centerYAnchor.constraint(equalTo: currentLocationValue.centerYAnchor, constant: 0).isActive = true
        navigationIcon.rightAnchor.constraint(equalTo: currentLocationValue.leftAnchor, constant: 0).isActive = true
        navigationIcon.widthAnchor.constraint(equalToConstant: 16).isActive = true
        navigationIcon.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        searchContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        searchContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        searchContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        searchContainer.heightAnchor.constraint(equalToConstant: 95).isActive = true
        
        cancelSearchBtn.bottomAnchor.constraint(equalTo: searchContainer.bottomAnchor, constant: -14).isActive = true
        cancelSearchBtn.widthAnchor.constraint(equalToConstant: 90).isActive = true
        cancelSearchBtn.rightAnchor.constraint(equalTo: searchContainer.rightAnchor, constant: -12).isActive = true
        cancelSearchBtn.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        trackCarLbl.topAnchor.constraint(equalTo: currentLocationValue.bottomAnchor, constant: 12).isActive = true
        trackCarLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        trackCarLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        trackCarLbl.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        trackingNumberLbl.topAnchor.constraint(equalTo: trackCarLbl.bottomAnchor, constant: 12).isActive = true
        trackingNumberLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        trackingNumberLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        trackingNumberLbl.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        scannerBackground.bottomAnchor.constraint(equalTo: curvedView.topAnchor, constant: -32).isActive = true
        scannerBackground.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        scannerBackground.widthAnchor.constraint(equalToConstant: 65).isActive = true
        scannerBackground.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        filterBtn.centerXAnchor.constraint(equalTo: scannerBackground.centerXAnchor, constant: 0).isActive = true
        filterBtn.centerYAnchor.constraint(equalTo: scannerBackground.centerYAnchor, constant: 0).isActive = true
        filterBtn.widthAnchor.constraint(equalToConstant: 55).isActive = true
        filterBtn.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        bottomToCurvedConstraint = trackingNumberBackground.bottomAnchor.constraint(equalTo: curvedView.topAnchor, constant: -32)
        bottomToCurvedConstraint.isActive = true
        bottomToSearchContainerConstraint = trackingNumberBackground.bottomAnchor.constraint(equalTo: searchContainer.bottomAnchor, constant: -4)
        bottomToSearchContainerConstraint.isActive = false
        trackingNumberBackground.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        trackingNumberBackground.heightAnchor.constraint(equalToConstant: 55).isActive = true
        trackingNumberBackground.rightAnchor.constraint(equalTo: scannerBackground.leftAnchor, constant: -12).isActive = true
        
        mapMarkerIcon.leftAnchor.constraint(equalTo: trackingNumberBackground.leftAnchor, constant: 12).isActive = true
        mapMarkerIcon.centerYAnchor.constraint(equalTo: trackingNumberBackground.centerYAnchor, constant: 0).isActive = true
        mapMarkerIcon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        mapMarkerIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        searchIcon.rightAnchor.constraint(equalTo: trackingNumberBackground.rightAnchor, constant: -12).isActive = true
        searchIcon.centerYAnchor.constraint(equalTo: trackingNumberBackground.centerYAnchor, constant: 0).isActive = true
        searchIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        searchIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        trackingNumberValue.centerYAnchor.constraint(equalTo: trackingNumberBackground.centerYAnchor, constant: 0).isActive = true
        trackingNumberValue.leftAnchor.constraint(equalTo: mapMarkerIcon.rightAnchor, constant: 12).isActive = true
        trackingNumberValue.heightAnchor.constraint(equalToConstant: 75).isActive = true
        trackingNumberValue.rightAnchor.constraint(equalTo: searchIcon.leftAnchor, constant: -12).isActive = true
        
        searchLbl.rightAnchor.constraint(equalTo: curvedView.rightAnchor, constant: -42).isActive = true
        searchLbl.topAnchor.constraint(equalTo: curvedView.topAnchor, constant: 32).isActive = true
        searchLbl.widthAnchor.constraint(equalToConstant: 80).isActive = true
        searchLbl.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        blackSearchIcon.rightAnchor.constraint(equalTo: searchLbl.leftAnchor, constant: -6).isActive = true
        blackSearchIcon.centerYAnchor.constraint(equalTo: searchLbl.centerYAnchor, constant: 0).isActive = true
        blackSearchIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        blackSearchIcon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        searchBtn.rightAnchor.constraint(equalTo: searchLbl.rightAnchor, constant: 12).isActive = true
        searchBtn.centerYAnchor.constraint(equalTo: searchLbl.centerYAnchor, constant: 0).isActive = true
        searchBtn.leftAnchor.constraint(equalTo: blackSearchIcon.leftAnchor, constant: -12).isActive = true
        searchBtn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        trackedCarsLbl.rightAnchor.constraint(equalTo: searchBtn.leftAnchor, constant: -24).isActive = true
        trackedCarsLbl.centerYAnchor.constraint(equalTo: searchLbl.centerYAnchor, constant: 0).isActive = true
        trackedCarsLbl.leftAnchor.constraint(equalTo: curvedView.leftAnchor, constant: 32).isActive = true
        trackedCarsLbl.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        trackedCarsCV.rightAnchor.constraint(equalTo: searchBtn.rightAnchor, constant: 12).isActive = true
        trackedCarsCV.topAnchor.constraint(equalTo: searchBtn.bottomAnchor, constant: 24).isActive = true
        trackedCarsCV.leftAnchor.constraint(equalTo: trackedCarsLbl.leftAnchor, constant: -12).isActive = true
        trackedCarsCV.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24).isActive = true

        loadingLoader.centerXAnchor.constraint(equalTo: trackedCarsCV.centerXAnchor, constant: 0).isActive = true
        loadingLoader.centerYAnchor.constraint(equalTo: trackedCarsCV.centerYAnchor, constant: 0).isActive = true
        loadingLoader.widthAnchor.constraint(equalToConstant: 35).isActive = true
        loadingLoader.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        retryBtn.centerXAnchor.constraint(equalTo: trackedCarsCV.centerXAnchor, constant: 0).isActive = true
        retryBtn.centerYAnchor.constraint(equalTo: trackedCarsCV.centerYAnchor, constant: 0).isActive = true
        retryBtn.widthAnchor.constraint(equalToConstant: 145).isActive = true
        retryBtn.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        searchSeparator.topAnchor.constraint(equalTo: searchContainer.bottomAnchor, constant: 0).isActive = true
        searchSeparator.leftAnchor.constraint(equalTo: searchContainer.leftAnchor, constant: 0).isActive = true
        searchSeparator.rightAnchor.constraint(equalTo: searchContainer.rightAnchor, constant: 0).isActive = true
        searchSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        searchResultsCV.topAnchor.constraint(equalTo: searchSeparator.bottomAnchor, constant: 0).isActive = true
        searchResultsCV.leftAnchor.constraint(equalTo: searchContainer.leftAnchor, constant: 0).isActive = true
        searchResultsCV.rightAnchor.constraint(equalTo: searchContainer.rightAnchor, constant: 0).isActive = true
        searchResultsCV.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        menuBackground.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        menuBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        menuBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        menuBackground.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
        menuSlider.widthAnchor.constraint(equalToConstant: view.frame.width / 1.5).isActive = true
        menuSlider.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        menuSlider.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        rightConstraint = menuSlider.rightAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
        rightConstraint.isActive = true
        
        
        verticalMenuCV.leftAnchor.constraint(equalTo: menuSlider.leftAnchor).isActive = true
        verticalMenuCV.topAnchor.constraint(equalTo: menuBtn.bottomAnchor, constant: 24).isActive = true
        verticalMenuCV.bottomAnchor.constraint(equalTo: menuSlider.bottomAnchor, constant: 0).isActive = true
        verticalMenuCV.rightAnchor.constraint(equalTo: menuSlider.rightAnchor, constant: 0).isActive = true
        
        verticalMenuBtn.leftAnchor.constraint(equalTo: menuSlider.leftAnchor, constant: 24).isActive = true
        verticalMenuBtn.centerYAnchor.constraint(equalTo: menuBtn.centerYAnchor, constant: 0).isActive = true
        verticalMenuBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        verticalMenuBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        menuLine.leftAnchor.constraint(equalTo: menuSlider.leftAnchor, constant: 0).isActive = true
        menuLine.topAnchor.constraint(equalTo: verticalMenuBtn.bottomAnchor, constant: 10).isActive = true
        menuLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        menuLine.rightAnchor.constraint(equalTo: menuSlider.rightAnchor, constant: 0).isActive = true
        
        
        if let layout = trackedCarsCV.collectionViewLayout as? PinterestLayout {
            
            layout.delegate = self
            
        }
        
        
        callUsersF()
        
    }
    
    var allSearchedUsers = APIUser()
    
    var textFieldHighlighted = false
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        highlightForSearch()
        
    }
    
    @objc func highlightForSearch(){
        
        if textFieldHighlighted == false {
            
            textFieldHighlighted = true
            
            bottomToCurvedConstraint.isActive = false
            bottomToSearchContainerConstraint.isActive = true
            
            self.style = .darkContent
            
            setNeedsStatusBarAppearanceUpdate()
            
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut) {
                
                self.view.layoutIfNeeded()
                
                self.searchContainer.isHidden = false
                
            } completion: { (true) in
                
                self.searchResultsCV.isHidden = false
                self.searchSeparator.isHidden = false
                
            }
            
        }
        
    }
    
    var filterBy = "name"
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if filterBy == "name" {
            
            allSearchedUsers = allUsers.filter({ $0.name.contains(textField.text!)})
            
        }else if filterBy == "username" {
            
            allSearchedUsers = allUsers.filter({ $0.username.contains(textField.text!)})
            
        }else if filterBy == "companyName" {
            
            allSearchedUsers = allUsers.filter({ $0.company.name.contains(textField.text!)})
            
        }else if filterBy == "email" {
            
            allSearchedUsers = allUsers.filter({ $0.email.contains(textField.text!)})
            
        }
        
        searchResultsCV.reloadData()
        
        return true
        
    }
    
    @objc func cancelSearchF(){
        
        trackingNumberValue.text = ""
        
        textFieldHighlighted = false
        
        self.style = .lightContent
        
        setNeedsStatusBarAppearanceUpdate()
        
        bottomToCurvedConstraint.isActive = true
        bottomToSearchContainerConstraint.isActive = false
        
        trackingNumberValue.endEditing(true)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            
            self.view.layoutIfNeeded()
            
            self.searchContainer.isHidden = true
            self.searchResultsCV.isHidden = true
            self.searchSeparator.isHidden = true
            
        } completion: { (true) in
            
            
            
        }
        
    }
    
    @objc func callUsersF(){
        
        self.loadingLoader.isHidden = false
        self.retryBtn.isHidden = true
        
        let jsonURLString = "https://jsonplaceholder.typicode.com/users"
        
        guard let url = URL(string: jsonURLString) else {
            
            
            return
            
        }
        
        URLSession.shared.dataTask(with: url){ [self](data, response, error) in
            
            
            if error != nil {
                
                DispatchQueue.main.async {
                    
                    self.loadingLoader.isHidden = true
                    
                    self.retryBtn.isHidden = false
                    
                    Loaf("Error fetching data.", state: .error, location: .top, presentingDirection: .vertical, dismissingDirection: .right, sender: self).show()
                    
                }
                
                
            }
            
            guard let data = data else {return}
            
            
            let dataString = String(data: data, encoding: .utf8)
            
            do {

                
                let jsonData = dataString!.data(using: .utf8)!
                
                guard let stepByStep = try JSONDecoder().decode(APIUser?.self, from: jsonData) else {
                    
                    DispatchQueue.main.async {
                        
                        self.loadingLoader.isHidden = true
                        
                        self.retryBtn.isHidden = false
                        
                        Loaf("Error fetching data. Invalid data may be entered", state: .error, location: .top, presentingDirection: .vertical, dismissingDirection: .right, sender: self).show()
                        
                    }
                    
                    
                    
                    return
                }
                
                
                
                DispatchQueue.main.async {

                    self.loadingLoader.isHidden = true
                    
                    self.allUsers = stepByStep
                    
                    for _ in self.allUsers {
                        
                        self.trackedImageWidths.append(450)
                        self.trackedImageHeights.append(450)
                        
                    }
                    
                    self.trackedCarsCV.reloadData()
                    
                    
                }
                
            } catch let jsnError{
                
                print("Error serializing json", jsnError)
                
                DispatchQueue.main.async {
                    
                    self.loadingLoader.isHidden = true
                    
                    self.retryBtn.isHidden = false
                    
                    Loaf("Error fetching data. Invalid data may be entered", state: .error, location: .top, presentingDirection: .vertical, dismissingDirection: .right, sender: self).show()
                }
                
                
            }
            
            
            }.resume()
        
    }
    
    var reloadingCarsTimer = Timer()
    
    var snapshotCount = 0
    
    @objc func fetchTrackedCars(){
        
        
    }
    
    @objc func reloadCarsTable(){
        
        trackedCarsCV.reloadData()
        
        if let layout = trackedCarsCV.collectionViewLayout as? PinterestLayout {
            
            layout.invalidateLayout()
            
        }
        
        trackedCarsCV.layoutSubviews()
        
        print(trackedCarsCV.numberOfItems(inSection: 0))
        
    }
    
    var menuOpen = false
    
    @objc func menuF(){
        
        if menuOpen == false {
            
            
            rightConstraint.constant = view.frame.width / 1.5
            menuBackground.isHidden = false
            
            let img = UIImage(named: "cancel")?.withRenderingMode(.alwaysTemplate)
            
            menuBtn.setImage(img, for: .normal)
            
            menuBtn.tintColor = UIColor(red: 48/255, green: 70/255, blue: 246/255, alpha: 1)
            
            UIView.animate(withDuration: 0.5) {
                
                self.view.layoutIfNeeded()
                
                self.style = .darkContent
                
                self.setNeedsStatusBarAppearanceUpdate()
                
                
            }
            
            menuOpen = true
            
        }else {
            
            rightConstraint.constant = 0
            menuBackground.isHidden = true
            
            let img = UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate)
            
            menuBtn.setImage(img, for: .normal)
            
            menuBtn.tintColor = .white
            
            
            UIView.animate(withDuration: 0.5) {
                
                self.view.layoutIfNeeded()
                
                self.style = .lightContent
                
                self.setNeedsStatusBarAppearanceUpdate()
                
            }
            
            
            menuOpen = false
            
        }
        
    }
    
    @objc func notificationF(){
        
        numberOfNotifications.text = "0"
        numberOfNotifications.isHidden = true
        notificationDot.isHidden = true
        
        let notificationController = UIAlertController(title: "No Notifications", message: "You do not have any notifications for now.", preferredStyle: .alert)
        
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        notificationController.addAction(okayAction)
        
        present(notificationController, animated: true, completion: nil)
        
        
    }
    
    @objc func filterF(){
        
        let filterController = UIAlertController(title: "Search By", message: nil, preferredStyle: .actionSheet)
        
        let nameAction = UIAlertAction(title: "Name", style: .default) { (action) in
            
            self.filterBy = "name"
            self.trackingNumberValue.placeholder = "Enter a name"
            self.trackingNumberLbl.text = "Please enter a name"
            
        }
        
        let userNameAction = UIAlertAction(title: "Username", style: .default) { (action) in
            
            self.filterBy = "username"
            self.trackingNumberValue.placeholder = "Enter a username"
            self.trackingNumberLbl.text = "Please enter a username"
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
            
        }
        
        filterController.addAction(nameAction)
        filterController.addAction(userNameAction)
        filterController.addAction(cancelAction)
        
        present(filterController, animated: true, completion: nil)
        
    }
    
    @objc func searchF(){
        
        highlightForSearch()
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == trackedCarsCV {
            
            return allUsers.count
            
        }else if collectionView == searchResultsCV {
            
            return allSearchedUsers.count
            
        } else if collectionView == verticalMenuCV {
            
            return verticalMenuIcons.count
            
        } else {
            
            return 9
            
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == trackedCarsCV {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrackedCarsId", for: indexPath) as! UsersCollectionViewCell
            
            cell.homeVC = self
            
            cell.companyName.text = allUsers[indexPath.row].company.name
            cell.userName.text = allUsers[indexPath.row].username
            
            cell.userFullName.text = allUsers[indexPath.row].name
            
            return cell
            
        } else if collectionView == searchResultsCV {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchResultsId", for: indexPath) as! SearchResultsCollectionViewCell
            
            cell.homeVC = self
            
            cell.userFullName.text = allSearchedUsers[indexPath.row].name
            cell.userName.text = allSearchedUsers[indexPath.row].username
            
            
            return cell
            
        } else if collectionView == verticalMenuCV {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VerticalMenuId", for: indexPath) as! VerticalMenuCollectionViewCell
            
            cell.menuIcon.image = UIImage(named: verticalMenuIcons[indexPath.row])?.withRenderingMode(.alwaysTemplate)
            
            cell.menuIcon.tintColor = UIColor(red: 51/255, green: 60/255, blue: 131/255, alpha: 1)
            
            cell.menuLbl.text = verticalMenuTitles[indexPath.row]
            cell.menuLbl.textColor = UIColor(red: 51/255, green: 60/255, blue: 131/255, alpha: 1)
            
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 42
            
            
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrackedCarsId", for: indexPath) as! UsersCollectionViewCell
            
            return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == trackedCarsCV {
            
            let size = CGSize(width: view.frame.width / 2 - 40, height: 450)
            
            return size
            
        }else if collectionView == searchResultsCV {
            
            let size = CGSize(width: view.frame.width, height: 90)
            
            return size
            
        } else if collectionView == verticalMenuCV {
            
            let size = CGSize(width: (view.frame.width / 1.5) - 24, height: 55)
            
            return size
            
        }else {
            
            let size = CGSize(width: view.frame.width - 130, height: 55)
            
            return size
            
        }
        
    }
    
    @objc func viewTrackedCarF(cell: UICollectionViewCell){
        
        let cell = cell as! UsersCollectionViewCell
        
        let uuid = UUID().uuidString
        
        cell.userImage.hero.id = uuid
        
        let vc = ViewUserViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.userImage.hero.id = uuid
        vc.userImage.image = cell.userImage.image
        
        present(vc, animated: false, completion: nil)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == trackedCarsCV {
            
            let uuid = UUID().uuidString
            
            let cell = trackedCarsCV.cellForItem(at: indexPath) as! UsersCollectionViewCell
            
            cell.userImage.hero.id = uuid
            
            let vc = ViewUserViewController()
            vc.hero.isEnabled = true
            vc.modalPresentationStyle = .fullScreen
            
            vc.setLocationF(lat: Double(allUsers[indexPath.row].address.geo.lat)!, long: Double(allUsers[indexPath.row].address.geo.lng)!)
            
            
            vc.userImage.image = cell.userImage.image
            vc.userName.text = cell.userName.text
            vc.userFullName.text = cell.userFullName.text
            
            vc.ownerId = "\(allUsers[indexPath.row].id)"
            vc.streetValue.text = allUsers[indexPath.row].address.street
            vc.suiteValue.text = allUsers[indexPath.row].address.suite
            vc.cityValue.text = allUsers[indexPath.row].address.city
            
            vc.userPhone.text = allUsers[indexPath.row].phone
            vc.userEmail.text = allUsers[indexPath.row].email
            
            vc.companyName.text = allUsers[indexPath.row].company.name
            vc.catchPhrase.text = allUsers[indexPath.row].company.catchPhrase
            vc.bsLbl.text = allUsers[indexPath.row].company.bs
            
            vc.websiteToVisit = allUsers[indexPath.row].website
            
            vc.userImage.hero.id = uuid
            
            present(vc, animated: true, completion: nil)
            
        } else if collectionView == searchResultsCV {
            
            let uuid = UUID().uuidString
            
            let cell = searchResultsCV.cellForItem(at: indexPath) as! SearchResultsCollectionViewCell
            
            cell.userImage.hero.id = uuid
            
            let vc = ViewUserViewController()
            vc.hero.isEnabled = true
            vc.modalPresentationStyle = .fullScreen
            
            vc.setLocationF(lat: Double(allUsers[indexPath.row].address.geo.lat)!, long: Double(allUsers[indexPath.row].address.geo.lng)!)
            
            
            vc.userImage.image = cell.userImage.image
            vc.userName.text = allSearchedUsers[indexPath.row].username
            vc.userFullName.text = allSearchedUsers[indexPath.row].name
            
            vc.ownerId = "\(allSearchedUsers[indexPath.row].id)"
            vc.streetValue.text = allSearchedUsers[indexPath.row].address.street
            vc.suiteValue.text = allSearchedUsers[indexPath.row].address.suite
            vc.cityValue.text = allSearchedUsers[indexPath.row].address.city
            
            vc.userPhone.text = allSearchedUsers[indexPath.row].phone
            vc.userEmail.text = allSearchedUsers[indexPath.row].email
            
            vc.companyName.text = allSearchedUsers[indexPath.row].company.name
            vc.catchPhrase.text = allSearchedUsers[indexPath.row].company.catchPhrase
            vc.bsLbl.text = allSearchedUsers[indexPath.row].company.bs
            
            vc.websiteToVisit = allSearchedUsers[indexPath.row].website
            
            vc.userImage.hero.id = uuid
            
            present(vc, animated: true, completion: nil)
            
        } else if collectionView == verticalMenuCV {
            
            let row = indexPath.row
            
            if row == 0 {
                
                let vc = LoginViewController()
                vc.modalPresentationStyle = .fullScreen
                
                UserDefaults().set(false, forKey: "userRegistered")
                
                present(vc, animated: true, completion: nil)
                
            }
            
        } else {
            
            
        }
        
    }
    
    private func estimatedFrameForLabel(text: String) -> CGRect {
        
        let size = CGSize(width: 200, height: 1000)
        
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "JosefinSans-Bold", size: 19)]
        
        
        return NSString(string: text).boundingRect(with: size, options: options, attributes: attributes as [NSAttributedString.Key : Any], context: nil)
        
    }

}

extension HomeViewController: PinterestLayoutDelegate {
    
  func collectionView(
      _ collectionView: UICollectionView,
      heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
    
    let finalHeight = estimatedFrameForLabel(text: self.allUsers[indexPath.row].name).height + 275
    
    return finalHeight
    
  }
}
