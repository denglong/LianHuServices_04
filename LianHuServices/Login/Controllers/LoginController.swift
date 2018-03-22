//
//  LoginController.swift
//  LianHuServices
//
//  Created by denglong on 16/5/7.
//  Copyright © 2016年 邓龙. All rights reserved.
//

import UIKit

class LoginController: BaseViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginScrollView: UIScrollView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headerImg: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "会员中心"
        createLeftBackBtn()
        
        middleView.layer.borderWidth = 0.5
        middleView.layer.borderColor = UIColor(hex: "CCCCCC").CGColor
        self.edgesForExtendedLayout = UIRectEdge.None
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        userName.resignFirstResponder()
        password.resignFirstResponder()
    }
    
    func createLeftBackBtn() {
        let button =   UIButton(type: .System)
        button.frame = CGRectMake(0, 0, 20, 20)
        var backImg = UIImage(named: "back_icon")
        backImg = backImg?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        button.setImage(backImg, forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(LoginController.loginBackAction), forControlEvents: .TouchUpInside)
        let leftBarBtn = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = leftBarBtn
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if VIEWHEIGHT < 500 {
            loginScrollView.contentOffset = CGPointMake(0, 180)
        }
        if VIEWHEIGHT > 500 && VIEWHEIGHT < 600 {
            loginScrollView.contentOffset = CGPointMake(0, 100)
        }
        if textField.tag ==  1 && VIEWHEIGHT > 600 {
            loginScrollView.contentOffset = CGPointMake(0, 40)
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        loginScrollView.contentOffset = CGPointMake(0, 0)
    }
    
    //MARK: - Login handle action
    @IBAction func loginAction(sender: UIButton) {
        if userName.text?.length == 0 {
            SRMessage.infoMessage("用户名不能为空", clickStr: "确定")
        }
        else if password.text?.length == 0 {
            SRMessage.infoMessage("密码不能为空", clickStr: "确定")
        }
        else
        {
            if userName.text?.length <= 5 {
                apiRequstSystemLoginDataAction(userName.text!, password: password.text!)
            }
            else
            {
                apiRequstLoginDataAction(userName.text!, password: password.text!)
            }
        }
    }
    
    //MARK: - To register page handle action
    @IBAction func registerAction(sender: UIButton) {
        let register = RegisterController(nibName: "RegisterController", bundle: nil)
        navigationController?.pushViewController(register, animated: true)
//        performSegueWithIdentifier("register", sender: self)
    }
    
    //MARK: - Save password no or yes handle action
    @IBAction func savePasswordSwitchAction(sender: UISwitch) {
        if sender.on {
            print("save password")
        }
        else
        {
            print("clear password")
        }
    }
    
    //MARK: - Login page back handle action
    func loginBackAction(sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        UIApplication.sharedApplication().keyWindow!.rootViewController = storyboard.instantiateInitialViewController()
    }
    
    //MARK: - Hidden keyboard handle action
    @IBAction func hiddenKeyboardAction(sender: UITapGestureRecognizer) {
        
        userName.resignFirstResponder()
        password.resignFirstResponder()
    }
    
    //MARK: - Api general urer request loginData handle action
    func apiRequstLoginDataAction(loginUserName:String, password:String) {
        showHUD()
        let params = ["action_type":"login", "account":loginUserName, "pw":password]
        clientNetwork.requestDataMethParameters(params, success:
            { (data:AnyObject!, response:NSURLResponse!) in
                
                print(data)
                let result = data.objectForKey("result")?.boolValue
                dispatch_async(dispatch_get_main_queue(), {
                    self.hiddenHUD()
                    if result == true {
                        let user_id = data.objectForKey("user_id") as! String
                        let user_name = data.objectForKey("user_name") as! String
                        LoginInfoModel.saveLoginInfoAction(user_id, user_name: user_name, user: self.userName.text!)
                        LoginInfoModel.saveUserAndPassword(loginUserName, password: password)
                        
                        GeTuiSdk.setPushModeForOff(false)
                        
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                    else
                    {
                        SRMessage.infoMessage("登录失败", clickStr: "确定")
                    }
                })
                
        }) { (error:NSError!) in
            dispatch_async(dispatch_get_main_queue(), {
                self.hiddenHUD()
            })
            print(error)
        }
    }
    
    //MARK: - Api system urer request loginData handle action
    func apiRequstSystemLoginDataAction(loginUserName:String, password:String) {
        self.showHUD()
        let params = ["action_type":"login", "account":loginUserName, "pw":password]
        clientNetwork.requestDataMethodSystemParameters(params, success:
            { (data:AnyObject!, response:NSURLResponse!) in
                
                print(data)
                let result = data.objectForKey("result")?.boolValue
                dispatch_async(dispatch_get_main_queue(), {
                    self.hiddenHUD()
                    if result == true {
                        let user_id = data.objectForKey("user_id") as! String
                        let user_name = data.objectForKey("user_name") as! String
                        let is_bj = data.objectForKey("is_bj") as! String
                        let is_tj = data.objectForKey("is_tj") as! String
                        LoginInfoModel.saveLoginInfoAction(user_id, user_name: user_name, user: self.userName.text!)
                        LoginInfoModel.saveUserAndPassword(loginUserName, password: password)
                        CommClass.sharedCommon().localObject(is_bj, forKey: "is_bj")
                        CommClass.sharedCommon().localObject(is_tj, forKey: "is_tj")
                        
                        self.bindAliasAction()
                        GeTuiSdk.setPushModeForOff(false)
                        
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                    else
                    {
                        SRMessage.infoMessage("登录失败", clickStr: "确定")
                    }
                })
                
        }) { (error:NSError!) in
            dispatch_async(dispatch_get_main_queue(), {
                self.hiddenHUD()
            })
            print(error)
        }
    }
    
    func bindAliasAction() {
        var userId = CommClass.sharedCommon().localObjectForKey(USER_ID) as! String
        if userId.isEmpty {
            userId = ""
        }
        var token = CommClass.sharedCommon().objectForKey("DEVICETOKEN")
        if token == nil {
            token = ""
        }
        var clientid = GeTuiSdk.clientId()
        if clientid.isEmpty {
            clientid = ""
        }
        let params = ["action_type":"add_app_client", "token":token, "clientid":clientid, "user_id":userId]
        clientNetwork.requestDataMethodSystemParameters(params, success:
            { (data:AnyObject!, response:NSURLResponse!) in
                
                print(data)
                
        }) { (error:NSError!) in
            print(error)
        }
    }

}
