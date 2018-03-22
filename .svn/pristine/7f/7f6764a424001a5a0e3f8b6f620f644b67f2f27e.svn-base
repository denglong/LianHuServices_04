//
//  NoteViewController.swift
//  LianHuServices
//
//  Created by denglong on 16/4/25.
//  Copyright © 2016年 邓龙. All rights reserved.
//

import UIKit

class NoteViewController: BaseViewController {

    @IBOutlet weak var noteTableView: UITableView!
    var infoList:Array<Dictionary<String, String>>! = []
    var indexPage:NSInteger = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerTableViewCell()
        createRefreshAction(noteTableView)
        showHUD()
    }

    func registerTableViewCell() {
        noteTableView.registerNib(UINib(nibName: "BulletinViewCell", bundle: nil), forCellReuseIdentifier: "BulletinViewCell")
        
        let footerView = UIView()
        noteTableView.tableHeaderView = footerView
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
        TITLETEXT = infoList[indexPath.row]["title"]
        CONTENTTEXT = infoList[indexPath.row]["content"]
        SENDDATA = infoList[indexPath.row]["send_time"]
        performSegueWithIdentifier("noteDetail", sender: self)
    }
    
    override func headerRefreshing() {
        indexPage = 1
        infoList = []
        apiRequstNoteListDataAction()
    }
    
    override func footerRefreshing() {
        indexPage += 1
        apiRequstNoteListDataAction()
    }
    
    //MARK: - Api request homePage handle action
    func apiRequstNoteListDataAction() {
        let userId = CommClass.sharedCommon().localObjectForKey(USER_ID)
        let params = ["action_type":"getMyAppMsgList", "user_id":userId, "cp":indexPage]
        clientNetwork.requestDataMethodSystemParameters(params, success:
            { (data:AnyObject!, response:NSURLResponse!) in
                
                let dataList:Array<Dictionary<String, String>> = data as! Array
                if dataList.count == 0 {
                    if self.indexPage > 1 {
                        self.indexPage -= 1
                    }
                }
                for dic:Dictionary<String, String> in dataList {
                    self.infoList.append(dic)
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.hiddenHUD()
                    self.refreshHeaderView.endRefreshing()
                    self.refreshFooterView.endRefreshing()
                    self.noteTableView.reloadData()
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
