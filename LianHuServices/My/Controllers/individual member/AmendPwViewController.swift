//
//  AmendPwViewController.swift
//  LianHuServices
//
//  Created by denglong on 16/4/17.
//  Copyright © 2016年 邓龙. All rights reserved.
//  修改密码

import UIKit

class AmendPwViewController: BaseViewController {

    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func savePasswrodAction(sender: UIButton) {
        if newPassword.text?.length == 0 {
            SRMessage.infoMessage("密码不能为空", clickStr: "确定")
        }
        else if newPassword.text != confirmPassword.text
        {
            SRMessage.infoMessage("两次密码输入不相同", clickStr: "确定")
        }
        else
        {
           apiRequstAmendDataAction(newPassword.text!)
        }
    }

    //MARK: - Api request search handle action
    func apiRequstAmendDataAction(newPW:String) {
        showHUD()
        let userId = CommClass.sharedCommon().localObjectForKey(USER_ID)
        if LoginInfoModel.isSystemUser() {
            let params = ["action_type":"edit_pw", "user_id":userId, "pw":newPW]
            clientNetwork.requestDataMethodSystemParameters(params, success:
                { (data:AnyObject!, response:NSURLResponse!) in
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.hiddenHUD()
                        self.navigationController?.popViewControllerAnimated(true)
                    })
                    
            }) { (error:NSError!) in
                dispatch_async(dispatch_get_main_queue(), {
                    self.hiddenHUD()
                })
                print(error)
            }
        }
        else
        {
            let params = ["action_type":"mb_pw", "user_id":userId, "pw":newPW]
            clientNetwork.requestDataMethParameters(params, success:
                { (data:AnyObject!, response:NSURLResponse!) in
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.hiddenHUD()
                        self.navigationController?.popViewControllerAnimated(true)
                    })
                    
            }) { (error:NSError!) in
                dispatch_async(dispatch_get_main_queue(), {
                    self.hiddenHUD()
                })
                print(error)
            }
        }
    }

}
