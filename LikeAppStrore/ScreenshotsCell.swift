//
//  ScreenshotsCell.swift
//  LikeAppStrore
//
//  Created by a on 06/05/2017.
//  Copyright © 2017 Andreyka. All rights reserved.
//

import UIKit

class ScreenshotsCell: BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let screenshotImageCellId = "screenshot_image_cell_id"
    
    let collectionView: UICollectionView = {
    
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        return cv
    }()
    
    let dividerLineView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        
        return v
    }()
    
    var app: App? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ScreenshotImageCell.self, forCellWithReuseIdentifier: screenshotImageCellId)
        
        addSubview(collectionView)
        
        addSubview(dividerLineView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        
        addConstraintsWithFormat(format: "H:|-10-[v0]|", views: dividerLineView)
        addConstraintsWithFormat(format: "V:|-5-[v0]-10-[v1(1)]-5-|", views: collectionView, dividerLineView)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count = app?.screenshots?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: screenshotImageCellId, for: indexPath) as! ScreenshotImageCell
        
        if let imageName = app?.screenshots?[indexPath.item] {
            
            cell.imageView.image = UIImage(named: imageName)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: frame.height - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    fileprivate class ScreenshotImageCell: BaseCell {
        
        
        
        let imageView: UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.backgroundColor = UIColor.green
            return iv
        }()
        
        override func setupViews() {
            super.setupViews()
            
            layer.masksToBounds = true
            
            addSubview(imageView)
            addConstraintsFillEntireView(view: imageView)
            
//            imageView.image = UIImage(named: "frozen_screenshot1")
        }
    }
}
