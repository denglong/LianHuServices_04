//
//  OnLineSubscribeController.swift
//  LianHuServices
//
//  Created by denglong on 16/4/17.
//  Copyright © 2016年 邓龙. All rights reserved.
//  在线预约或在线预审

import UIKit

var isOnLineSubscribe:Bool!

class OnLineSubscribeController: BaseViewController {

    @IBOutlet weak var onLineSubscribeTableView: UITableView!
    @IBOutlet weak var searchBtr:UISearchBar!
    var infoList:Array<Dictionary<String, String>>! = []
    var indexPage:NSInteger = 1
    var searchStr:String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if isOnLineSubscribe == true {
            title = "在线预约"
        }
        else
        {
            title = "在线预审"
        }
        
        registerTableCellAction()
        createRefreshAction(onLineSubscribeTableView)
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchStr = searchBar.text
        searchBar.resignFirstResponder()
        headerRefreshing()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchStr = searchBar.text
        searchBar.resignFirstResponder()
        headerRefreshing()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        searchBtr.resignFirstResponder()
    }

    func registerTableCellAction() {
        onLineSubscribeTableView.registerNib(UINib(nibName: "PreliminaryCell", bundle: nil), forCellReuseIdentifier: "PreliminaryCell")
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
        let cell = tableView.dequeueReusableCellWithIdentifier("PreliminaryCell") as! PreliminaryCell
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
        general.urlStr = String(stringInterpolation: API_URL,"?action_type=bszn_info","&id=",ID!, "&uid=", userId!)
        navigationController?.pushViewController(general, animated: true)
    }
    
    override func headerRefreshing() {
        indexPage = 1
        infoList = []
        apiRequstonLineDataAction()
    }
    
    override func footerRefreshing() {
        if infoList.count >= 15 {
            indexPage += 1
            apiRequstonLineDataAction()
        }
        else
        {
            self.refreshFooterView.endRefreshing()
        }
    }
    
    //MARK: - Api request onLine data handle action
    func apiRequstonLineDataAction() {
        var params = ["action_type":"bszn_yy_list", "kw":searchStr, "cp":String(indexPage)]
        if isOnLineSubscribe == false {
            params = ["action_type":"bszn_ys_list", "kw":searchStr, "cp":String(indexPage)]
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
                    self.refreshHeaderView.endRefreshing()
                    self.refreshFooterView.endRefreshing()
                    self.onLineSubscribeTableView.reloadData()
                })
                
        }) { (error:NSError!) in
            if self.indexPage > 1 {
                self.indexPage -= 1
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.hiddenHUD()
                self.refreshHeaderView.endRefreshing()
                self.refreshFooterView.endRefreshing()
                self.onLineSubscribeTableView.reloadData()
            })
            print(error)
        }
    }

}
