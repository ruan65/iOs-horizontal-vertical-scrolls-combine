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
    let cellScreenshotId = "cell_screenshot_id"
    let cellDescrId = "cell_descr_id"
    
    var app: App? {
        didSet {
            
            navigationItem.title = app?.name
            
            if app?.screenshots != nil {
                return
            }
            
            if let appId = app?.id {
                let url = "http://www.statsallday.com/appstore/appdetail?id=\(appId)"
                
                URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
                    
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    do {
                        
                        let json = try(JSONSerialization.jsonObject(with: data!, options: .mutableContainers))
                        
                        print(json)
                        
                        let appDetailed = App()
                        
                        appDetailed.setValuesForKeys(json as! [String: AnyObject])
                        
                        self.app = appDetailed
                        
                        DispatchQueue.main.async(execute: { () -> Void in
                            self.collectionView?.reloadData()
                        })
                        
                    } catch let err {
                        print(err)
                    }
                    
                    }.resume()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(AppDetailsHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: detailedHeaderId)
        
        collectionView?.register(ScreenshotsCell.self, forCellWithReuseIdentifier: cellScreenshotId)
        
        collectionView?.register(AppDetaledDescriptionCell.self, forCellWithReuseIdentifier: cellDescrId)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellScreenshotId, for: indexPath) as! ScreenshotsCell
            
            cell.app = app
            
            return cell
            
        }
        
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellDescrId, for: indexPath) as! AppDetaledDescriptionCell
        
        cell.textView.attributedText = getDescriptionAttributedText()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 1 {
            
            let dummySize = CGSize(width: view.frame.width - 10 - 10, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
            let rect = getDescriptionAttributedText().boundingRect(with: dummySize, options: options, context: nil)
            return CGSize(width: view.frame.width, height: rect.height + 18)
        }
        return CGSize(width: view.frame.width, height: 175)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
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
    
    func getDescriptionAttributedText() -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(string: "Description\n", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)])
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 10
        let range = NSMakeRange(0, attributedString.string.characters.count)
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: style, range: range)
        
        if let desc = app?.desc {
            
            attributedString.append(NSAttributedString(string: desc, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName: UIColor.darkGray]))
        }
        return attributedString
    }
}

class AppDetaledDescriptionCell: BaseCell {
    
    let textView: UITextView = UITextView()
    
    let divider: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return v
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(textView)
        addSubview(divider)
        
        addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: textView)
        addConstraintsWithFormat(format: "H:|-10-[v0]|", views: divider)

        addConstraintsWithFormat(format: "V:|-(-8)-[v0]-4-[v1(1)]|", views: textView, divider)
        
        //        addConstraintsFillEntireView(view: textView)
        
        // hello
        
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
        addConstraintsWithFormat(format: "V:[v0(1)]|", views: divider)
    }
}

