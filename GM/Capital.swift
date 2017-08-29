//
//  Capital.swift
//  GM
//
//  Created by Rahul Kumar on 7/27/16.
//  Copyright © 2016 Rahul Kumar. All rights reserved.
//

import Foundation

import MapKit
import UIKit

class Capital: MKPointAnnotation {
//    var title: String?
//    var coordinate: CLLocationCoordinate2D

    var username: String!
    var date: String!
    var UIDSTring:String!
    
    init(title: String, coordinate: CLLocationCoordinate2D,username :String, UIDSTring:String, date:String) {
        super.init()
        self.title = title
        self.username = username
        self.date = date
        self.UIDSTring = UIDSTring
        self.coordinate = coordinate
    }
}