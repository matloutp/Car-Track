//
//  LoginViewController.swift
//  Car Track
//
//  Created by Thapelo on 2021/12/22.
//

import UIKit
import FontBlaster
import Hero

class LoginViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var countryNames = ["South Africa", "Mozambiquue", "Tanzania", "Namibia", "Kenya", "Spain", "Poland", "Portugal", "USA", "New Zealand", "United Kingdom", "Canada", "Australia"]
    
    var countryFlags = ["za", "mz", "tz", "na", "ke", "es", "pl", "pt", "us", "nz", "gb", "ca", "au"]
    
    var viewModel: NewUserViewModel!
    
    let topImage: UIImageView = {
        
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.image = UIImage(named: "logoImage")
        img.contentMode = .scaleAspectFill
        
        
        return img
    }()
    
    let overlay: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.backgroundColor = .black
        vw.alpha = 0.6
        
        return vw
    }()
    
    lazy var contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 430)
    
    let signUpLine: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.backgroundColor = .white
        
        return vw
    }()
    
    lazy var signUpLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = "Sign Up"
        
        lbl.font = UIFont(name: "JosefinSans-Medium", size: 40)
        
        lbl.layer.zPosition = 3
        
        lbl.textColor = .black
        
        return lbl
        
    }()
    
    let topImageTheme: UIImageView = {
        
        let logo = UIImageView()
        logo.image = UIImage(named: "blackWave")
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFit
        
        logo.layer.zPosition = 2
        
        return logo

    }()
    
    lazy var fullNameLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = "Name"
        
        lbl.font = UIFont(name: "JosefinSans-Light", size: 21)
        
        lbl.textColor = .black
        
        return lbl
    }()
    
    lazy var fullName: UITextField = {
        
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "Full Name"
        
        txt.textColor = .black
        
        txt.attributedPlaceholder = NSAttributedString(string: "Full Name",
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        txt.font = UIFont(name: "JosefinSans-Light", size: 21)
        
        txt.backgroundColor = .clear
        
        return txt
        
    }()
    
    lazy var emailLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = "Email"
        
        lbl.textColor = .black
        
        lbl.font = UIFont(name: "JosefinSans-Light", size: 21)
        
        return lbl
    }()
    
    lazy var email: UITextField = {
        
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "Email"
        
        txt.font = UIFont(name: "JosefinSans-Light", size: 21)
        
        txt.textColor = .black
        
        txt.attributedPlaceholder = NSAttributedString(string: "Johndoe@gmail.com",
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        
        
        return txt
        
    }()
    
    lazy var username: UITextField = {
        
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "Username"
        
        txt.font = UIFont(name: "JosefinSans-Light", size: 21)
        
        txt.textColor = .black
        
        txt.attributedPlaceholder = NSAttributedString(string: "Full Name",
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        return txt
        
    }()
    
    lazy var passwordLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = "Password"
        
        lbl.textColor = .black
        
        lbl.font = UIFont(name: "JosefinSans-Light", size: 21)
        
        return lbl
    }()
    
    
    lazy var password: UITextField = {
        
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "Password"
        
        txt.textColor = .black
        
        txt.attributedPlaceholder = NSAttributedString(string: "••••••",
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        txt.font = UIFont(name: "JosefinSans-Light", size: 21)
        
        
        
        
        return txt
        
    }()
    
    lazy var countryLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = "Country"
        
        lbl.textColor = .black
        
        lbl.font = UIFont(name: "JosefinSans-Light", size: 21)
        
        return lbl
    }()
    
    
    
    let countryContainer: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.backgroundColor = .white
        
        vw.layer.shadowColor = UIColor.black.cgColor
        vw.layer.shadowOpacity = 1
        vw.layer.shadowOffset = .zero
        vw.layer.shadowRadius = 10
        
        vw.layer.masksToBounds = true
        vw.layer.cornerRadius = 8
        
        return vw
        
    }()
    
    let countryImage: UIImageView = {
        
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.image = UIImage(named: "za")
        img.contentMode = .scaleAspectFit
        
        
        return img
    }()
    
    let dropDownImage: UIImageView = {
        
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.image = UIImage(named: "dropDown")
        img.contentMode = .scaleAspectFit
        
        
        return img
    }()
    
    lazy var countryName: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = "South Africa"
        
        lbl.textColor = .black
        
        lbl.font = UIFont(name: "JosefinSans-Light", size: 16)
        
        lbl.textAlignment = NSTextAlignment.left
        
        lbl.layer.masksToBounds = true
        lbl.layer.cornerRadius = 12
        
        return lbl
    }()
    
    let countryCV: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CountriesCollectionViewCell.self, forCellWithReuseIdentifier: "CountriesId")
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        cv.backgroundColor = .clear
        
        cv.isHidden = true
        
        cv.layer.zPosition = 2
        
        return cv
        
    }()
    
    lazy var selectCountryBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .clear
        
        
        btn.addTarget(self, action: #selector(selectCountryF), for: .touchUpInside)
        
        
        return btn
    }()
    
    lazy var aboutYouValue: UITextField = {
        
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "Architecture Enthusiast"
        
        txt.textColor = .black
        
        txt.attributedPlaceholder = NSAttributedString(string: "Architecture Enthusiast",
                                                       attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        txt.font = UIFont(name: "JosefinSans-Light", size: 21)
        
        
        
        
        return txt
        
    }()
    
    lazy var characterCountLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = "25"
        
        lbl.textColor = .white
        
        lbl.font = UIFont(name: "JosefinSans-Light", size: 12)
        
        lbl.textAlignment = NSTextAlignment.center
        
        lbl.layer.masksToBounds = true
        lbl.layer.cornerRadius = 12
        
        lbl.backgroundColor = UIColor(red: 71/255, green: 68/255, blue: 69/255, alpha: 0.8)
        
        return lbl
    }()
    
    
    lazy var createBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor(red: 250/255, green: 251/255, blue: 252/255, alpha: 1)
        btn.setTitle("SIGN UP", for: .normal)
        
        btn.setTitleColor(.black, for: .normal)
        
        btn.addTarget(self, action: #selector(loginRegister), for: .touchUpInside)
        
        btn.titleLabel?.font = UIFont(name: "JosefinSans-Light", size: 21)
        
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 8
        
        btn.layer.borderColor = UIColor(red: 146/255, green: 148/255, blue: 151/255, alpha: 1).cgColor
        btn.layer.borderWidth = 1
        
        btn.layer.zPosition = 2
        
        return btn
    }()
    
    lazy var switchBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .clear
        btn.setTitleColor(.lightGray, for: .normal)
        
        btn.addTarget(self, action: #selector(switchF), for: .touchUpInside)
        
        let title = NSMutableAttributedString(string: "Already have an account ? ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        let signInString = NSMutableAttributedString(string: "Sign In ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        
        btn.titleLabel?.font = UIFont(name: "JosefinSans-Light", size: 21)
        
        title.append(signInString)
        
        btn.setAttributedTitle(title, for: .normal)
        
        return btn
    }()
    
    lazy var termsAndConditionsLbl: UITextView = {
        
        let lbl = UITextView()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        
        lbl.backgroundColor = .clear
        
        lbl.font = UIFont(name: "JosefinSans-Light", size: 16)
        
        let fontSize = CGFloat(16)
        
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "JosefinSans-Light", size: fontSize)! ]
        
        let attributedString = NSMutableAttributedString(string: "By continuing, you agree to our ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont(name: "JosefinSans-Light", size: fontSize)!])
        
        let secondString = NSMutableAttributedString(string: "Terms of service ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "JosefinSans-Light", size: fontSize)!])
        
        secondString.addAttribute(.link, value: "https://www.apple.com/za/legal/internet-services/terms/site.html", range: NSRange(location: 0, length: Int(fontSize)))
        
        let andString = NSMutableAttributedString(string: "and ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont(name: "JosefinSans-Light", size: fontSize)!])
        
        
        let thirdString = NSMutableAttributedString(string: "Privacy Policy.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "JosefinSans-Light", size: fontSize)!])
        thirdString.addAttribute(.link, value: "https://www.apple.com/legal/privacy/en-ww/", range: NSRange(location: 0, length: 14))
        
        
        attributedString.append(secondString)
        attributedString.append(andString)
        attributedString.append(thirdString)
        
        lbl.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "JosefinSans-Light", size: fontSize)!]


        lbl.attributedText = attributedString
        
        lbl.textAlignment = NSTextAlignment.left
        
        lbl.isEditable = false
        
        return lbl
    }()
    
    let loadingLoader: UIActivityIndicatorView = {
        
        let img = UIActivityIndicatorView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = .black
        img.color = .black
    
        img.startAnimating()
        img.alpha = 0
        
        img.layer.zPosition = 7
        
        return img
        
    }()

    lazy var topScrollView: UIScrollView = {
        
        let sV = UIScrollView(frame: .zero)
        sV.translatesAutoresizingMaskIntoConstraints = false
        sV.backgroundColor = .clear
        sV.contentSize = contentSize
        sV.frame = self.view.bounds
        sV.layer.zPosition = 1
        
        
        return sV
        
    }()
    
    let loginContainer: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        return vw
    }()
    lazy var scrollViewContainer: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.frame.size = contentSize
        return vw
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        
    }
    
    var bottomConstraint: NSLayoutConstraint?
    
    var countryContainerHeightConstraint: NSLayoutConstraint!
    
    func setup(){
        
        createTable()
        
        FontBlaster.blast()
        
        view.backgroundColor = UIColor(red: 243/255, green: 244/255, blue: 246/255, alpha: 1)
        
        view.addSubview(topImage)
        
        view.addSubview(topScrollView)
        topScrollView.addSubview(loginContainer)
        
        loginContainer.addSubview(signUpLine)
        loginContainer.addSubview(signUpLbl)
        
        loginContainer.addSubview(fullNameLbl)
        loginContainer.addSubview(fullName)
        loginContainer.addSubview(emailLbl)
        loginContainer.addSubview(email)
        
        loginContainer.addSubview(passwordLbl)
        loginContainer.addSubview(password)
        
        loginContainer.addSubview(countryLbl)
        loginContainer.addSubview(countryContainer)
        
        countryContainer.addSubview(countryImage)
        countryContainer.addSubview(dropDownImage)
        countryContainer.addSubview(countryName)
        
        countryContainer.addSubview(countryCV)
        
        loginContainer.addSubview(selectCountryBtn)
        
        loginContainer.addSubview(createBtn)
        loginContainer.addSubview(switchBtn)
        loginContainer.addSubview(termsAndConditionsLbl)
        
        loginContainer.addSubview(loadingLoader)
        
        aboutYouValue.delegate = self
        
        countryCV.delegate = self
        countryCV.dataSource = self
        
        topImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        topImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        topImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
        
        topScrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topScrollView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        topScrollView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        topScrollView.topAnchor.constraint(equalTo: topImage.bottomAnchor, constant: 26).isActive = true
        
        loginContainer.centerXAnchor.constraint(equalTo: topScrollView.centerXAnchor).isActive = true
        loginContainer.heightAnchor.constraint(equalToConstant: view.frame.height + 180).isActive = true
        loginContainer.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        bottomConstraint = loginContainer.centerYAnchor.constraint(equalTo: topScrollView.centerYAnchor, constant: 0)
        bottomConstraint?.isActive = true
        
        signUpLine.leftAnchor.constraint(equalTo: loginContainer.leftAnchor, constant: 54).isActive = true
        signUpLine.topAnchor.constraint(equalTo: loginContainer.topAnchor, constant:  116).isActive = true
        signUpLine.widthAnchor.constraint(equalToConstant: 155).isActive = true
        signUpLine.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
        signUpLbl.leftAnchor.constraint(equalTo: loginContainer.leftAnchor, constant: 64).isActive = true
        signUpLbl.topAnchor.constraint(equalTo: loginContainer.topAnchor, constant:  54).isActive = true
        signUpLbl.widthAnchor.constraint(equalTo: loginContainer.widthAnchor, constant: 124).isActive = true
        signUpLbl.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        fullNameLbl.leftAnchor.constraint(equalTo: loginContainer.leftAnchor, constant: 54).isActive = true
        fullNameLbl.topAnchor.constraint(equalTo: signUpLbl.bottomAnchor).isActive = true
        fullNameLbl.heightAnchor.constraint(equalToConstant: 38).isActive = true
        fullNameLbl.rightAnchor.constraint(equalTo: loginContainer.rightAnchor, constant: -54).isActive = true
        
        fullName.leftAnchor.constraint(equalTo: loginContainer.leftAnchor, constant: 54).isActive = true
        fullName.topAnchor.constraint(equalTo: fullNameLbl.bottomAnchor, constant: 6).isActive = true
        fullName.heightAnchor.constraint(equalToConstant: 45).isActive = true
        fullName.rightAnchor.constraint(equalTo: loginContainer.rightAnchor, constant: -54).isActive = true
        
        emailLbl.centerXAnchor.constraint(equalTo: loginContainer.centerXAnchor).isActive = true
        emailLbl.topAnchor.constraint(equalTo: fullName.bottomAnchor, constant: 12).isActive = true
        emailLbl.heightAnchor.constraint(equalToConstant: 38).isActive = true
        emailLbl.widthAnchor.constraint(equalToConstant: view.frame.width - 108).isActive = true
        
        email.centerXAnchor.constraint(equalTo: loginContainer.centerXAnchor).isActive = true
        email.topAnchor.constraint(equalTo: emailLbl.bottomAnchor, constant: 6).isActive = true
        email.heightAnchor.constraint(equalToConstant: 45).isActive = true
        email.widthAnchor.constraint(equalToConstant: view.frame.width - 108).isActive = true
        
        passwordLbl.centerXAnchor.constraint(equalTo: loginContainer.centerXAnchor).isActive = true
        passwordLbl.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 12).isActive = true
        passwordLbl.heightAnchor.constraint(equalToConstant: 38).isActive = true
        passwordLbl.widthAnchor.constraint(equalToConstant: view.frame.width - 108).isActive = true
        
        password.centerXAnchor.constraint(equalTo: loginContainer.centerXAnchor).isActive = true
        password.topAnchor.constraint(equalTo: passwordLbl.bottomAnchor, constant: 6).isActive = true
        password.heightAnchor.constraint(equalToConstant: 45).isActive = true
        password.widthAnchor.constraint(equalToConstant: view.frame.width - 108).isActive = true
        
        countryLbl.centerXAnchor.constraint(equalTo: loginContainer.centerXAnchor).isActive = true
        countryLbl.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 12).isActive = true
        countryLbl.heightAnchor.constraint(equalToConstant: 38).isActive = true
        countryLbl.widthAnchor.constraint(equalToConstant: view.frame.width - 108).isActive = true
        
        countryContainer.centerXAnchor.constraint(equalTo: loginContainer.centerXAnchor).isActive = true
        countryContainer.topAnchor.constraint(equalTo: countryLbl.bottomAnchor, constant: 6).isActive = true
        countryContainerHeightConstraint = countryContainer.heightAnchor.constraint(equalToConstant: 55)
        countryContainerHeightConstraint.isActive = true
        countryContainer.widthAnchor.constraint(equalToConstant: view.frame.width - 108).isActive = true
        
        countryImage.leftAnchor.constraint(equalTo: countryContainer.leftAnchor, constant: 12).isActive = true
        countryImage.topAnchor.constraint(equalTo: countryContainer.topAnchor, constant: 18).isActive = true
        countryImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        countryImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        dropDownImage.rightAnchor.constraint(equalTo: countryContainer.rightAnchor, constant: -16).isActive = true
        dropDownImage.centerYAnchor.constraint(equalTo: countryImage.centerYAnchor, constant: 0).isActive = true
        dropDownImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        dropDownImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        countryName.leftAnchor.constraint(equalTo: countryImage.rightAnchor, constant: 12).isActive = true
        countryName.centerYAnchor.constraint(equalTo: countryImage.centerYAnchor, constant: 0).isActive = true
        countryName.heightAnchor.constraint(equalToConstant: 35).isActive = true
        countryName.rightAnchor.constraint(equalTo: dropDownImage.leftAnchor, constant: -12).isActive = true
        
        countryCV.leftAnchor.constraint(equalTo: countryContainer.leftAnchor, constant: 0).isActive = true
        countryCV.topAnchor.constraint(equalTo: countryName.bottomAnchor, constant: 0).isActive = true
        countryCV.heightAnchor.constraint(equalToConstant: 200).isActive = true
        countryCV.rightAnchor.constraint(equalTo: countryContainer.rightAnchor, constant: 0).isActive = true
        
        selectCountryBtn.centerXAnchor.constraint(equalTo: loginContainer.centerXAnchor).isActive = true
        selectCountryBtn.topAnchor.constraint(equalTo: countryLbl.bottomAnchor, constant: 6).isActive = true
        selectCountryBtn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        selectCountryBtn.widthAnchor.constraint(equalToConstant: view.frame.width - 108).isActive = true
        
        termsAndConditionsLbl.centerXAnchor.constraint(equalTo: loginContainer.centerXAnchor).isActive = true
        termsAndConditionsLbl.topAnchor.constraint(equalTo: countryContainer.bottomAnchor, constant: 24).isActive = true
        termsAndConditionsLbl.heightAnchor.constraint(equalToConstant: 45).isActive = true
        termsAndConditionsLbl.widthAnchor.constraint(equalToConstant: view.frame.width - 108).isActive = true
        
        
        createBtn.centerXAnchor.constraint(equalTo: loginContainer.centerXAnchor).isActive = true
        createBtn.topAnchor.constraint(equalTo: termsAndConditionsLbl.bottomAnchor, constant: 12).isActive = true
        createBtn.heightAnchor.constraint(equalToConstant: 65).isActive = true
        createBtn.widthAnchor.constraint(equalToConstant: view.frame.width - 108).isActive = true
        
        switchBtn.centerXAnchor.constraint(equalTo: loginContainer.centerXAnchor).isActive = true
        switchBtn.topAnchor.constraint(equalTo: createBtn.bottomAnchor, constant: 12).isActive = true
        switchBtn.heightAnchor.constraint(equalToConstant: 45).isActive = true
        switchBtn.widthAnchor.constraint(equalToConstant: view.frame.width - 24).isActive = true
        
        
        loadingLoader.centerXAnchor.constraint(equalTo: createBtn.centerXAnchor).isActive = true
        loadingLoader.centerYAnchor.constraint(equalTo: createBtn.centerYAnchor).isActive = true
        loadingLoader.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loadingLoader.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        termsAndConditionsLbl.delegate = self
        
        fullNameBorder()
        emailBorder()
        passwordBorder()
        aboutBorder()
        
    }
    
    @objc func selectCountryF(){
        
        if countryCV.isHidden == true {
            
            countryCV.isHidden = false
            
            countryContainerHeightConstraint.constant = 225
            
            dropDownImage.transform = CGAffineTransform.init(rotationAngle: CGFloat.pi)
            
            UIView.animate(withDuration: 0.4) {
                
                self.view.layoutIfNeeded()
                
            } completion: { (true) in
                
                
            }
            
        }else {
            
            countryCV.isHidden = true
            
            countryContainerHeightConstraint.constant = 55
            
            dropDownImage.transform = CGAffineTransform.init(rotationAngle: CGFloat.pi * 2)
            
            UIView.animate(withDuration: 0.4) {
                
                self.view.layoutIfNeeded()
                
            } completion: { (true) in
                
                
            }

        }
        
    }
    
    var count = 35
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == aboutYouValue {
            
            print(string)
            
            let bs = String(UnicodeScalar(8))
            
            if textField.text!.count + 1 <= 25 {
                
                //count -= textField.text!.count
                
                characterCountLbl.text = "\(25 - (textField.text!.count + 1))"
                
                print(textField.text!.count + 1)
                
                if string == "" {
                    
                    characterCountLbl.text = "\(25 - (textField.text!.count - 1))"
                    
                    
                }
                
                return true
                
            }else if string == bs || string == "\u{8}" || string == "" {
                
                print("here")
                
                characterCountLbl.text = "\(25 - (textField.text!.count - 1))"
                
                return true
                
            }else {
                
                return false
                
            }
            
        }else {
            
            return true
            
        }
        
        
        
    }
    
    func fullNameBorder(){
        
        let thickness: CGFloat = 2.0
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x:0, y: 45 - thickness, width: view.frame.width - 108, height:thickness)
        bottomBorder.backgroundColor = UIColor.black.cgColor
        
        fullName.layer.addSublayer(bottomBorder)
        
    }
    
    func emailBorder(){
        
        let thickness: CGFloat = 2.0
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x:0, y: 45 - thickness, width: view.frame.width - 108, height:thickness)
        bottomBorder.backgroundColor = UIColor.black.cgColor
        
        email.layer.addSublayer(bottomBorder)
        
    }
    
    func passwordBorder(){
        
        let thickness: CGFloat = 2.0
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x:0, y: 45 - thickness, width: view.frame.width - 108, height:thickness)
        bottomBorder.backgroundColor = UIColor.black.cgColor
        
        password.layer.addSublayer(bottomBorder)
        
    }
    
    func aboutBorder(){
        
        let thickness: CGFloat = 2.0
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x:0, y: 45 - thickness, width: view.frame.width - 108, height:thickness)
        bottomBorder.backgroundColor = UIColor.black.cgColor
        
        aboutYouValue.layer.addSublayer(bottomBorder)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return countryNames.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CountriesId", for: indexPath) as! CountriesCollectionViewCell
        
        cell.countryName.text = countryNames[indexPath.row]
        
        cell.countryFlag.image = UIImage(named: countryFlags[indexPath.row])
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: view.frame.width - 108, height: 35)
        
        return size
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        countryName.text = countryNames[indexPath.row]
        countryImage.image = UIImage(named: countryFlags[indexPath.row])
        
        
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        UIApplication.shared.open(URL, options: [:], completionHandler: nil)
        
        return false
        
    }
    
    var register = true
    
    //connect to database and create table
    
    private func createTable() {
        
        let database = SQLiteDatabase.sharedInstance
        
        database.createTable()
        
    }
    
    @objc func saveUserF(){
        
        let id: Int = 1
        let fullName = fullNameLbl.text ?? ""
        let email = self.email.text ?? ""
        let password = self.password.text ?? ""
        let country = self.countryName.text ?? ""
        let uiImage = topImage.image ?? UIImage(named: "logoImage")
        guard let photo = uiImage!.pngData() else { return }
        
        let userValues = User(id: id, fullName: fullName, email: email, password: password, country: country, photo: photo)
        
        createNewUser(userValues)
        
    }
    
    func createNewUser(_ userValues: User){
        
        let userAddedToTable = SQLiteCommands.insertRow(userValues, passedLoginVC: self)
        
        if userAddedToTable == true {
            
            UserDefaults().set(true, forKey: "userRegistered")
            
            let vc = HomeViewController()
            vc.modalPresentationStyle = .fullScreen
            
            present(vc, animated: true, completion: nil)
            
        }else {
            
            
            
            //showError("Error", message: "This user cannot be created because this user?? already exists in your contact list.")
            
        }
        
    }
    
    @objc func existingUserAlertF(){
        
        let alertController = UIAlertController(title: "Error", message: "User already exists. Use a different email or sign in.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let signInAction = UIAlertAction(title: "Sign In", style: .default) { (action) in
            
            self.fullName.text = ""
            self.email.text = ""
            
            self.switchF()
            
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(signInAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    @objc func loginRegister(){
        
        if register == true {
            
            signUpF()
            
        }else {
            
            signInF()
            
        }
        
    }
    
    var uniqueId: String!
    
    @objc func signUpF(){
        
        if fullName.text == "" || email.text == "" || password.text == "" {
            
            fillAllFieldsAlertF(title: "Sign Up Error")
            
        }else {
            
            saveUserF()
            
        }
        
        
        
    }
    
    @objc func fillAllFieldsAlertF(title: String){
        
        let alertController = UIAlertController(title: title, message: "Please fill all the required fields.", preferredStyle: .alert)
        
        let okayAction = UIAlertAction(title: "Okay", style: .default) { (action) in
            
        }
        
        alertController.addAction(okayAction)
        
        present(alertController, animated: true, completion: nil)
    
    }
    
    @objc func signInF(){
        
        if fullName.text == "" || email.text == "" {
            
            fillAllFieldsAlertF(title: "Sign In Error")
            
            return
            
        }
        
        let users = SQLiteCommands.presentRows()
        
        if let allUsers = users {
            
            for user in allUsers {
                
                if user.email == fullName.text {
                    
                    if user.password == email.text {
                        
                        let vc = HomeViewController()
                        vc.modalPresentationStyle = .fullScreen
                        
                        UserDefaults().set(true, forKey: "userRegistered")
                        
                        present(vc, animated: true, completion: nil)
                        
                    }else {
                        
                        incorrectPasswordAlertF()
                        
                    }
                    
                }else {
                    
                    userDoesNotExistAlertF()
                    
                }
                
            }
            
        }
        
    }
    
    @objc func userDoesNotExistAlertF(){
        
        let alertController = UIAlertController(title: "Error", message: "User does not exist. Sign Up for a new account.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let signUpAction = UIAlertAction(title: "Sign Up", style: .default) { (action) in
            
            self.fullName.text = ""
            self.email.text = ""
            
            self.switchF()
            
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(signUpAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    @objc func incorrectPasswordAlertF(){
        
        let alertController = UIAlertController(title: "Error", message: "Incorrect Password entered.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let signInAction = UIAlertAction(title: "Retry", style: .default) { (action) in
            
            
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(signInAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    @objc func switchF(){
        
        if register == true {
            
            createBtn.setTitle("LOGIN", for: .normal)
            
            signUpLbl.text = "Login"
            
            let title = NSMutableAttributedString(string: "Don't have an account ? ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
            
            let signInString = NSMutableAttributedString(string: "Sign Up ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
            
            title.append(signInString)
            
            switchBtn.setAttributedTitle(title, for: .normal)
            
            passwordLbl.isHidden = true
            password.isHidden = true
            
            countryLbl.isHidden = true
            countryContainer.isHidden = true
            characterCountLbl.isHidden = true
            
            fullNameLbl.text = "Email"
            
            fullName.attributedPlaceholder = NSAttributedString(string: "Enter Email",
                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
            
            emailLbl.text = "Password"
            
            email.attributedPlaceholder = NSAttributedString(string: "Enter Password",
                                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
            
            
            register = false
            
        }else {
            
            signUpLbl.text = "Sign Up"
            
            createBtn.setTitle("CREATE ACCOUNT", for: .normal)
            
            let title = NSMutableAttributedString(string: "Already have an account ? ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
            
            let signInString = NSMutableAttributedString(string: "Sign In ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
            
            title.append(signInString)
            
            switchBtn.setAttributedTitle(title, for: .normal)
            
            passwordLbl.isHidden = false
            password.isHidden = false
            
            countryLbl.isHidden = false
            countryContainer.isHidden = false
            characterCountLbl.isHidden = false
            
            fullNameLbl.text = "Full Name"
            fullName.attributedPlaceholder = NSAttributedString(string: "Enter Full Name",
                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
            
            emailLbl.text = "Email"
            email.attributedPlaceholder = NSAttributedString(string: "Enter Email",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
            
            register = true
        }
        
    }

}
