//
//  AppDetailedViewController.swift
//  LikeAppStrore
//
//  Created by a on 02/05/2017.
//  Copyright © 2017 Andreyka. All rights reserved.
//

import UIKit

class AppDetailedViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let detailedHeaderId = "detailed_header_id"
    let cellAppDetailedId = "cell_detailed_id"
    
    var app: App? {
        didSet {
            navigationItem.title = app?.name
            if let appId = app?.id {
                let url = "http://www.statsallday.com/appstore/appdetail?id=\(appId)"
                
                URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
                
                    print(data)
                    
                }.resume()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(AppDetailsHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: detailedHeaderId)
        
        collectionView?.register(ScreenshotsCell.self, forCellWithReuseIdentifier: cellAppDetailedId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellAppDetailedId, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 128)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: detailedHeaderId, for: indexPath) as! AppDetailsHeader
        
        if let imageName = app?.imageName {
            header.imageView.image = UIImage(named: imageName)
        }
        
        if let name = app?.name {
            header.nameLabel.text = name
        }
        
        if let price = app?.price {
            header.buyBtn.setTitle(price == 0 ? "GET" : "BUY $\(price)", for: .normal)
        } else {
            header.buyBtn.setTitle("GET", for: .normal)
        }
        return header
    }
}

class AppDetailsHeader: BaseCell {
    
    let imageView: UIImageView = {
        var iv = UIImageView()
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill

        return iv
    }()
    
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Details", "Reviews", "Related"])
        sc.tintColor = UIColor.darkGray
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    let nameLabel: UILabel = {
        
        let nl = UILabel()
        nl.font = UIFont.systemFont(ofSize: 16)
        return nl
    }()
    
    let buyBtn: UIButton = UIButton(type: .system)
    
    let divider: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return v
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = UIColor.white

        addSubview(imageView)
        addSubview(segmentedControl)
        addSubview(nameLabel)
        addSubview(buyBtn)
        addSubview(divider)
        
        addConstraintsWithFormat(format: "H:|-14-[v0(100)]-14-[v1]", views: imageView, segmentedControl)
        addConstraintsWithFormat(format: "V:|-14-[v0(100)]-(-35)-[v1]", views: imageView, segmentedControl)
        
        addConstraintsWithFormat(format: "H:|-128-[v0]", views: nameLabel)
        addConstraintsWithFormat(format: "V:|-14-[v0]", views: nameLabel)
        
        addConstraintsWithFormat(format: "H:[v0]-14-|", views: buyBtn)
        addConstraintsWithFormat(format: "V:|-50-[v0(32)]", views: buyBtn)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: divider)
        addConstraintsWithFormat(format: "V:[v0(2)]|", views: divider)
    }
}

