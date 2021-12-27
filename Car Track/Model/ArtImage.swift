//
//  ArtImage.swift
//  Car Track
//
//  Created by Thapelo on 2021/12/26.
//

import UIKit
import MapKit

class CarLocation: NSObject {
    
    @objc var timeStamp: NSNumber?
    @objc var locationKey: String?
    var latValue: Double?
    var longValue: Double?
    var speed: Double?
    var annotation: Annotation?
    
}

