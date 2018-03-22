//
//  DataBaseController.swift
//  LianHuServices
//
//  Created by 邓龙 on 18/02/2017.
//  Copyright © 2017 邓龙. All rights reserved.
//

import UIKit

class DataBaseController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dataBaseTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataBaseTableView = UITableView()
        dataBaseTableView.frame = CGRectMake(0, 15, view.frame.size.width, view.frame.size.height)
        dataBaseTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        dataBaseTableView.backgroundColor = UIColor(hex: BGCOLOR)
        dataBaseTableView.delegate = self
        dataBaseTableView.dataSource = self
        view.addSubview(dataBaseTableView)

        dataBaseTableView.registerNib(UINib(nibName: "DateBaseCell", bundle: nil), forCellReuseIdentifier: "DateBaseCell")
        
        let footView = UIView(frame: CGRectMake(0, 0, VIEWWIDTH, 0))
        dataBaseTableView.tableFooterView = footView
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        if !LoginInfoModel.isLogined() {
            countWellcomeAction()
        }
        else
        {
            let userName:String = CommClass.sharedCommon().localObjectForKey(USER) as! String
            if (userName.length > 5) {
                
                self.tabBarController?.selectedIndex = 1
                SRMessage.infoMessage("对不起，你没有权限查阅", delegate: self)
            }
        }
    }
    
    //MARK: - Hidden wellcome image handle action
    func countWellcomeAction() {
        let login = LoginController(nibName: "LoginController", bundle: nil)
        let navigation = NavigationController(rootViewController: login)
        presentViewController(navigation, animated: false, completion: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DateBaseCell") as! DateBaseCell
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let general = GeneralWebController(nibName: "GeneralWebController", bundle: nil)
        general.title = "企业信息查询"
        general.isShowShare = false
        general.urlStr = "https://zw.lianhu.gov.cn/usexzsp/phone_interface2.jsp?action_type=dwcx&user_id=164"
        navigationController?.pushViewController(general, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
