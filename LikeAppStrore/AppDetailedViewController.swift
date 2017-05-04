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
        collectionView?.backgroundColor = UIColor.lightGray
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
        
        if let name = app?.name {
            header.nameLabel.text = name
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
    
    override func setupViews() {
        super.setupViews()

        addSubview(imageView)
        addSubview(segmentedControl)
        addSubview(nameLabel)
        
        addConstraintsWithFormat(format: "H:|-14-[v0(100)]-14-[v1]", views: imageView, segmentedControl)
        addConstraintsWithFormat(format: "V:|-14-[v0(100)]-(-35)-[v1]", views: imageView, segmentedControl)
        
        addConstraintsWithFormat(format: "H:|-128-[v0]", views: nameLabel)
        addConstraintsWithFormat(format: "V:|-14-[v0]", views: nameLabel)

        
        backgroundColor = UIColor.white
    }
}

extension UIView {

    func addConstraintsWithFormat(format: String, views: UIView...) {
        
        var viewsDict = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDict["v\(index)"] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict))
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
