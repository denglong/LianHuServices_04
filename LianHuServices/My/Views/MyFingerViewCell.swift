//
//  MyFingerViewCell.swift
//  LianHuServices
//
//  Created by denglong on 16/4/21.
//  Copyright © 2016年 邓龙. All rights reserved.
//

import UIKit

class MyFingerViewCell: UITableViewCell {

    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var contentLab: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    func setTitleButtonTextName(name:String) {
        titleButton.setTitle(name, forState: UIControlState.Normal)
        if name == "即办件" {
            titleButton.setBackgroundImage(UIImage(named: "jbj_02"), forState: UIControlState.Normal)
            titleButton.setBackgroundImage(UIImage(named: "jbj_02"), forState: UIControlState.Highlighted)
        }
        else if name == "承诺件" {
            titleButton.setBackgroundImage(UIImage(named: "cnj_01"), forState: UIControlState.Normal)
            titleButton.setBackgroundImage(UIImage(named: "cnj_01"), forState: UIControlState.Highlighted)
        }
        else
        {
            titleButton.setBackgroundImage(UIImage(named: "sbj_03"), forState: UIControlState.Normal)
            titleButton.setBackgroundImage(UIImage(named: "sbj_03"), forState: UIControlState.Highlighted)
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
