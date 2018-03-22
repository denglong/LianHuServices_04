//
//  HomeScrollCell.swift
//  LianHuServices
//
//  Created by denglong on 4/12/16.
//  Copyright © 2016 邓龙. All rights reserved.
//

import UIKit

let homeScrollHeight:CGFloat = 100

protocol HomeSelectDelegate {
    func clickHomeSelectAction(tag:NSInteger)
}

class HomeScrollCell: UITableViewCell {

    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var pageView: UIView!
    var delegate:HomeSelectDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        myScrollView.bounces = true
        myScrollView.pagingEnabled = true
        
        let imgList = [["wy_01", "wy_02", "wy_03", "wy_04"], ["wy_05", "wy_06", "wy_07", "wy_08"], ["wy_09", "wy_10", "wy_11", "wy_12"]]
        let nameList = [["环保绿标", "婚姻登记", "企业登记", "补医保卡"], ["办老年证", "保障房", "办公证", "文化许可"], ["卫生许可", "餐饮许可", "电梯登记", "更多"]]
        createScrollSubViewAction(imgList, nameList: nameList)
    }
    
    func createScrollSubViewAction(imgList:Array<Array<String>>, nameList:Array<Array<String>>) {
        for i in 0..<3 {
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
            
            for n in 0..<4 {
                let button = UIButton(frame: CGRectMake(CGFloat(n)*VIEWWIDTH/4, 0, VIEWWIDTH/4, homeScrollHeight))
                button.tag = n
                button.addTarget(self, action: #selector(HomeScrollCell.clickSelectButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                homeView.addSubview(button)
            }
        }
        myScrollView.tag = 2
        myScrollView.contentSize = CGSizeMake(VIEWWIDTH*3, 0)
    }
    
    func clickSelectButtonAction(sender:UIButton) {
        self.delegate.clickHomeSelectAction(sender.tag)
    }
    
    func setPageControlAction(myView:UIView) {
        pageView.addSubview(myView)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
