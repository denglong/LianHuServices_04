//
//  BaseViewController.swift
//  LianHuServices
//
//  Created by denglong on 4/11/16.
//  Copyright © 2016 邓龙. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {

    var HUD:MBProgressHUD!
    var HUDTimer:NSTimer!
    var refreshHeaderView:MJRefreshHeader!
    var refreshFooterView:MJRefreshFooter!
    var isViewDidAppear:Bool! = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(hex: BGCOLOR)
        createLeftBackButtonAction()
        createProgRessHUD()
        if navigationController?.viewControllers.count > 1 {
            self.navigationController?.interactivePopGestureRecognizer!.delegate = self
        }
        setNavigationTitle()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        isViewDidAppear = true
    }
    
    func setNavigationTitle() {
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        navigationController!.navigationBar.barTintColor = UIColor(hex: "00558e")
        
        let titleColor = UIColor.whiteColor()
        let navigationTitleAttribute: NSDictionary = NSDictionary(object: titleColor, forKey: NSForegroundColorAttributeName)
        navigationController!.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String : AnyObject]
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if isViewDidAppear == false {
            return isViewDidAppear
        }
        return navigationController?.viewControllers.count > 1
    }
    
    func createLeftBackButtonAction() {
        if navigationController?.viewControllers.count > 1 {
            let button =   UIButton(type: .System)
            button.frame = CGRectMake(0, 0, 20, 20)
            var backImg = UIImage(named: "back_icon")
            backImg = backImg?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
            button.setImage(backImg, forState: UIControlState.Normal)
            button.addTarget(self, action: #selector(BaseViewController.backUpPageAction), forControlEvents: .TouchUpInside)
            let leftBarBtn = UIBarButtonItem(customView: button)
            navigationItem.leftBarButtonItem = leftBarBtn
        }
    }
    
    func backUpPageAction(){
        navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK: - Create time loading handle action
    func createProgRessHUD() {
        HUD = MBProgressHUD(view: navigationController?.view)
        navigationController?.view.addSubview(HUD)
    }
    
    func showHUD() {
        HUD.show(true)
        HUDTimer = NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: #selector(BaseViewController.timeOutAction), userInfo: nil, repeats: false)
    }

    func timeOutAction() {
        hiddenHUD()
    }
    
    func hiddenHUD() {
        HUD.hide(true)
        if HUDTimer != nil {
            HUDTimer.invalidate()
            HUDTimer = nil
        }
    }
    
    //MARK: - Create refresh handle action
    func createRefreshAction(tableView:AnyObject) {
        let refreshTableTableView = tableView as! UITableView
        let weakSelf = self
        let header = MJRefreshNormalHeader { 
            weakSelf.headerRefreshing()
        }
        refreshTableTableView.mj_header = header
        /** Into pageView begin refresh */
        refreshTableTableView.mj_header.beginRefreshing()
        header.setTitle("正在努力为您刷新!", forState: MJRefreshState.Refreshing)
        
        let footer = MJRefreshBackNormalFooter {
            weakSelf.footerRefreshing()
        }
        refreshTableTableView.mj_footer = footer
        footer.setTitle("正在努力为您加载!", forState: MJRefreshState.Refreshing)
        
        refreshHeaderView = refreshTableTableView.mj_header
        refreshFooterView = refreshTableTableView.mj_footer
    }
    
    func createRefreshNoAction(tableView:AnyObject) {
        let refreshTableTableView = tableView as! UITableView
        let weakSelf = self
        let header = MJRefreshNormalHeader {
            weakSelf.headerRefreshing()
        }
        refreshTableTableView.mj_header = header
        /** Into pageView begin refresh */
        header.setTitle("正在努力为您刷新!", forState: MJRefreshState.Refreshing)
        
        let footer = MJRefreshBackNormalFooter {
            weakSelf.footerRefreshing()
        }
        refreshTableTableView.mj_footer = footer
        footer.setTitle("正在努力为您加载!", forState: MJRefreshState.Refreshing)
        
        refreshHeaderView = refreshTableTableView.mj_header
        refreshFooterView = refreshTableTableView.mj_footer
    }
    
    func headerRefreshing(){}
    func footerRefreshing(){}
}
