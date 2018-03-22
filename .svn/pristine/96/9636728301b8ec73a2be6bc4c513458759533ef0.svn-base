//
//  BottomSelectCell.swift
//  LianHuServices
//
//  Created by denglong on 4/12/16.
//  Copyright © 2016 邓龙. All rights reserved.
//

import UIKit

let bottomViewHeight:CGFloat = 110

protocol BottomSelectDelegate {
    func clickBottomButtonTag(tag:NSInteger)
}

class BottomSelectCell: UITableViewCell {
    
    var delegate:BottomSelectDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        for i in 0..<3 {
            let lineView = UIView(frame: CGRectMake(VIEWWIDTH/4 + VIEWWIDTH/4*CGFloat(i), 0, COMMINUTELINE, bottomViewHeight))
            lineView.backgroundColor = UIColor(hex: "cccccc")
            self.addSubview(lineView)
        }
        
        for n in 0..<4 {
            let button = UIButton(frame: CGRectMake(CGFloat(n)*VIEWWIDTH/4, 0, VIEWWIDTH/4, bottomViewHeight))
            button.tag = n
            button.addTarget(self, action: #selector(BottomSelectCell.clickButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(button)
        }
    }
    
    func clickButtonAction(sender:UIButton) {
        self.delegate.clickBottomButtonTag(sender.tag)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
