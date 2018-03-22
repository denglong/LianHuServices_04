//
//  MyViewController.swift
//  LianHuServices
//
//  Created by denglong on 4/11/16.
//  Copyright © 2016 邓龙. All rights reserved.
//  

import UIKit

var MYVIEWREFRESH:Bool! = false

class MyViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView:UITableView!
    var imgList:Array<String>! = []
    var nameList:Array<String>! = []
    var systemNameList:Array<Array<String>>! = [[]]
    var systemImgList:Array<Array<String>>! = [[]]
    var indexTag:NSInteger!
    var numberDic:NSDictionary! = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerMyTableViewCell()
        createWellcomeImgAction()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if !LoginInfoModel.isLogined() {
            countWellcomeAction()
        }
        else
        {
            createMyTableDataList()
        }

        if MYVIEWREFRESH == true {
            myTableView.reloadData()
            MYVIEWREFRESH = false
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        ROOTVIEWCONTROLLER = self
    }
    
    //MARK: - Create myTable data array handle action
    func createMyTableDataList() {
        if LoginInfoModel.isSystemUser() {
            systemImgList = [["", "tongji", "huizong"], ["messageImg", "xiugaimima", "settingImg", "tuichu"]]
            systemNameList = [["", "今日统计", "办件汇总"], ["系统消息", "修改密码", "设置", "退出"]]
            apiRequstMyViewDataAction()
        }
        else
        {
            imgList = ["grzx_01", "grzx_02", "grzx_03", "grzx_04", "grzx_05", "grzx_06", "grzx_09"]
            nameList = ["个人信息", "修改密码", "我的预约", "我的预审", "在线预约", "在线预审", "退出"]
        }
        myTableView.reloadData()
    }
    
    func createWellcomeImgAction() {
        
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clearColor()
        myTableView.tableFooterView = footerView
    }
    
    //MARK: - Hidden wellcome image handle action
    func countWellcomeAction() {
        let login = LoginController(nibName: "LoginController", bundle: nil)
        let navigation = NavigationController(rootViewController: login)
        presentViewController(navigation, animated: false, completion: nil)
    }
    
    func registerMyTableViewCell() {
        myTableView.registerNib(UINib(nibName: "MyViewHeaderCell", bundle: nil), forCellReuseIdentifier: "MyViewHeaderCell")
        myTableView.registerNib(UINib(nibName: "MyViewCell", bundle: nil), forCellReuseIdentifier: "MyViewCell")
        myTableView.registerNib(UINib(nibName: "SystemMyViewCell", bundle: nil), forCellReuseIdentifier: "SystemMyViewCell")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if LoginInfoModel.isSystemUser() {
            return 2
        }
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if LoginInfoModel.isSystemUser() {
            return 4
        }
        return nameList.count + 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if LoginInfoModel.isSystemUser() {
            if indexPath.row == 0 && indexPath.section == 0 {
                return VIEWWIDTH*(13.6/64)
            }
            else if indexPath.row == 1 && indexPath.section == 0
            {
                return 60
            }
            else
            {
                return 43
            }
        }
        else
        {
            if indexPath.row == 0 {
                return VIEWWIDTH*(13.6/64)
            }
            else
            {
                return 43
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if LoginInfoModel.isSystemUser() && section == 1 {
            return 15
        }
        else
        {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 && indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("MyViewHeaderCell") as! MyViewHeaderCell
            let userName = String(CommClass.sharedCommon().localObjectForKey(USER_NAME))
            cell.userName.text = userName
            return cell
        }
        else
        {
            if LoginInfoModel.isSystemUser() {
                if indexPath.section == 0 {
                if indexPath.row == 1 {
                    let cell = tableView.dequeueReusableCellWithIdentifier("SystemMyViewCell") as! SystemMyViewCell
                    
                    let waitNum = numberDic.objectForKey("wwc")?.integerValue
                    if waitNum >= 0 {
                        let contentStr = String(format: "%d", waitNum!)
                        cell.waitNum.text = contentStr
                    }
                    let expireNum = numberDic.objectForKey("limit")?.integerValue
                    if expireNum >= 0 {
                        let contentStr = String(format: "%d", expireNum!)
                        cell.expireNum.text = contentStr
                    }
                    let exceedNum = numberDic.objectForKey("over")?.integerValue
                    if exceedNum >= 0 {
                        let contentStr = String(format: "%d", exceedNum!)
                        cell.exceedNum.text = contentStr
                    }
                    let dayBj = numberDic.objectForKey("bj")?.integerValue
                    if dayBj >= 0 {
                        let contentStr = String(format: "%d", dayBj!)
                        cell.dayNum.text = contentStr
                    }
                    if waitNum > 0 {
                        cell.waitButton.addTarget(self, action: #selector(MyViewController.clickFileAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                    }
                    if expireNum > 0 {
                        cell.expireButton.addTarget(self, action: #selector(MyViewController.clickFileAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                    }
                    if exceedNum > 0 {
                        cell.exceedButton.addTarget(self, action: #selector(MyViewController.clickFileAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                    }
                    if dayBj > 0 {
                        cell.dayBtn.addTarget(self, action: #selector(MyViewController.clickFileAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                    }
                    
                    return cell
                }
                
                    let cell = tableView.dequeueReusableCellWithIdentifier("MyViewCell") as! MyViewCell
                    cell.setLeftTitleName(systemNameList[0][indexPath.row - 1], imgName: systemImgList[0][indexPath.row - 1])
                    return cell
                }
                else
                {
                    let cell = tableView.dequeueReusableCellWithIdentifier("MyViewCell") as! MyViewCell
                    cell.setLeftTitleName(systemNameList[1][indexPath.row], imgName: systemImgList[1][indexPath.row])
                    return cell
                }
            }
            
            let cell = tableView.dequeueReusableCellWithIdentifier("MyViewCell") as! MyViewCell
            cell.setLeftTitleName(nameList[indexPath.row - 1], imgName: imgList[indexPath.row - 1])
            return cell
        }
    }
    
    func clickFileAction(sender:UIButton) {
        switch sender.tag {
        case 0:
            FILEVIEWTITLE = "待办件"
            SFLAG = "wwc"
            break
        case 1:
            FILEVIEWTITLE = "到期件"
            SFLAG = "limit_flag"
            break
        case 2:
            FILEVIEWTITLE = "超期件"
            SFLAG = "over_flag"
            break
        case 3:
            FILEVIEWTITLE = "今日办结"
            SFLAG = "bj_flag"
            break
        default:
            break
        }
        performSegueWithIdentifier("fileController", sender: self)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if LoginInfoModel.isSystemUser() {
                if indexPath.section == 0 {
                    switch indexPath.row {
                    case 2:
                        print("今日统计")
                        let userId = CommClass.sharedCommon().localObjectForKey(USER_ID) as? String
                        let general = GeneralWebController(nibName: "GeneralWebController", bundle: nil)
                        general.urlStr = String(stringInterpolation: API_URL_SYSTEM,"?action_type=today_count", "&user_id=", userId!)
                        general.title = "今日统计"
                        navigationController?.pushViewController(general, animated: true)
                        break
                    case 3:
                        print("办件汇总")
                        performSegueWithIdentifier("BanJianHuiZong", sender: self)
                        break
                    default:
                        break
                    }
                }
                else
                {
                    switch indexPath.row {
                    case 0:
                        print("系统消息")
                        performSegueWithIdentifier("noteController", sender: self)
                        break
                    case 1:
                        print("修改密码")
                        performSegueWithIdentifier("amendPassword", sender: self)
                        break
                    case 2:
                        print("设置")
                        performSegueWithIdentifier("setting", sender: self)
                        break
                    default:
                        if LoginInfoModel.isSystemUser() {
                            apiRequstLoginOutDataAction()
                            GeTuiSdk.setPushModeForOff(true)
                        }
                        LoginInfoModel.clearUserInfo()
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        UIApplication.sharedApplication().keyWindow!.rootViewController = storyboard.instantiateInitialViewController()
                        break
                    }
                }
        }
        else
        {
            if indexPath.row != 0 {
                switch indexPath.row {
                case 1:
                    self.performSegueWithIdentifier("personInfo", sender: self)
                    break
                case 2:
                    self.performSegueWithIdentifier("amendPassword", sender: self)
                    break
                case 3,4:
                    indexTag = indexPath.row
                    self.performSegueWithIdentifier("subscribeAndInquiry", sender: self)
                    break
                case 5,6:
                    indexTag = indexPath.row
                    self.performSegueWithIdentifier("onLine", sender: self)
                    break
                default:
                    LoginInfoModel.clearUserInfo()
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    UIApplication.sharedApplication().keyWindow!.rootViewController = storyboard.instantiateInitialViewController()
                    break
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "subscribeAndInquiry" {
            if indexTag == 3 {
                isSubscribe = true
            }
            else
            {
                isSubscribe = false
            }
            return
        }
        if segue.identifier == "onLine" {
            if indexTag == 5 {
                isOnLineSubscribe = true
            }
            else
            {
                isOnLineSubscribe = false
            }
            return
        }
    }
    
    //MARK: - Api request myView data handle action
    func apiRequstMyViewDataAction() {
        if !LoginInfoModel.isLogined() {
            return
        }
        let userId = CommClass.sharedCommon().localObjectForKey(USER_ID)
        let params = ["action_type":"bj_count_prompt", "user_id":userId]
        clientNetwork.requestDataMethodSystemParameters(params, success:
            { (data:AnyObject!, response:NSURLResponse!) in
                
                self.numberDic = data as! NSDictionary
                dispatch_async(dispatch_get_main_queue(), {
                    self.hiddenHUD()
                    self.myTableView.reloadData()
                })
                
        }) { (error:NSError!) in
            dispatch_async(dispatch_get_main_queue(), {
                self.hiddenHUD()
            })
            print(error)
        }
    }
    
    //MARK: - Api request loginOut data handle action
    func apiRequstLoginOutDataAction() {
        if !LoginInfoModel.isLogined() {
            return
        }
        var clientid = GeTuiSdk.clientId()
        if clientid.isEmpty {
            clientid = ""
        }
        let userId = CommClass.sharedCommon().localObjectForKey(USER_ID)
        let params = ["action_type":"unbind_client", "client_id":clientid, "user_id":userId]
        clientNetwork.requestDataMethodSystemParameters(params, success:
            { (data:AnyObject!, response:NSURLResponse!) in
                
        }) { (error:NSError!) in
            print(error)
        }
    }
}
