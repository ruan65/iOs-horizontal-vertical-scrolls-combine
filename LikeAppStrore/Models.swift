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
    
    static func sampleAppsCategories() -> [AppCategory] {
        
        let bestNewAppsCategory = AppCategory()
        bestNewAppsCategory.name = "Best New Apps"
        
        var apps = [App]()
        
        // Logic
        
        let frozenApp = App()
        frozenApp.name = "Disney Built it: Frozen"
        frozenApp.category = "Entertaiment"
        frozenApp.imageName = "frozen"
        frozenApp.price = NSNumber(value: 3.99)
        
        apps.append(frozenApp)
        bestNewAppsCategory.apps = apps
        
        return [bestNewAppsCategory]
    }
}

class App {
    
    var id: NSNumber?
    var name: String?
    var category: String?
    var imageName: String?
    var price: NSNumber?
}


