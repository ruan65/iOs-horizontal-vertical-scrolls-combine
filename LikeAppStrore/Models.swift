//
//  Models.swift
//  LikeAppStrore
//
//  Created by a on 30/04/2017.
//  Copyright © 2017 Andreyka. All rights reserved.
//

import UIKit

class AppCategory: NSObject {
    
    var name: String?
    var apps: [App]?
}

class App {
    
    var id: NSNumber?
    var name: String?
    var category: String?
    var imageName: String?
    var price: NSNumber?
}


