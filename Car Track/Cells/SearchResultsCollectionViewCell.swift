//
//  SearchResultsCollectionViewCell.swift
//  Car Track
//
//  Created by Thapelo on 2021/12/27.
//

import UIKit
import Hero

class SearchResultsCollectionViewCell: UICollectionViewCell {
    
    var homeVC: HomeViewController?
    
    let userImage: UIImageView = {
        
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.image = UIImage(named: "user")
        
        img.contentMode = .scaleAspectFit
        
        return img
        
    }()
    
    lazy var userFullName: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        
        lbl.text = "c300"
        
        lbl.font = UIFont(name: "JosefinSans-Bold", size: 18)
        
        lbl.textAlignment = .left
        
        
        
        return lbl
        
    }()
    
    lazy var userName: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        
        lbl.text = "A. Mamfanya"
        
        lbl.font = UIFont(name: "JosefinSans-Regular", size: 16)
        
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        
        return lbl
        
    }()
    
    let seperatorLine: UIView = {
        
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        vw.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
        
        return vw
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        
    }
    
    func setup(){
        
        addSubview(userImage)
        addSubview(userFullName)
        addSubview(userName)
        addSubview(seperatorLine)
        
        userImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 6).isActive = true
        userImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: self.frame.height - 48).isActive = true
        userImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6).isActive = true
        
        userFullName.topAnchor.constraint(equalTo: self.topAnchor, constant: 24).isActive = true
        userFullName.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 12).isActive = true
        userFullName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        userFullName.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        userName.topAnchor.constraint(equalTo: userFullName.bottomAnchor, constant: 6).isActive = true
        userName.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 12).isActive = true
        userName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        userName.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        seperatorLine.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        seperatorLine.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        seperatorLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        seperatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
