//
//  SystemMyViewCell.swift
//  LianHuServices
//
//  Created by denglong on 16/4/19.
//  Copyright © 2016年 邓龙. All rights reserved.
//

import UIKit

class SystemMyViewCell: UITableViewCell {

    /** 待办件 */
    @IBOutlet weak var waitButton: UIButton!
    @IBOutlet weak var waitNum: UILabel!
    /** 到期件 */
    @IBOutlet weak var expireButton: UIButton!
    @IBOutlet weak var expireNum: UILabel!
    /** 超期件 */
    @IBOutlet weak var exceedButton: UIButton!
    @IBOutlet weak var exceedNum: UILabel!
    /** 今日办结 */
    @IBOutlet weak var dayBtn: UIButton!
    @IBOutlet weak var dayNum: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        waitButton.layer.borderColor = UIColor(hex: "94D800").CGColor
        expireButton.layer.borderColor = UIColor(hex: "f1a02d").CGColor
        exceedButton.layer.borderColor = UIColor(hex: "ff0000").CGColor
        dayBtn.layer.borderColor = UIColor(hex: "333BCD").CGColor
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
