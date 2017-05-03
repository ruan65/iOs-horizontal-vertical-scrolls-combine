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
    
    var app: App? {
        didSet {
            navigationItem.title = app?.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(AppDetailsHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: detailedHeaderId)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 128)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: detailedHeaderId, for: indexPath) as! AppDetailsHeader
        
        if let imageName = app?.imageName {
            header.imageView.image = UIImage(named: imageName)
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
        iv.translatesAutoresizingMaskIntoConstraints = false

        return iv
    }()
    
    override func setupViews() {
        super.setupViews()
        
//        imageView.translatesAutoresizingMaskIntoConstraints = false

        
        addSubview(imageView)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0(100)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-14-[v0(100)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
        
        
        backgroundColor = UIColor.white
    }
}

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
    
    func setupViews() {}
}
