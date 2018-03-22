//
//  BottomTitleCell.swift
//  LianHuServices
//
//  Created by denglong on 16/4/24.
//  Copyright © 2016年 邓龙. All rights reserved.
//

import UIKit

protocol TitleSelectDelegate {
    func clickTitleSelectAction(sender:UIButton, titleBtnList:NSArray, bottomImgList:NSArray)
}

class BottomTitleCell: UITableViewCell {
    
    @IBOutlet weak var bottomLine:UIImageView!
    var bgView:UIView!
    var clickBtnList:NSMutableArray!
    var bottomImgList:NSMutableArray!
    var delegate:TitleSelectDelegate!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        clickBtnList = NSMutableArray()
        bottomImgList = NSMutableArray()
    }
    
    func createLastClickBtnAction() {
        self.backgroundColor = UIColor.whiteColor()
        if bgView == nil {
            bgView = UIView(frame: CGRectMake(0, 0, VIEWWIDTH, 39.5))
            bgView.backgroundColor = UIColor(hex: "00558e")
            self.addSubview(bgView)
            bottomLine.hidden = true
            
            let bottomImg = UIImageView(frame: CGRectMake(0, 39.5, VIEWWIDTH, 0.5))
            bottomImg.backgroundColor = UIColor(hex: "00558e")
            self.addSubview(bottomImg)
            
            let clickNames:Array<String> = ["要闻", "部门", "街道", "通知"]
            for i in 0..<4 {
                let clickBtn = UIButton(frame: CGRectMake(VIEWWIDTH/4*CGFloat(i), 5, VIEWWIDTH/4, 34.5))
                let bottomImg = UIImageView(frame: CGRectMake(0, clickBtn.frame.size.height - 2, clickBtn.frame.size.width, 2))
                clickBtn.addSubview(bottomImg)
                bottomImgList.addObject(bottomImg)
                if i == 0 {
                    bottomImg.backgroundColor = UIColor(hex: "ec9d00")
                    clickBtn.setTitleColor(UIColor(hex: COMMONALITYGRAYCOLOR), forState: UIControlState.Normal)
                }
                else
                {
                    clickBtn.backgroundColor = UIColor(hex: "00558e")
                    clickBtn.setTitleColor(UIColor(hex: COMMONALITYGRAYCOLOR), forState: UIControlState.Normal)
                }
                clickBtn.titleLabel?.font = UIFont.systemFontOfSize(15)
                clickBtn.setTitle(clickNames[i], forState: UIControlState.Normal)
                
                clickBtn.tag = i
                clickBtn.addTarget(self, action: #selector(BottomTitleCell.clickBtnAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                bgView.addSubview(clickBtn)
                clickBtnList.addObject(clickBtn)
            }
        }
    }
    
    func clickBtnAction(sender:UIButton) {
        let list = clickBtnList as NSArray
        self.delegate.clickTitleSelectAction(sender, titleBtnList: list, bottomImgList: bottomImgList)
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
