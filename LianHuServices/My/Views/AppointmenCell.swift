//
//  AppointmenCell.swift
//  LianHuServices
//
//  Created by denglong on 16/4/20.
//  Copyright © 2016年 邓龙. All rights reserved.
//  预约Cell

import UIKit

class AppointmenCell: UITableViewCell {

    @IBOutlet weak var contentLab: UILabel!
    @IBOutlet weak var timeDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
