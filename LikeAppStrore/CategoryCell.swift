//
//  CategoryCell.swift
//  LikeAppStrore
//
//  Created by a on 27/04/2017.
//  Copyright © 2017 Andreyka. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let appCellId = "app_cell"
    
    var featuredAppController: FeaturedAppsController?
    
    var appCategory: AppCategory? {
        didSet {
            if let name = appCategory?.name {
                nameLabel.text = name
            }
        }
    }
    
    let appsCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    var nameLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 16)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let dividerLineView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        v.translatesAutoresizingMaskIntoConstraints = false

        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
//        divederLineView.frame = CGRect(x: 0, y: frame.height - 2, width: frame.width, height: 1)
        addSubview(appsCollectionView)
        addSubview(dividerLineView)
        addSubview(nameLabel)
        
        appsCollectionView.delegate = self
        appsCollectionView.dataSource = self
        appsCollectionView.register(AppCell.self, forCellWithReuseIdentifier: appCellId)


        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]-14-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appsCollectionView]))
        
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]-14-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": dividerLineView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[nameLabel(30)][v0][v1(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appsCollectionView, "v1": dividerLineView, "nameLabel": nameLabel]))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count = appCategory?.apps?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appCellId, for: indexPath) as! AppCell
        cell.app = appCategory?.apps?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let app = appCategory?.apps?[indexPath.item] {
            featuredAppController?.showAppDetails(forApp: app)
        }
    }
    
    // MARK: Flow layout methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CellSize.app, height: frame.height - 31)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
}

class LargeCategoryCell: CategoryCell {
    
    let cellId = "app_cell_large"
    
    override func setupViews() {
        super.setupViews()
        appsCollectionView.register(LargeAppCell.self, forCellWithReuseIdentifier: cellId)

    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LargeAppCell
        
        cell.app = appCategory?.apps?[indexPath.item]
        return cell
    }
    
    // MARK: Large category cell -> Flow layout methods
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CellSize.appWide, height: frame.height - 31)
    }
    
    private class LargeAppCell: AppCell {
        
        override func setupViews() {
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(imageView)
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
            
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-2-[v0]-14-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
        }
    }
}

class Header: CategoryCell {
    
    let cellId = "header_cell"
    
    override func setupViews() {
        
        appsCollectionView.delegate = self
        appsCollectionView.dataSource = self
        
        appsCollectionView.register(HeaderCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(appsCollectionView)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appsCollectionView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appsCollectionView]))
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HeaderCell
        
        cell.app = appCategory?.apps?[indexPath.item]
        return cell
    }
    
    // MARK: Large category cell -> Flow layout methods
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 2 + 50, height: frame.height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private class HeaderCell: AppCell {
        
        override func setupViews() {
            
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer.cornerRadius = 0
            imageView.layer.borderColor = UIColor(white: 0, alpha: 0.5).cgColor
            imageView.layer.borderWidth = 3
            addSubview(imageView)
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
            
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
        }
    }

}

class AppCell: UICollectionViewCell {
    
    var app: App? {
        
        didSet {
            
            if let name = app?.name {
                nameLabel.text = name
            }
            
            if  let cat = app?.category {
                categoryLabel.text = cat
            }
            
            if let price = app?.price {
                priceLabel.text = price == 0 ? "Price: Free" : "Price: $\(price)"
            } else {
                priceLabel.text = ""
            }
            
            if let imgName = app?.imageName {
                imageView.image = UIImage(named: imgName)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 14)
        l.numberOfLines = 2
        return l
    }()
    
    let categoryLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 12)
        l.textColor = UIColor.darkGray
        return l
    }()
    
    let priceLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 15)
        l.textColor = UIColor.darkGray
        return l
    }()
    
    func setupViews() {
        
        let size = frame.width
        
        imageView.frame = CGRect(x: 0, y: 0, width: size, height: size)
        nameLabel.frame = CGRect(x: 0, y: size + 2, width: size, height: 40)
        categoryLabel.frame = CGRect(x: 0, y: size + 38, width: size, height: 20)
        priceLabel.frame = CGRect(x: 0, y: size + 56, width: size, height: 20)

        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(categoryLabel)
        addSubview(priceLabel)
    }
}

