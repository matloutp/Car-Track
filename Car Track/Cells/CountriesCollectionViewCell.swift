//
//  CountriesCollectionViewCell.swift
//  Car Track
//
//  Created by Thapelo on 2021/12/27.
//

import UIKit

class CountriesCollectionViewCell: UICollectionViewCell {
    
    let countryFlag: UIImageView = {
        
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.backgroundColor = .clear
        
        img.image = UIImage(named: "za")

        img.contentMode = .scaleAspectFit
        
        
        return img
    }()
    
    let countryName: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = "Text"
        
        lbl.font = UIFont(name: "JosefinSans-Light", size: 16)
        
        lbl.textColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
        
        lbl.textAlignment = .left
        
        lbl.layer.masksToBounds = true
        lbl.layer.cornerRadius = 8
        
        
        
        return lbl
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        
    }
    
    func setup(){
        
        addSubview(countryFlag)
        addSubview(countryName)
        
        countryFlag.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        countryFlag.widthAnchor.constraint(equalToConstant: 20).isActive = true
        countryFlag.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive = true
        countryFlag.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        countryName.heightAnchor.constraint(equalToConstant: 35).isActive = true
        countryName.leftAnchor.constraint(equalTo: countryFlag.rightAnchor, constant: 12).isActive = true
        countryName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        countryName.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
