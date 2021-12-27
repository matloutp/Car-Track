//
//  UsersCollectionViewCell.swift
//  Car Track
//
//  Created by Thapelo on 2021/12/26.
//

import UIKit

class UsersCollectionViewCell: UICollectionViewCell {
    
    var homeVC: HomeViewController?
    
    let userBackground: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.backgroundColor = .white
        
        vw.layer.masksToBounds = true
        vw.layer.cornerRadius = 21
        
        return vw
        
    }()
    
    
    let userImage: UIImageView = {
        
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.image = UIImage(named: "user")
        
        img.contentMode = .scaleAspectFit
        
        return img
        
    }()
    
    lazy var userName: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        
        lbl.text = "c300"
        
        lbl.font = UIFont(name: "JosefinSans-Light", size: 18)
        
        lbl.textAlignment = .left
        
        
        
        return lbl
        
    }()
    
    lazy var userFullName: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        
        lbl.text = "A. Mamfanya"
        
        lbl.font = UIFont(name: "JosefinSans-Bold", size: 19)
        
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        
        return lbl
        
    }()
    
    lazy var companyName: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        
        lbl.text = "Mercedes Benz"
        
        lbl.font = UIFont(name: "JosefinSans-Light", size: 18)
        
        lbl.textAlignment = .left
        
        
        
        return lbl
        
    }()
    
    var topConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        
    }
    
    func setup(){
        
        addSubview(userBackground)
        userBackground.addSubview(userImage)
        userBackground.addSubview(userName)
        userBackground.addSubview(companyName)
        userBackground.addSubview(userFullName)
        
        topConstraint = userBackground.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)
        topConstraint.isActive = true
        userBackground.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        userBackground.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        userBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        userImage.topAnchor.constraint(equalTo: userBackground.topAnchor, constant: 12).isActive = true
        userImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        userImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: (self.frame.width) - 24).isActive = true
        
        companyName.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12).isActive = true
        companyName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        companyName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        companyName.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        userName.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 12).isActive = true
        userName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        userName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        userName.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        userFullName.bottomAnchor.constraint(equalTo: companyName.topAnchor, constant: -3).isActive = true
        userFullName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        userFullName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        userFullName.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 3).isActive = true
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
