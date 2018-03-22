//
//  LoginInfoModel.swift
//  LianHuServices
//
//  Created by denglong on 16/4/21.
//  Copyright © 2016年 邓龙. All rights reserved.
//

import UIKit

class LoginInfoModel: NSObject {
    
    class func saveUserAndPassword(loginUser:String, password:String) {
        CommClass.sharedCommon().localObject(loginUser, forKey: LOGINUSERNAME)
        CommClass.sharedCommon().localObject(password, forKey: LOGINPASSWORD)
    }
    
    class func saveLoginInfoAction(user_id:String, user_name:String, user:String) {
        CommClass.sharedCommon().localObject(user, forKey: USER)
        CommClass.sharedCommon().localObject(user_id, forKey: USER_ID)
        CommClass.sharedCommon().localObject(user_name, forKey: USER_NAME)
    }
    
    class func isLogined() ->Bool {
        let loginUserName = String(CommClass.sharedCommon().localObjectForKey(LOGINUSERNAME))
        let loginPassword = String(CommClass.sharedCommon().localObjectForKey(LOGINPASSWORD))
        if loginUserName.length > 0 && loginUserName != "nil" && loginPassword.length > 0 && loginPassword != "nil" {
            return true
        }
        else
        {
            return false
        }
    }
    
    class func isSystemUser() ->Bool {
        let loginUserName = String(CommClass.sharedCommon().localObjectForKey(LOGINUSERNAME))
        if loginUserName.length <= 5 && loginUserName.length > 0 && loginUserName != "nil" {
            return true
        }
        else
        {
            return false
        }
    }
    
    class func clearUserInfo() {
        CommClass.sharedCommon().localObject("", forKey: LOGINUSERNAME)
        CommClass.sharedCommon().localObject("", forKey: LOGINPASSWORD)
        CommClass.sharedCommon().localObject("", forKey: USER_ID)
        CommClass.sharedCommon().localObject("", forKey: USER_NAME)
    }
}
