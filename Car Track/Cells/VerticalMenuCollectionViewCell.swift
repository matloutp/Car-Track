//
//  VerticalMenuCollectionViewCell.swift
//  Car Track
//
//  Created by Thapelo on 2021/12/27.
//

import UIKit

class VerticalMenuCollectionViewCell: UICollectionViewCell {
    
    let menuIcon: UIImageView = {
        
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        
        img.backgroundColor = .clear
        
        img.image = UIImage(named: "letterT")

        img.contentMode = .scaleAspectFit
        
        
        return img
    }()
    
    let menuLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        
        lbl.text = "Text"
        
        lbl.font = UIFont(name: "JosefinSans-Light", size: 20)
        
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
        
        addSubview(menuIcon)
        addSubview(menuLbl)
        
        menuIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        menuIcon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        menuIcon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24).isActive = true
        menuIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        menuLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        menuLbl.leftAnchor.constraint(equalTo: menuIcon.rightAnchor, constant: 24).isActive = true
        menuLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24).isActive = true
        menuLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        
        
    }
    
    var shouldTintBackgroundWhenSelected = true // You can change default value
    
    override var isHighlighted: Bool {
        
        willSet {
            onSelected(newValue)
        }
    }
    
    override var isSelected: Bool {
        
        willSet {
            
            onSelected(newValue)
        
        }
    
    }
    
    func onSelected(_ newValue: Bool) {
        
        // selectedBackgroundView is defined by UICollectionViewCell
        guard selectedBackgroundView == nil else { return }
        
        if shouldTintBackgroundWhenSelected {
            
            self.layer.borderColor = newValue ? UIColor(red: 60/255, green: 82/255, blue: 246/255, alpha: 1).cgColor :  UIColor(red: 240/255, green: 239/255, blue: 244/255, alpha: 1).cgColor
            
            
        
        }
        
        /*if let sa = specialHighlightedArea {
         sa.backgroundColor = newValue ? UIColor.black.withAlphaComponent(0.4) : UIColor.clear
         
         }*/
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
