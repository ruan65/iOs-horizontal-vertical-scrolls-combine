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
    
    
    static func sampleAppsCategories() -> [AppCategory] {
        
        let bestNewAppsCategory = AppCategory()
        bestNewAppsCategory.name = "Best New Apps"
        
        var apps = [App]()
        
        // Logic
        
        let frozenApp = App()
        let chessApp = App()
        
        for _ in 0...5 {
            
            frozenApp.name = "Disney Built it: Frozen"
            frozenApp.category = "Entertaiment"
            frozenApp.imageName = "frozen"
            frozenApp.price = NSNumber(value: 3.99)
            
            chessApp.name = "Chess Master: Checkmate"
            chessApp.category = "Games"
            chessApp.imageName = "chess"
            chessApp.price = NSNumber(value: 0)
        }
        
        apps.append(frozenApp)
        bestNewAppsCategory.apps = apps
        
        let bestNewGamesCategory = AppCategory()
        bestNewGamesCategory.name = "Best New Games"
        var gamesApps = [App]()
        // Logic
        
        gamesApps.append(chessApp)
        bestNewGamesCategory.apps = gamesApps
        
        return [bestNewAppsCategory, bestNewGamesCategory]
    }
}

class App {
    
    var id: NSNumber?
    var name: String?
    var category: String?
    var imageName: String?
    var price: NSNumber?
}


