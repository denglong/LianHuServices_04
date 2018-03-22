//
//  TitleLabelCell.swift
//  LianHuServices
//
//  Created by denglong on 4/11/16.
//  Copyright © 2016 邓龙. All rights reserved.
//

import UIKit

let notiveViewHeight:CGFloat = 30
let noteViewHeight:CGFloat = 270

class TitleLabelCell: UITableViewCell {

    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var bottomLine:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
