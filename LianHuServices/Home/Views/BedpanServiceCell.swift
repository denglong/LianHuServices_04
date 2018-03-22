//
//  BedpanServiceCell.swift
//  LianHuServices
//
//  Created by 邓龙 on 18/02/2017.
//  Copyright © 2017 邓龙. All rights reserved.
//

import UIKit

protocol BedpanServiceDelegate {
    func clickBedpanServiceAction(tag:NSInteger)
}

class BedpanServiceCell: UITableViewCell {
    
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var pageView: UIView!
    var delegate:BedpanServiceDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = UITableViewCellSelectionStyle.None
        
        myScrollView.bounces = true
        myScrollView.pagingEnabled = true
        
        let imgList = [["jb_01", "jb_02", "jb_03", "jb_04"], ["jb_05", "jb_06", "jb_07", "jb_08"], ["jb_09"]]
        let nameList = [["青年路", "北院门", "环城西路", "西关"], ["土门", "红庙坡", "桃园路", "枣园"], ["北关"]]
        createScrollSubViewAction(imgList, nameList: nameList)
    }
    
    func createScrollSubViewAction(imgList:Array<Array<String>>, nameList:Array<Array<String>>) {
        for i in 0..<nameList.count {
            let homeView = NSBundle.mainBundle().loadNibNamed("MiddleSelectCell", owner: self, options: nil)!.first as! MiddleSelectCell
            
            if i == 2 {
                homeView.firstImg.image = UIImage(named: imgList[i][0])
                homeView.firstName.text = nameList[i][0]
            }
            else
            {
                homeView.firstImg.image = UIImage(named: imgList[i][0])
                homeView.firstName.text = nameList[i][0]
                homeView.secondImg.image = UIImage(named: imgList[i][1])
                homeView.secondName.text = nameList[i][1]
                homeView.thirdImg.image = UIImage(named: imgList[i][2])
                homeView.thirdName.text = nameList[i][2]
                homeView.fourImg.image = UIImage(named: imgList[i][3])
                homeView.fourName.text = nameList[i][3]
            }
            
            homeView.frame = CGRectMake(CGFloat(i)*VIEWWIDTH, 0, VIEWWIDTH, homeScrollHeight)
            myScrollView.addSubview(homeView)
            
            for n in 0..<4 {
                if i == 2 && n != 0 {
                    let bgView = UIView(frame: CGRectMake(CGFloat(n)*VIEWWIDTH/4, 0, VIEWWIDTH/4, homeScrollHeight))
                    bgView.backgroundColor = UIColor(hex: BGCOLOR)
                    homeView.addSubview(bgView)
                }
                else
                {
                    let button = UIButton(frame: CGRectMake(CGFloat(n)*VIEWWIDTH/4, 0, VIEWWIDTH/4, homeScrollHeight))
                    button.tag = n
                    button.addTarget(self, action: #selector(HomeScrollCell.clickSelectButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                    homeView.addSubview(button)
                }
            }
        }
        myScrollView.tag = 4
        myScrollView.contentSize = CGSizeMake(VIEWWIDTH*3, 0)
    }
    
    func clickSelectButtonAction(sender:UIButton) {
        self.delegate.clickBedpanServiceAction(sender.tag)
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
