//
//  Models.swift
//  LikeAppStrore
//
//  Created by a on 30/04/2017.
//  Copyright © 2017 Andreyka. All rights reserved.
//

import UIKit

class FeaturedApps: NSObject {
    
    var bannerCategory: AppCategory?
    var appCategories: [AppCategory]?
}

class AppCategory: NSObject {
    
    var name: String?
    var apps: [App]?
    
    static func fetchFeaturedApps() {
        
        print("Fetching featured apps")
        
        URLSession.shared.dataTask(with: URL(string: urlFeaturedApps)!) { (data, response, err) in
            
            
            guard err == nil else {
                print(err!)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                print("\(json)")
            } catch let er {
                print(er)
                return
            }
            }.resume()
    }
    
    
    static func sampleAppsCategories() -> FeaturedApps {
        
        let feturedApps = FeaturedApps()
        
        let bestNewAppsCategory = AppCategory()
        bestNewAppsCategory.name = "Best New Apps"
        
        var apps = [App]()
        var gamesApps = [App]()
        
        // Logic
        
        
        
        for _ in 0...5 {
            
            let frozenApp = App()
            let chessApp = App()
            
            frozenApp.name = "Disney Built it: Frozen"
            frozenApp.category = "Entertaiment"
            frozenApp.imageName = "frozen"
            frozenApp.price = NSNumber(value: 3.99)
            
            chessApp.name = "Chess Master: Checkmate"
            chessApp.category = "Games"
            chessApp.imageName = "chess"
            chessApp.price = NSNumber(value: 0)
            
            apps.append(frozenApp)
            
            gamesApps.append(chessApp)
        }
        
        
        bestNewAppsCategory.apps = apps
        
        let bestNewGamesCategory = AppCategory()
        bestNewGamesCategory.name = "Best New Games"
        
        // Logic
        
        
        bestNewGamesCategory.apps = gamesApps
        
        let appCategories = [bestNewAppsCategory, bestNewGamesCategory, bestNewAppsCategory]
        
        feturedApps.appCategories = appCategories
        
        let bannerCategory = AppCategory()
        
        let b1 = App()
        b1.imageName = "clashRoyaleBanner"
        
        let b3 = App()
        b3.imageName = "enhancedWith3dTouch"
        
        let b4 = App()
        b4.imageName = "drSeussBanner"
        
        let b2 = App()
        b2.imageName = "indieGameBanner"
        
        let bannerApps = [b1, b2,b3, b4]
        
        bannerCategory.apps = bannerApps
        
        feturedApps.bannerCategory = bannerCategory
        
        return feturedApps
    }
}

class App {
    
    var id: NSNumber?
    var name: String?
    var category: String?
    var imageName: String?
    var price: NSNumber?
}


