//
//  AppDelegate.swift
//  LianHuServices
//
//  Created by denglong on 4/8/16.
//  Copyright © 2016 邓龙. All rights reserved.
//

import UIKit
import UserNotifications

var ISREGISTER: Bool! = false

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, GeTuiSdkDelegate {
    
    var window: UIWindow?
    var isOut: Bool! = true
    var isopen: Bool! = false
    var notid:String! = nil
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window?.backgroundColor = UIColor(hex: BGCOLOR)
        if !NSUserDefaults.standardUserDefaults().boolForKey("FIRSTSTART") {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "FIRSTSTART")
            LoginInfoModel.clearUserInfo()
        }
        
        let rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()! as UIViewController
        self.window!.rootViewController = rootViewController
        
        ShareWeCat.initShareSDK()
        startGeTuiSDkRegister()
            
        if #available(iOS 10.0, *) {
            let center:UNUserNotificationCenter  = UNUserNotificationCenter.currentNotificationCenter()
            
            center.delegate = self;
            
            center.requestAuthorizationWithOptions([UNAuthorizationOptions.Badge, UNAuthorizationOptions.Sound, UNAuthorizationOptions.Alert] , completionHandler: { (granted, error: NSError? ) in
                
                if (error == nil) {
                    
                    UIApplication.sharedApplication().registerForRemoteNotifications()
                }
            })
            
        } else {
            
            registerUserNotification(application)
        }
        
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        
        // 此处只介绍当点击通知启动应用后如何获取通知
        if launchOptions != nil {
            if let localNotification = launchOptions!["UIApplicationLaunchOptionsLocalNotificationKey"] as? UILocalNotification {
                if let dict = localNotification.userInfo {
                    // 获取通知上绑定的信息后作相应处理...
                    if isopen == false {
                        not = dict
                    }
                }
            }
        }
        
        return true
    }
    
    // MARK: - 用户通知(推送) _自定义方法
    
    /** 注册用户通知(推送) */
    func registerUserNotification(application: UIApplication) {
        let result = UIDevice.currentDevice().systemVersion.compare("8.0.0", options: NSStringCompareOptions.NumericSearch)
        if (result != NSComparisonResult.OrderedAscending) {
            if #available(iOS 8.0, *) {
                UIApplication.sharedApplication().registerForRemoteNotifications()
                let userSettings = UIUserNotificationSettings(forTypes: [.Badge, .Sound, .Alert], categories: nil)
                UIApplication.sharedApplication().registerUserNotificationSettings(userSettings)
            } else {
                // Fallback on earlier versions
            }
        } else {
            UIApplication.sharedApplication().registerForRemoteNotificationTypes([.Alert, .Sound, .Badge])
        }
    }
    
    // MARK: - 远程通知(推送)回调
    
    @available(iOS 10.0, *)
    func userNotificationCenter(center: UNUserNotificationCenter, willPresentNotification notification: UNNotification, withCompletionHandler completionHandler: (UNNotificationPresentationOptions) -> Void) {
        
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(center: UNUserNotificationCenter, didReceiveNotificationResponse response: UNNotificationResponse, withCompletionHandler completionHandler: () -> Void) {
        
        let payload = response.notification.request.content.userInfo as NSDictionary
        let infoDic = dictionaryWithJsonString(payload["payload"] as! String)
        if ISREGISTER == false {
            not = infoDic
            isopen = true
        }
        else
        {
            jumpGeneralViewAction(infoDic)
        }
    }
    
    /** 个推注册方法 */
    func startGeTuiSDkRegister() {
        GeTuiSdk.startSdkWithAppId(kGtAppId, appKey: kGtAppKey, appSecret: kGtAppSecret, delegate: self);
        GeTuiSdk.runBackgroundEnable(true)
//        GeTuiSdk.bindAlias("555555")
    }
    
    /** 远程通知注册成功委托 */
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        var token = deviceToken.description.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "<>"));
        token = token.stringByReplacingOccurrencesOfString(" ", withString: "")
        
        // [3]:向个推服务器注册deviceToken
        GeTuiSdk.registerDeviceToken(token);
        CommClass.sharedCommon().setObject(token, forKey: "DEVICETOKEN")
        
        NSLog("\n>>>[DeviceToken Success]:%@\n\n",token);
    }
    
    /** 远程通知注册失败委托 */
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        NSLog("\n>>>[DeviceToken Error]:%@\n\n",error.description);
    }
    
    // MARK: - APP运行中接收到通知(推送)处理
    
    /** APP已经接收到“远程”通知(推送) - (App运行在后台/App运行在前台) */
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        application.applicationIconBadgeNumber = 0;        // 标签
        
        NSLog("\n>>>[Receive RemoteNotification]:%@\n\n",userInfo);
    }
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        application.applicationIconBadgeNumber = 0;        // 标签
        
        let payload = userInfo as NSDictionary
        let infoDic = dictionaryWithJsonString(payload["payload"] as! String)
        if ISREGISTER == false {
            not = infoDic
            isopen = true
        }
        else
        {
            jumpGeneralViewAction(infoDic)
        }
    }
    
    func toJSONString(dict:[NSObject : AnyObject])->NSString{
    
        let data = try! NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted)
        let strJson=NSString(data: data, encoding: NSUTF8StringEncoding)
        return strJson!
        
    }
    
    //MARK - 字符串转字典
    func dictionaryWithJsonString(jsonString:String) -> NSDictionary {
        let jsonData = jsonString.dataUsingEncoding(NSUTF8StringEncoding)
        let jsonDic = try! NSJSONSerialization.JSONObjectWithData(jsonData!,
                                                                  options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
        return jsonDic
    }
    
    func jumpGeneralViewAction(userInfo:NSDictionary) {
        let infoDic = userInfo as NSDictionary
        let note_dic = infoDic.objectForKey("payload") as! NSDictionary
        let note_id = note_dic.objectForKey("info_id") as? String
        let note_type = note_dic.objectForKey("info_type") as? String
        if note_id != "" && note_id != "nil" {
            let general = GeneralWebController(nibName: "GeneralWebController", bundle: nil)
            general.isShowShare = true
            general.isPush = true
            if note_type == "tzgg" {
                general.urlStr = String(stringInterpolation: API_URL,"?action_type=info_content","&id=",note_id!)
            }
            else
            {
                general.urlStr = String(stringInterpolation: API_URL,"?action_type=zwyw_content","&id=",note_id!)
            }
            ROOTVIEWCONTROLLER.navigationController?.pushViewController(general, animated: true)
        }
    }
    
    /** APP已经接收到“本地”通知(推送) - (App运行在后台/App运行在前台) */
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        application.applicationIconBadgeNumber = 0;
        isopen = false
        let jsonDic = notification.userInfo! as NSDictionary
        if isOut == true {
            jumpGeneralViewAction(jsonDic)
        }
        isOut = true
    }
    
    // MARK: - GeTuiSdkDelegate
    
    /** SDK启动成功返回cid */
    func GeTuiSdkDidRegisterClient(clientId: String!) {
        // [4-EXT-1]: 个推SDK已注册，返回clientId
        NSLog("\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
    }
    
    /** SDK遇到错误回调 */
    func GeTuiSdkDidOccurError(error: NSError!) {
        // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
        NSLog("\n>>>[GeTuiSdk error]:%@\n\n", error.localizedDescription);
    }
    
    /** SDK收到sendMessage消息回调 */
    func GeTuiSdkDidSendMessage(messageId: String!, result: Int32) {
        // [4-EXT]:发送上行消息结果反馈
        let msg:String = "sendmessage=\(messageId),result=\(result)";
        NSLog("\n>>>[GeTuiSdk DidSendMessage]:%@\n\n",msg);
    }
    
    func GeTuiSdkDidReceivePayloadData(payloadData: NSData!, andTaskId taskId: String!, andMsgId msgId: String!, andOffLine offLine: Bool, fromGtAppId appId: String!) {
        
        var payloadMsg = "";
        if((payloadData) != nil) {
            payloadMsg = String.init(data: payloadData, encoding: NSUTF8StringEncoding)!;
        }
        
        let msg:String = "Receive Payload: \(payloadMsg), taskId:\(taskId), messageId:\(msgId)";
        NSLog("\n>>>[GeTuiSdk DidReceivePayload]:%@\n\n",msg);

        let data = payloadMsg.dataUsingEncoding(NSUTF8StringEncoding)
        let jsonDic = try! NSJSONSerialization.JSONObjectWithData(data!,
                                                                  options: NSJSONReadingOptions.MutableContainers) as! NSDictionary

        if UIApplication.sharedApplication().applicationState == UIApplicationState.Active && offLine == false {
            addNotification(jsonDic)
            isOut = false
        }
    }
    
    /** 添加创建并添加本地通知 */
    func addNotification(dic:NSDictionary) {
        // 初始化一个通知
        let localNoti = UILocalNotification()
        
        // 通知的触发时间，例如即刻起0分钟后
        let fireDate = NSDate().dateByAddingTimeInterval(0)
        localNoti.fireDate = fireDate
        // 设置时区
        localNoti.timeZone = NSTimeZone.defaultTimeZone()
        // 通知上显示的主题内容
        let str = dic["title"] as! String
        localNoti.alertBody =  str
        
        // 收到通知时播放的声音，默认消息声音
        localNoti.soundName = UILocalNotificationDefaultSoundName
        //待机界面的滑动动作提示
//        localNoti.alertAction = "打开应用"
        // 应用程序图标右上角显示的消息数
        localNoti.applicationIconBadgeNumber = 0
        // 通知上绑定的其他信息，为键值对
        localNoti.userInfo = dic as Dictionary
        
        // 添加通知到系统队列中，系统会在指定的时间触发
        UIApplication.sharedApplication().scheduleLocalNotification(localNoti)
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        if OpenShare.handleOpenURL(url) {
            return true
        }
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

