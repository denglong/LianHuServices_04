//
//  MyHaveHomeController.swift
//  LianHuServices
//
//  Created by denglong on 16/4/24.
//  Copyright © 2016年 邓龙. All rights reserved.
//

import UIKit

var MYHAVETITLE:String!
var HOME_NOTE_ID:String!

class MyHaveHomeController: BaseViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var myHaveTableView: UITableView!
    var infoList:Array<Dictionary<String, String>>! = []
    var indexPage:NSInteger = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = MYHAVETITLE
        registerTableViewCell()
        createRefreshAction(myHaveTableView)
        showHUD()
    }
    
    func registerTableViewCell() {
        myHaveTableView.registerNib(UINib(nibName: "MyFingerCell", bundle: nil), forCellReuseIdentifier: "MyFingerCell")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 43
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyFingerCell") as! MyFingerCell
        if infoList.count > 0 {
            cell.contentLab.text = infoList[indexPath.row]["title"]
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let ID = infoList[indexPath.row]["id"]
        let userId = CommClass.sharedCommon().localObjectForKey(USER_ID) as? String
        let general = GeneralWebController(nibName: "GeneralWebController", bundle: nil)
        general.title = title
        general.isShowShare = true
        general.urlStr = String(stringInterpolation: API_URL,"?action_type=bszn_info","&id=",ID!, "&uid=", userId!)
        navigationController?.pushViewController(general, animated: true)
    }
    
    override func headerRefreshing() {
        indexPage = 1
        infoList = []
        apiRequstMyHaveDataAction()
    }
    
    override func footerRefreshing() {
        if infoList.count >= 15 {
            indexPage += 1
            apiRequstMyHaveDataAction()
        }
        else
        {
            self.refreshFooterView.endRefreshing()
        }
    }
    
    //MARK: - Api request homePage handle action
    func apiRequstMyHaveDataAction() {
           let params = ["action_type":"bszn_list", "node_id":HOME_NOTE_ID, "cp":String(indexPage)]
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
                    self.refreshHeaderView.endRefreshing()
                    self.refreshFooterView.endRefreshing()
                    self.myHaveTableView.reloadData()
                })
                
        }) { (error:NSError!) in
            if self.indexPage > 1 {
                self.indexPage -= 1
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.hiddenHUD()
                self.refreshHeaderView.endRefreshing()
                self.refreshFooterView.endRefreshing()
                self.myHaveTableView.reloadData()
            })
            print(error)
        }
    }
}
