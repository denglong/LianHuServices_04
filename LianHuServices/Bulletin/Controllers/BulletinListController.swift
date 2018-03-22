//
//  BulletinListController.swift
//  LianHuServices
//
//  Created by denglong on 16/4/24.
//  Copyright © 2016年 邓龙. All rights reserved.
//

import UIKit

var BULLETINLISTTITLENAME:String!
var BULLETINREQUESTTAG:String!

class BulletinListController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var bulletinListTableView: UITableView!
    var infoList:Array<Dictionary<String, String>>! = []
    var indexPage:NSInteger = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = BULLETINLISTTITLENAME
        registerTableViewCell()
        createRefreshAction(bulletinListTableView)
        showHUD()
        
        var image = UIImage(named: "icon_searchXw")
        image = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(HomeViewController.jumpToSearchViewAction))
    }
    
    func jumpToSearchViewAction() {
        let homeSearch = HomeSearchController(nibName: "HomeSearchController", bundle: nil)
        homeSearch.titleStr = BULLETINLISTTITLENAME
        navigationController?.pushViewController(homeSearch, animated: true)
    }
    
    func registerTableViewCell() {
        bulletinListTableView.registerNib(UINib(nibName: "BulletinViewCell", bundle: nil), forCellReuseIdentifier: "BulletinViewCell")
        
        let footerView = UIView()
        bulletinListTableView.tableHeaderView = footerView
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
        if infoList.count > 0 {
            cell.bulletinContentLab.text = infoList[indexPath.row]["title"]
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let infoID = infoList[indexPath.row]["id"]
        var titleStr = "zwyw_content"
        if title == "通知" {
            titleStr = "info_content"
        }
        let general = GeneralWebController(nibName: "GeneralWebController", bundle: nil)
        general.isPush = true
        general.isShowShare = true
        general.urlStr = String(stringInterpolation: API_URL,"?action_type=",titleStr,"&id=",infoID!)
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
        var params = ["action_type":"zwyw_list", "cat_id":BULLETINREQUESTTAG, "cp":String(indexPage)]
        if title == "通知" {
            params = ["action_type":"tzlb_list", "page":"15", "cp":String(indexPage)]
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
                    self.bulletinListTableView.reloadData()
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
