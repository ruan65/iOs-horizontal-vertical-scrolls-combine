//
//  AppDetailedViewController.swift
//  LikeAppStrore
//
//  Created by a on 02/05/2017.
//  Copyright © 2017 Andreyka. All rights reserved.
//

import UIKit

class AppDetailedViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.brown
    }
}

class AppDetailsHeader: BaseCell {
    
    
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
