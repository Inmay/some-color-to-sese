//
//  tabbarViewCell.swift
//  myNote
//
//  Created by WuYueFeng on 2017/5/9.
//  Copyright © 2017年 WuYueFeng. All rights reserved.
//

import UIKit

class tabbarViewCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIImageView!
    var iconImg:UIImageView!
    var img:String!{
        didSet{
            iconImg?.image = UIImage.init(named: img)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImg = UIImageView.init(frame: CGRect.init(x: 2, y: 10, width: tabBarConfig.cellwidth-6, height: tabBarConfig.cellwidth))
        iconImg.layer.cornerRadius = 5
        iconImg.layer.masksToBounds = true
        backView.addSubview(iconImg)
    }
    

}
