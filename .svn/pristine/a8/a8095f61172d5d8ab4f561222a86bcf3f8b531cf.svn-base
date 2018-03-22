//
//  HeaderSelectCell.swift
//  LianHuServices
//
//  Created by denglong on 4/11/16.
//  Copyright © 2016 邓龙. All rights reserved.
//

import UIKit

let headerCellHeight:CGFloat = 100

protocol HeaderSelectDelegate {
    func clickHeaderSelectAction(tag:NSInteger)
}

class HeaderSelectCell: UITableViewCell {
    
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var pageView: UIView!
    var delegate:HeaderSelectDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = UITableViewCellSelectionStyle.None
        
        myScrollView.bounces = true
        myScrollView.pagingEnabled = true
        
        let imgList = [["nvv_04", "nvv_05", "nvv_02", "nvv_03"], ["nvv_06", "nvv_07", "nvv_08", "nvv_01"]]
        let nameList = [["办事", "咨询", "预审", "查询"], ["交通路线", "楼层分布", "扫一扫", "云服务"]]
        createScrollSubViewAction(imgList, nameList: nameList)
    }
    
    func createScrollSubViewAction(imgList:Array<Array<String>>, nameList:Array<Array<String>>) {
        for i in 0..<2 {
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
                button.addTarget(self, action: #selector(HeaderSelectCell.clickHeaderSelectButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                homeView.addSubview(button)
            }
        }
        myScrollView.tag = 3
        myScrollView.contentSize = CGSizeMake(VIEWWIDTH*2, 0)
    }
    
    func clickHeaderSelectButtonAction(sender:UIButton) {
        self.delegate.clickHeaderSelectAction(sender.tag)
    }
    
    func setPageControlAction(myView:UIView) {
        pageView.addSubview(myView)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
