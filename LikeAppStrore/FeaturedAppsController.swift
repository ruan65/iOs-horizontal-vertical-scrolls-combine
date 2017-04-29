//
//  ViewController.swift
//  LikeAppStrore
//
//  Created by a on 26/04/2017.
//  Copyright © 2017 Andreyka. All rights reserved.
//

import UIKit

class FeaturedAppsController: UICollectionViewController {
    
    private let cellId = "category_cell"
    private var appCategories: [AppCategory]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appCategories = AppCategory.sampleAppsCategories()
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategories?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
        return cell
    }
}

// MARK: Flow layout methods
extension FeaturedAppsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 250)
    }
}

