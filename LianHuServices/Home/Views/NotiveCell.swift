//
//  NotiveCell.swift
//  LianHuServices
//
//  Created by denglong on 4/12/16.
//  Copyright © 2016 邓龙. All rights reserved.
//

import UIKit

let bottomSubHeight:CGFloat = 46

class NotiveCell: UITableViewCell {

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
