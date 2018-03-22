//
//  HomeSearchController.swift
//  LianHuServices
//
//  Created by denglong on 5/29/16.
//  Copyright © 2016 邓龙. All rights reserved.
//

import UIKit

class HomeSearchController: BaseViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    var infoList:Array<Dictionary<String, String>>! = []
    var searchStr:String! = ""
    var indexPage:NSInteger = 1
    var titleStr:String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "搜索"
        registerTableViewCell()
        createRefreshNoAction(searchTableView)
    }

    func registerTableViewCell() {
        searchTableView.registerNib(UINib(nibName: "BulletinViewCell", bundle: nil), forCellReuseIdentifier: "BulletinViewCell")
        
        let footerView = UIView()
        searchTableView.tableHeaderView = footerView
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchStr = searchBar.text
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchStr = searchBar.text
        searchBar.resignFirstResponder()
        showHUD()
        headerRefreshing()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 51
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BulletinViewCell") as! BulletinViewCell
        cell.bulletinContentLab.text = infoList[indexPath.row]["title"]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let infoID = infoList[indexPath.row]["id"]
        var typeStr = "zwyw_content"
        if titleStr == "通知" {
            typeStr = "info_content"
        }
        let general = GeneralWebController(nibName: "GeneralWebController", bundle: nil)
        general.isPush = true
        general.isShowShare = true
        general.urlStr = String(stringInterpolation: API_URL,"?action_type=",typeStr,"&id=",infoID!)
        navigationController?.pushViewController(general, animated: true)
    }
    
    override func headerRefreshing() {
        indexPage = 1
        infoList = []
        apiRequstBulletinListDataAction()
    }
    
    override func footerRefreshing() {
        indexPage += 1
        apiRequstBulletinListDataAction()
    }
    
    //MARK: - Api request homePage handle action
    func apiRequstBulletinListDataAction() {
        var params = ["action_type":"zwyw_list", "cat_id":"10002", "cp":String(indexPage), "kw":searchStr]//,10003,10004
        if titleStr == "要闻" {
            params = ["action_type":"zwyw_list", "cat_id":"10002", "cp":String(indexPage), "kw":searchStr]
        }
        if titleStr == "部门" {
            params = ["action_type":"zwyw_list", "cat_id":"10003", "cp":String(indexPage), "kw":searchStr]
        }
        if titleStr == "街道" {
            params = ["action_type":"zwyw_list", "cat_id":"10004", "cp":String(indexPage), "kw":searchStr]
        }
        if titleStr == "通知" {
            params = ["action_type":"tzlb_list", "page":"15", "cp":String(indexPage), "kw":searchStr]
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
                    
                    if (self.infoList.count == 0) {
                        self.searchTableView.hidden = true
                    }
                    else
                    {
                        self.searchTableView.hidden = false
                    }
                    
                    self.hiddenHUD()
                    self.refreshHeaderView.endRefreshing()
                    self.refreshFooterView.endRefreshing()
                    self.searchTableView.reloadData()
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
