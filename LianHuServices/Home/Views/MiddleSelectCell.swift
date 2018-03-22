//
//  MiddleSelectCell.swift
//  LianHuServices
//
//  Created by denglong on 4/11/16.
//  Copyright © 2016 邓龙. All rights reserved.
//

import UIKit

class MiddleSelectCell: UITableViewCell {

    @IBOutlet weak var firstImg: UIImageView!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var secondImg: UIImageView!
    @IBOutlet weak var secondName: UILabel!
    @IBOutlet weak var thirdImg: UIImageView!
    @IBOutlet weak var thirdName: UILabel!
    @IBOutlet weak var fourImg: UIImageView!
    @IBOutlet weak var fourName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        for i in 0..<3 {
            let lineView = UIView(frame: CGRectMake(VIEWWIDTH/4 + VIEWWIDTH/4*CGFloat(i), 0, COMMINUTELINE, homeScrollHeight))
            lineView.backgroundColor = UIColor(hex: "cccccc")
            self.addSubview(lineView)
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
