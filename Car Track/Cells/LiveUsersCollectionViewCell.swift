//
//  LiveUsersCollectionViewCell.swift
//  Car Track
//
//  Created by Thapelo on 2021/12/26.
//

import UIKit

class LiveUsersCollectionViewCell: UICollectionViewCell {
    
    let trackedCarImage: UIImageView = {
        
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.image = UIImage(named: "benzo")
        
        img.contentMode = .scaleAspectFit
        
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 26
        
        img.layer.borderWidth = 2
        img.layer.borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1).cgColor
        
        return img
        
    }()
    
    lazy var trackedCarCity: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = UIColor(red: 10/255, green: 10/255, blue: 10/255, alpha: 1)
        
        lbl.text = "Tzaneen, 0870"
        
        lbl.font = UIFont(name: "JosefinSans-SemiBold", size: 21)
        
        lbl.textAlignment = .left
        
        
        
        return lbl
        
    }()
    
    lazy var trackedCarStreet: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.textColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        
        lbl.text = "123, Arbour Park"
        
        lbl.font = UIFont(name: "JosefinSans-Regular", size: 16)
        
        lbl.textAlignment = .left
        
        
        
        return lbl
        
    }()
    
    lazy var destinationBtn: UIButton = {
        
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 12
        
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1).cgColor
        
        btn.setTitle("Destination", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        
        btn.titleLabel?.font = UIFont(name: "JosefinSans-Bold", size: 18)
        
        btn.addTarget(self, action: #selector(destinationF), for: .touchUpInside)
        
        return btn
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        
    }
    
    func setup(){
        
        addSubview(trackedCarImage)
        addSubview(trackedCarCity)
        addSubview(trackedCarStreet)
        addSubview(destinationBtn)
        
        trackedCarImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        trackedCarImage.widthAnchor.constraint(equalToConstant: 126).isActive = true
        trackedCarImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive = true
        trackedCarImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12).isActive = true
        
        trackedCarCity.topAnchor.constraint(equalTo: self.topAnchor, constant: 24).isActive = true
        trackedCarCity.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24).isActive = true
        trackedCarCity.rightAnchor.constraint(equalTo: trackedCarImage.leftAnchor, constant: -12).isActive = true
        trackedCarCity.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        trackedCarStreet.topAnchor.constraint(equalTo: trackedCarCity.bottomAnchor, constant: 6).isActive = true
        trackedCarStreet.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24).isActive = true
        trackedCarStreet.rightAnchor.constraint(equalTo: trackedCarImage.leftAnchor, constant: -12).isActive = true
        trackedCarStreet.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        destinationBtn.topAnchor.constraint(equalTo: trackedCarStreet.bottomAnchor, constant: 8).isActive = true
        destinationBtn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24).isActive = true
        destinationBtn.rightAnchor.constraint(equalTo: trackedCarImage.leftAnchor, constant: -32).isActive = true
        destinationBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12).isActive = true
        
    }
    
    @objc func destinationF(){
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
