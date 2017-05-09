//
//  tabbarView.swift
//  myNote
//
//  Created by WuYueFeng on 2017/5/9.
//  Copyright © 2017年 WuYueFeng. All rights reserved.
//

import UIKit


struct tabBarConfig {
    static let cellwidth:CGFloat = 60
    static let cellheight:CGFloat = 60
}

protocol tabbarDidSelectDelegate {
    func tabbarDidClickAt(index:IndexPath?)
}

class tabbarView: UIView ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    var delegate:tabbarDidSelectDelegate!
    
    
    var collectionView:UICollectionView!
    
    var selectIndex:IndexPath!
    
    var start_up = false
    
    var jsonDic = [[String:String]]()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init(frame:CGRect,data:[[String:String]]!) {
        self.init(frame: frame)
        
        self.jsonDic = data
        
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        self.collectionView = UICollectionView.init(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "tabbarViewCell", bundle: nil), forCellWithReuseIdentifier: "tabbarViewCell")
        self.addSubview(collectionView)
        
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.jsonDic.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tabbarViewCell", for: indexPath) as! tabbarViewCell
        let imgStr = self.jsonDic[indexPath.row]["img"]
        cell.img = imgStr
        
//        if imgStr != nil {
//            cell.iconImg.image = UIImage.init(named: imgStr!)
//        }
        
        if selectIndex == nil {
            selectIndex = IndexPath.init(row: 0, section: 0)
            DispatchQueue.main.async {
                cell.backView.frame.origin.y = 0
            }
        }

        return cell
    }
    
    func shouldSelectAt(index:IndexPath) {
        if selectIndex != index {
            let cell1 = collectionView.cellForItem(at: selectIndex) as! tabbarViewCell
            
            let cell2 = collectionView.cellForItem(at: index) as! tabbarViewCell
            
            UIView.animate(withDuration: 0.3, animations: {
                cell1.backView.frame.origin.y = tabBarConfig.cellheight - 7
                cell2.backView.frame.origin.y = 0
            })
            selectIndex = index
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if selectIndex != indexPath {
            shouldSelectAt(index: indexPath)
            self.delegate?.tabbarDidClickAt(index: indexPath)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: tabBarConfig.cellwidth, height: tabBarConfig.cellheight)
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
