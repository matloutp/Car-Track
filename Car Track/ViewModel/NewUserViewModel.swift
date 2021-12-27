//
//  NewUserViewModel.swift
//  Car Track
//
//  Created by Thapelo on 2021/12/23.
//

import UIKit


class NewUserViewModel {
    
    private var userValues: User?
    
    let id: Int?
    let fullName: String?
    let email: String?
    let password: String?
    let country: String?
    let photo: UIImage?
    
    init(userValues: User?) {
        
        self.userValues = userValues
        
        self.id = userValues?.id
        self.fullName = userValues?.fullName
        self.email = userValues?.email
        self.password = userValues?.password
        self.country = userValues?.country
        self.photo = UIImage(data: userValues!.photo)
        
    }
}
