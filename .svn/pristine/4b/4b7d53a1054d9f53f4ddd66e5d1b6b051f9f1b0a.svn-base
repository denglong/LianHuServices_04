//
//  RegisterController.swift
//  LianHuServices
//
//  Created by denglong on 16/5/7.
//  Copyright © 2016年 邓龙. All rights reserved.
//

import UIKit

class RegisterController: BaseViewController {
    
    @IBOutlet weak var registerScrollView: UIScrollView!
    @IBOutlet weak var loginUserName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmationPassword: UITextField!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var headerImg: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "会员注册"
        
        self.edgesForExtendedLayout = UIRectEdge.None
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        loginUserName.resignFirstResponder()
        password.resignFirstResponder()
        confirmationPassword.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if VIEWHEIGHT < 500 {
            registerScrollView.contentOffset = CGPointMake(0, 200)
        }
        if VIEWHEIGHT > 500 && VIEWHEIGHT < 600 {
            registerScrollView.contentOffset = CGPointMake(0, 100)
        }
        if textField.tag ==  1 && VIEWHEIGHT > 600 {
            registerScrollView.contentOffset = CGPointMake(0, 40)
        }
        if textField.tag ==  2 && VIEWHEIGHT > 600 {
            registerScrollView.contentOffset = CGPointMake(0, 70)
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        registerScrollView.contentOffset = CGPointMake(0, 0)
    }
    
    @IBAction func registerUserAction(sender:UIButton) {
        if loginUserName.text?.length == 0 {
            SRMessage.infoMessage("用户名不能为空", clickStr: "确定")
            return
        }
        else if loginUserName.text?.length < 6 {
            SRMessage.infoMessage("用户名必须大于5位", clickStr: "确定")
            return
        }
        else if password.text?.length == 0 {
            SRMessage.infoMessage("密码不能为空", clickStr: "确定")
            return
        }
        
        if password.text != confirmationPassword.text {
            SRMessage.infoMessage("两次输入密码不相同", clickStr: "确定")
            return
        }
        
        apiRequstCheckUserNameDataAction(loginUserName.text!)
    }
    
    @IBAction func hiddenKeyboardAction(sender: UITapGestureRecognizer) {
        loginUserName.resignFirstResponder()
        password.resignFirstResponder()
        confirmationPassword.resignFirstResponder()
    }
    
//    @IBAction func registerBackUpPageAction(sender: UIBarButtonItem) {
//        
//        navigationController?.popViewControllerAnimated(true)
//    }
    
    //MARK: - Api request checkUserName handle action
    func apiRequstCheckUserNameDataAction(loginUserName:String) {
        self.showHUD()
        let params = ["action_type":"check_account_exist", "account":loginUserName]
        clientNetwork.requestDataMethParameters(params, success:
            { (data:AnyObject!, response:NSURLResponse!) in
                
                print(data)
                let result = data.objectForKey("result")?.boolValue
                dispatch_async(dispatch_get_main_queue(), {
                    self.hiddenHUD()
                    if result == false {
                        self.apiRequstRegisterDataAction(self.loginUserName.text!, password: self.password.text!)
                    }
                    else
                    {
                        SRMessage.infoMessage("该名字已被注册", clickStr: "确定")
                    }
                })
                
        }) { (error:NSError!) in
            dispatch_async(dispatch_get_main_queue(), {
                self.hiddenHUD()
            })
            print(error)
        }
    }
    
    //MARK: - Api request registerData handle action
    func apiRequstRegisterDataAction(loginUserName:String, password:String) {
        self.showHUD()
        let params = ["action_type":"mb_reg", "account":loginUserName, "pw":password]
        clientNetwork.requestDataMethParameters(params, success:
            { (data:AnyObject!, response:NSURLResponse!) in
                
                print(data)
                let result = data.objectForKey("result")?.boolValue
                dispatch_async(dispatch_get_main_queue(), {
                    self.hiddenHUD()
                    if result == true {
                        let user_id = data.objectForKey("user_id") as! String
                        let user_name = data.objectForKey("user_name") as! String
                        LoginInfoModel.saveLoginInfoAction(user_id, user_name: user_name, user: self.loginUserName.text!)
                        LoginInfoModel.saveUserAndPassword(loginUserName, password: password)
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        UIApplication.sharedApplication().keyWindow!.rootViewController = storyboard.instantiateInitialViewController()
                    }
                    else
                    {
                        SRMessage.infoMessage("注册失败", clickStr: "确定")
                    }
                })
                
        }) { (error:NSError!) in
            dispatch_async(dispatch_get_main_queue(), {
                self.hiddenHUD()
            })
            print(error)
        }
    }
}
