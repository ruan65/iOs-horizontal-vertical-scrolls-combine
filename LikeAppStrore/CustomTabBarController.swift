//
//  CustomTabBarController.swift
//  LikeAppStrore
//
//  Created by a on 07/05/2017.
//  Copyright © 2017 Andreyka. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let featuredAppsController = FeaturedAppsController(collectionViewLayout: layout)
        
        let featuredAppsNavController = UINavigationController(rootViewController: featuredAppsController)
        
        featuredAppsNavController.tabBarItem.title = "Featured"
//        featuredAppsNavController.tabBarItem.setFAIcon(icon: .FAStar)
        
        featuredAppsNavController.tabBarItem.setFAIcon(icon: .FAStar, size: nil, textColor: .blue, backgroundColor: .clear, selectedTextColor: .black, selectedBackgroundColor: .clear)

        
//        let layout2 = UICollectionViewFlowLayout()
//        let featuredAppsController2 = FeaturedAppsController(collectionViewLayout: layout2)
//        
//        let featuredAppsNavController2 = UINavigationController(rootViewController: featuredAppsController2)
//        featuredAppsNavController2.tabBarItem.title = "Featured2"
        
        let dummyController = UIViewController()
        
        dummyController.tabBarItem.title = "Dummy"
        
        dummyController.tabBarItem.setFAIcon(icon: .FAStar, size: nil, textColor: .blue, backgroundColor: .clear, selectedTextColor: .black, selectedBackgroundColor: .clear)
        
        viewControllers = [featuredAppsNavController, dummyController]
    }
}
