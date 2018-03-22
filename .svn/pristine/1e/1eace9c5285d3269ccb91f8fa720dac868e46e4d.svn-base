//
//  BulletinViewController.swift
//  LianHuServices
//
//  Created by denglong on 4/11/16.
//  Copyright © 2016 邓龙. All rights reserved.
//

import UIKit

class BulletinViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var bulletinTableView: UITableView!
    var titleNames:Array<String>! = []
    var infoDic:NSDictionary!
    var infoList:Array<Dictionary<String, String>>! = []
    var informList:Array<Dictionary<String, String>>! = []
    var namekeys:Array<String>! = []
    var requestTags:Array<String>! = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableCellAndHeaderViewAction()
        apiRequstBulletinDataAction()
        apiRequstBulletinNotificationDataAction()
        self.edgesForExtendedLayout = UIRectEdge.None
    }
    
    func registerTableCellAndHeaderViewAction() {
        bulletinTableView.registerNib(UINib(nibName: "BulletinViewCell", bundle: nil), forCellReuseIdentifier: "BulletinViewCell")
        titleNames = ["政务要闻", "部门动态", "街道动态", "通知公告"]
        namekeys = ["zwyw", "bmdt", "jddt", ""]
        requestTags = ["10002", "10003", "10004",""]
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 3 {
            return informList.count
        }
        return infoList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 46
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BulletinViewCell") as! BulletinViewCell
        if indexPath.section != 3 {
            infoList = infoDic.objectForKey(namekeys[indexPath.section]) as! Array
            if infoList.count > 0 {
                cell.bulletinContentLab.text = infoList[indexPath.row]["title"]
            }
        }
        else
        {
            if informList.count > 0 {
                cell.bulletinContentLab.text = informList[indexPath.row]["title"]
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if infoList.count == 0 && section != 3 {
            return 0
        }
        if informList.count == 0 && section == 3 {
            return 0
        }
        return 55
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cellHeaderView = NSBundle.mainBundle().loadNibNamed("CellHeaderView", owner: self, options: nil)!.first as! CellHeaderView
        cellHeaderView.frame = CGRectMake(0, 0, VIEWWIDTH, 55)
        cellHeaderView.titleName.text = titleNames[section]
        cellHeaderView.moreButton.tag = section
        cellHeaderView.moreButton.addTarget(self, action: #selector(BulletinViewController.clickMoreButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        return cellHeaderView
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var infoID = ""
        var titleStr = "zwyw_content"
        if indexPath.section == 3 {
            infoID = informList[indexPath.row]["id"]!
            titleStr = "info_content"
        }
        else
        {
            infoList = infoDic.objectForKey(namekeys[indexPath.section]) as! Array
            infoID = infoList[indexPath.row]["id"]!
        }
        let general = GeneralWebController(nibName: "GeneralWebController", bundle: nil)
        general.title = titleNames[indexPath.section]
        general.isShowShare = true
        general.urlStr = String(stringInterpolation: API_URL,"?action_type=",titleStr,"&id=",infoID)
        navigationController?.pushViewController(general, animated: true)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let sectionHeaderHeight:CGFloat = 55
        if scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0 {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0)
        }
        else if scrollView.contentOffset.y >= sectionHeaderHeight
        {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0)
        }
    }
    
    //MARK: - Click more button handle action
    func clickMoreButtonAction(sender:UIButton) {
        print(sender.tag)
        BULLETINLISTTITLENAME = titleNames[sender.tag]
        BULLETINREQUESTTAG = requestTags[sender.tag]
        performSegueWithIdentifier("bulletinList", sender: self)
    }

    //MARK: - Api request homePage handle action
    func apiRequstBulletinDataAction() {
        showHUD()
        let params = ["action_type":"zwyw_index"]
        clientNetwork.requestDataMethParameters(params, success:
            { (data:AnyObject!, response:NSURLResponse!) in
                
                self.infoDic = data as! NSDictionary
                self.infoList = self.infoDic.objectForKey("zwyw") as! Array
                dispatch_async(dispatch_get_main_queue(), {
                    self.hiddenHUD()
                    self.bulletinTableView.reloadData()
                })
                
        }) { (error:NSError!) in
            dispatch_async(dispatch_get_main_queue(), {
                self.hiddenHUD()
            })
            print(error)
        }
    }
    
    //MARK: - Api request bulletin notification handle action
    func apiRequstBulletinNotificationDataAction() {
        let params = ["action_type":"tzlb_list", "page":"5", "cp":"1"]
        clientNetwork.requestDataMethParameters(params, success:
            { (data:AnyObject!, response:NSURLResponse!) in
                
                self.informList = data as! Array
                dispatch_async(dispatch_get_main_queue(), {
                    self.bulletinTableView.reloadData()
                })
        }) { (error:NSError!) in
            print(error)
        }
    }
}
