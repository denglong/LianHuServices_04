//
//  MyViewHeaderCell.swift
//  LianHuServices
//
//  Created by denglong on 16/4/17.
//  Copyright © 2016年 邓龙. All rights reserved.
//  个人中心头部Cell

import UIKit

class MyViewHeaderCell: UITableViewCell {
    @IBOutlet weak var userName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
