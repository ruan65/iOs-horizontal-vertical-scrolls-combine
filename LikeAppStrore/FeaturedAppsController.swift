//
//  ViewController.swift
//  LikeAppStrore
//
//  Created by a on 26/04/2017.
//  Copyright © 2017 Andreyka. All rights reserved.
//

import UIKit

class FeaturedAppsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "category_cell"
    private let largeCellId = "large_category_cell"
    private let headerId = "header_id"

    private var appCategories: [AppCategory]?
    private var featuredApps: FeaturedApps?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        AppCategory.fetchFeaturedApps()
        navigationItem.title = "Featured Apps"
//        featuredApps = AppCategory.sampleAppsCategories()
        
        AppCategory.fetchFeaturedApps { featuredApps in
        
            self.featuredApps = featuredApps
            self.appCategories = featuredApps.appCategories
            self.collectionView?.reloadData()
            
            print(featuredApps.bannerCategory?.apps?.count ?? "is empty")
            
            if let banapps = featuredApps.bannerCategory?.apps {
                for a in banapps {
                    print(a.imageName)
                }
            }
        }
        
        appCategories = featuredApps?.appCategories
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(LargeCategoryCell.self, forCellWithReuseIdentifier: largeCellId)
        
        collectionView?.register(Header.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategories?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! Header
        
        header.appCategory = featuredApps?.bannerCategory
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 120)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 2 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeCellId, for: indexPath) as! LargeCategoryCell
            return setupCategoryCell(cell, index: indexPath.item)
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
        
        return setupCategoryCell(cell, index: indexPath.item)
    }
    
    private func setupCategoryCell(_ cell: CategoryCell, index: Int) -> CategoryCell {
        cell.appCategory = appCategories?[index]
        cell.featuredAppController = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: indexPath.item == 2 ? 175 : 250)
    }
    
    func showAppDetails(forApp app: App) {
        
        print(app.name ?? "not provided...")
        
        let layout = UICollectionViewFlowLayout()
        
        let appDetailedController = AppDetailedViewController(collectionViewLayout: layout)
        
        appDetailedController.app = app
        
        navigationController?.pushViewController(appDetailedController, animated: true)
    }
}

