//
//  PreliminaryCell.swift
//  LianHuServices
//
//  Created by denglong on 16/4/20.
//  Copyright © 2016年 邓龙. All rights reserved.
//  预审Cell

import UIKit

class PreliminaryCell: UITableViewCell {

    @IBOutlet weak var contentLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}