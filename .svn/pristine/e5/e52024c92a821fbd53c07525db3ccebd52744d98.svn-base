//
//  BedpanHeaderCell.swift
//  LianHuServices
//
//  Created by 邓龙 on 18/02/2017.
//  Copyright © 2017 邓龙. All rights reserved.
//

import UIKit

protocol BedpanHeaderDelegate {
    func clickBedpanHeaderAction(tag:NSInteger)
}

class BedpanHeaderCell: UITableViewCell {
    
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var pageView: UIView!
    var delegate:BedpanHeaderDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = UITableViewCellSelectionStyle.None
        
        myScrollView.bounces = true
        myScrollView.pagingEnabled = true
        
        let imgList = [["nvv_04", "nvv_05", "nvv_02", "nvv_03"]]
        let nameList = [["健康顾问", "心理咨询", "挂失登报", "刻公章"]]
        createScrollSubViewAction(imgList, nameList: nameList)
    }
    
    func createScrollSubViewAction(imgList:Array<Array<String>>, nameList:Array<Array<String>>) {
        for i in 0..<nameList.count {
            let homeView = NSBundle.mainBundle().loadNibNamed("MiddleSelectCell", owner: self, options: nil)!.first as! MiddleSelectCell
            
            homeView.firstImg.image = UIImage(named: imgList[i][0])
            homeView.firstName.text = nameList[i][0]
            homeView.secondImg.image = UIImage(named: imgList[i][1])
            homeView.secondName.text = nameList[i][1]
            homeView.thirdImg.image = UIImage(named: imgList[i][2])
            homeView.thirdName.text = nameList[i][2]
            homeView.fourImg.image = UIImage(named: imgList[i][3])
            homeView.fourName.text = nameList[i][3]
            
            homeView.frame = CGRectMake(CGFloat(i)*VIEWWIDTH, 0, VIEWWIDTH, homeScrollHeight)
            myScrollView.addSubview(homeView)
            
            for n in 0..<nameList[i].count {
                let button = UIButton(frame: CGRectMake(CGFloat(n)*VIEWWIDTH/4, 0, VIEWWIDTH/4, homeScrollHeight))
                button.tag = n
                button.addTarget(self, action: #selector(HomeScrollCell.clickSelectButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                homeView.addSubview(button)
            }
        }
        myScrollView.tag = 5
        myScrollView.contentSize = CGSizeMake(VIEWWIDTH*1, 0)
    }
    
    func clickSelectButtonAction(sender:UIButton) {
        self.delegate.clickBedpanHeaderAction(sender.tag)
    }
    
    func setPageControlAction(myView:UIView) {
        myView.frame = PAGECONTFRAME
        pageView.addSubview(myView)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
