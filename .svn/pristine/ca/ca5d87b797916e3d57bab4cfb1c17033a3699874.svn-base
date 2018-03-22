//
//  MyViewCell.swift
//  LianHuServices
//
//  Created by denglong on 16/4/17.
//  Copyright © 2016年 邓龙. All rights reserved.
//  个人中心公告Cell

import UIKit

class MyViewCell: UITableViewCell {

    @IBOutlet weak var leftTitle: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    }
    
    func setLeftTitleName(name:String, imgName:String) {
        leftTitle.setImage(UIImage(named: imgName), forState: UIControlState.Normal)
        leftTitle.setTitle(name, forState: UIControlState.Normal)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
