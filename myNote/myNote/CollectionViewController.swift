//
//  CollectionViewController.swift
//  myNote
//
//  Created by WuYueFeng on 2017/4/20.
//  Copyright © 2017年 WuYueFeng. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController ,UICollectionViewDelegateFlowLayout,tabbarDidSelectDelegate{
    
    let colors = [UIColor.black,UIColor.blue,UIColor.gray,UIColor.green,UIColor.red]
    
    let mainScreenBounds = UIScreen.main.bounds
    
    var tabBarView:tabbarView!
    
    var jsonDic = [[String:String]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let jsonPath = Bundle.main.url(forResource: "data", withExtension: "json")
        let jsonData = try! Data.init(contentsOf: jsonPath!)
        jsonDic = try! JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)  as! [[String:String]]

        // Register cell classes
        self.collectionView!.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        tabBarView = tabbarView.init(frame: CGRect.init(x: 0, y:mainScreenBounds.height-tabBarConfig.cellheight, width: mainScreenBounds.width, height: tabBarConfig.cellheight ), data: jsonDic)
        tabBarView.delegate = self
        self.view.addSubview(tabBarView)
        
        //tabBarView.collectionView.selectItem(at: IndexPath.init(row: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return jsonDic.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        // Configure the cell
        cell.titleLabel.text = jsonDic[indexPath.row]["type"]
        cell.contentImg.image = UIImage.init(named: jsonDic[indexPath.row]["img"]!)
    
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: mainScreenBounds.width, height: mainScreenBounds.height-120)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    
    func tabbarDidClickAt(index:IndexPath?) {
        self.collectionView?.selectItem(at: index, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print(scrollView.contentOffset.x)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.tabBarView.shouldSelectAt(index: IndexPath.init(row: Int(scrollView.contentOffset.x/mainScreenBounds.width), section: 0))
    }
    
    /**
     移动位置
     */
    func updateInteractiveMovementTargetPosition(targetPosition:CGPoint) {
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.tabBarView.shouldSelectAt(index: indexPath)
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
