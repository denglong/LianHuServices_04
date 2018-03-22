//
//  MySubscribeController.swift
//  LianHuServices
//
//  Created by denglong on 16/4/17.
//  Copyright © 2016年 邓龙. All rights reserved.
//  我的预约或我的预审

import UIKit

var isSubscribe:Bool!

class MySubscribeController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mySubscribeTableView: UITableView!
    @IBOutlet weak var nullDataLab: UILabel!
    var infoList:Array<Dictionary<String, String>>! = []
    var indexPage:NSInteger = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerTableCellAction()
        if isSubscribe ==  true {
            title = "我的预约"
        }
        else
        {
            title = "我的预审"
        }
        
        createRefreshAction(mySubscribeTableView)
    }
    
    func registerTableCellAction() {
        let headerView = UIView(frame: CGRectMake(0, 0, VIEWWIDTH, 10))
        headerView.backgroundColor = view.backgroundColor
        mySubscribeTableView.tableHeaderView = headerView
        
        mySubscribeTableView.registerNib(UINib(nibName: "AppointmenCell", bundle: nil), forCellReuseIdentifier: "AppointmenCell")
        mySubscribeTableView.registerNib(UINib(nibName: "PreliminaryCell", bundle: nil), forCellReuseIdentifier: "PreliminaryCell")
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if isSubscribe == true {
            return 50
        }
        else
        {
            return 43
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if isSubscribe == true {
            let cell = tableView.dequeueReusableCellWithIdentifier("AppointmenCell") as! AppointmenCell
            if infoList.count > 0 {
                cell.contentLab.text = infoList[indexPath.row]["title"]
                cell.timeDate.text = infoList[indexPath.row]["yy_date"]
            }
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("PreliminaryCell") as! PreliminaryCell
            cell.contentLab.text = infoList[indexPath.row]["title"]
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let ID = infoList[indexPath.row]["id"]
        let general = GeneralWebController(nibName: "GeneralWebController", bundle: nil)
        if isSubscribe == false {
            general.title = "我的预审"
            general.urlStr = String(stringInterpolation: API_URL,"?action_type=mb_yushen_content","&id=",ID!)
        }
        else
        {
            general.title = "我的预约"
            general.urlStr = String(stringInterpolation: API_URL,"?action_type=mb_yuyue_content","&id=",ID!)
        }
        
        navigationController?.pushViewController(general, animated: true)
    }
    
    override func headerRefreshing() {
        indexPage = 1
        infoList = []
        apiRequstMySubscribeDataAction()
    }
    
    override func footerRefreshing() {
        indexPage += 1
        apiRequstMySubscribeDataAction()
    }

    //MARK: - Api request my subscribe data handle action
    func apiRequstMySubscribeDataAction() {
        if !LoginInfoModel.isLogined() {
            return
        }
        let userId = CommClass.sharedCommon().localObjectForKey(USER_ID)
        var params = ["action_type":"mb_yuyue_list", "user_id":userId, "cp":String(indexPage)]
        if isSubscribe == false {
            params = ["action_type":"mb_yushen_list", "user_id":userId, "cp":String(indexPage)]
        }
        clientNetwork.requestDataMethParameters(params, success:
            { (data:AnyObject!, response:NSURLResponse!) in
                
                dispatch_async(dispatch_get_main_queue(), {
                    let dataList:Array<Dictionary<String, String>> = data as! Array
                    if dataList.count == 0 {
                        if self.indexPage > 1 {
                            self.indexPage -= 1
                        }
                    }
                    for dic:Dictionary<String, String> in dataList {
                        self.infoList.append(dic)
                    }
                    
                    self.hiddenHUD()
                    if self.infoList.count == 0 {
                        self.nullDataLab.hidden = false
                        self.mySubscribeTableView.hidden = true
                    }
                    else
                    {
                        self.nullDataLab.hidden = true
                        self.mySubscribeTableView.hidden = false
                        self.mySubscribeTableView.reloadData()
                    }
                    self.refreshHeaderView.endRefreshing()
                    self.refreshFooterView.endRefreshing()
                })
                
        }) { (error:NSError!) in
            if self.indexPage > 1 {
                self.indexPage -= 1
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.hiddenHUD()
                self.refreshHeaderView.endRefreshing()
                self.refreshFooterView.endRefreshing()
            })
            print(error)
        }
    }
    
}
