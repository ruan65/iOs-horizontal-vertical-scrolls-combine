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
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "categories" {
            appCategories = [AppCategory]()
            
            for dict in value as! [[String: AnyObject]] {
                let appCategory = AppCategory()
                appCategory.setValuesForKeys(dict)
                appCategories?.append(appCategory)
            }
            
        } else if key == "bannerCategory" {
            bannerCategory = AppCategory()
            bannerCategory?.setValuesForKeys(value as! [String: AnyObject])
            
            for c in (bannerCategory?.apps)! {
                print("set values: " + c.imageName!)
            }
        } else {
            super.setValue(value, forKey: key)
        }
    }
}

class AppCategory: NSObject {
    
    var name: String?
    var apps: [App]?
    var type: String?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "apps" {
            
            apps = [App]()
            for dict in value as! [[String: AnyObject]] {
                let app = App()
                app.setValuesForKeys(dict)
                apps?.append(app)
            }
            
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
    static func fetchFeaturedApps(_ handleFetchedApps: @escaping (FeaturedApps) -> ()) {
        
        let urlString = "http://www.statsallday.com/appstore/featured"
        
        URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error!)
                return
            }
            
            do {
                
                let json = try(JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                
                print(json)
                
                let featuredApps = FeaturedApps()
                featuredApps.setValuesForKeys(json as! [String: AnyObject])
                
                DispatchQueue.main.async(execute: { () -> Void in
                    handleFetchedApps(featuredApps)
                })
                
            } catch let err {
                print(err)
            }
            
        }) .resume()
        
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

class App: NSObject {
    
    var id: NSNumber?
    var name: String?
    var category: String?
    var imageName: String?
    var price: NSNumber?
    
    var screenshots: [String]?
    var desc: String?
    var appInformation: AnyObject?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "description" {
            self.desc = value as? String
        } else {
            super.setValue(value, forKey: key)
        }
    }
}


