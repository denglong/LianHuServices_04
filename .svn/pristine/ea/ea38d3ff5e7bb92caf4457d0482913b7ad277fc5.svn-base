//
//  HomeSubController.swift
//  LianHuServices
//
//  Created by denglong on 16/4/24.
//  Copyright © 2016年 邓龙. All rights reserved.
//

import UIKit

var HOMESUBTITLE:String!

class HomeSubController: BaseViewController, UISearchBarDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var homeSubSearch: UISearchBar!
    var infoList:Array<Dictionary<String, String>>! = []
    var searchStr:String! = ""
    var indexPage:NSInteger = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        title = HOMESUBTITLE
        registerTableViewCell()
        createRefreshAction(homeTableView)
        showHUD()
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchStr = searchBar.text
        searchBar.resignFirstResponder()
        headerRefreshing()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchStr = searchBar.text
        homeSubSearch.resignFirstResponder()
        headerRefreshing()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        homeSubSearch.resignFirstResponder()
    }
    
    func registerTableViewCell() {
        homeTableView.registerNib(UINib(nibName: "PreliminaryCell", bundle: nil), forCellReuseIdentifier: "PreliminaryCell")
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
        general.title = "预审"
        general.urlStr = String(stringInterpolation: API_URL,"?action_type=bszn_info","&id=",ID!, "&uid=", userId!)
        navigationController?.pushViewController(general, animated: true)
    }

    override func headerRefreshing() {
        indexPage = 1
        infoList = []
        apiRequstHomeSubDataAction()
    }
    
    override func footerRefreshing() {
        if infoList.count >= 15 {
            indexPage += 1
            apiRequstHomeSubDataAction()
        }
        else
        {
            self.refreshFooterView.endRefreshing()
        }
    }

    //MARK: - Api request homePage handle action
    func apiRequstHomeSubDataAction() {
        let params = ["action_type":"bszn_ys_list", "kw":searchStr, "cp":String(indexPage)]
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
                    self.homeTableView.reloadData()
                })
                
        }) { (error:NSError!) in
            if self.indexPage > 1 {
                self.indexPage -= 1
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.hiddenHUD()
                self.refreshHeaderView.endRefreshing()
                self.refreshFooterView.endRefreshing()
                self.homeTableView.reloadData()
            })
            print(error)
        }
    }
}
