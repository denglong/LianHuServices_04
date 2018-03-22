//
//  SettingViewController.swift
//  LianHuServices
//
//  Created by denglong on 16/5/5.
//  Copyright © 2016年 邓龙. All rights reserved.
//

import UIKit

class SettingViewController: BaseViewController {
    @IBOutlet weak var handleSwitch: UISwitch!
    @IBOutlet weak var summarSwitch: UISwitch!
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var vibrateSwitch: UISwitch!
    var is_tj:String! = "0"
    var is_bj:String! = "0"

    override func viewDidLoad() {
        super.viewDidLoad()

        let soundOn = CommClass.sharedCommon().objectForKey("soundOn")
        if soundOn != nil {
            if soundOn.boolValue == false {
                soundSwitch.setOn(soundOn.boolValue, animated: true)
            }
            let vibrateOn = CommClass.sharedCommon().objectForKey("vibrateOn").boolValue
            if vibrateOn == false {
                vibrateSwitch.setOn(vibrateOn, animated: true)
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let isbj = CommClass.sharedCommon().localObjectForKey("is_bj").integerValue
        if isbj == 0 {
            handleSwitch.setOn(true, animated: true)
        }
        else
        {
            handleSwitch.setOn(false, animated: true)
        }
        
        let istj = CommClass.sharedCommon().localObjectForKey("is_tj").integerValue
        if istj == 0 {
            summarSwitch.setOn(true, animated: true)
        }
        else
        {
            summarSwitch.setOn(false, animated: true)
        }
        
        let soundOn = CommClass.sharedCommon().localObjectForKey("soundOn")
        if soundOn != nil  {
            let soundOn = CommClass.sharedCommon().localObjectForKey("soundOn").integerValue
            if soundOn == 0 {
                soundSwitch.setOn(true, animated: true)
            }
            else
            {
                soundSwitch.setOn(false, animated: true)
            }
        }
        
        let vibrateOn = CommClass.sharedCommon().localObjectForKey("vibrateOn")
        if vibrateOn != nil {
            let vibrateOn = CommClass.sharedCommon().localObjectForKey("vibrateOn").integerValue
            if vibrateOn == 0 {
                vibrateSwitch.setOn(true, animated: true)
            }
            else
            {
                vibrateSwitch.setOn(false, animated: true)
            }
        }
    }

    @IBAction func handleSwitchAction(sender: UISwitch) {
        if sender.on == true {
            CommClass.sharedCommon().localObject("0", forKey: "is_bj")
            is_bj = "0"
        }
        else
        {
            CommClass.sharedCommon().localObject("1", forKey: "is_bj")
            is_bj = "1"
        }
        
        apiRequstNoteListDataAction()
    }

    @IBAction func summarSwitchAction(sender: UISwitch) {
        if sender.on == true {
            CommClass.sharedCommon().localObject("0", forKey: "is_tj")
            is_tj = "0"
        }
        else
        {
            CommClass.sharedCommon().localObject("1", forKey: "is_tj")
            is_tj = "1"
        }
        apiRequstNoteListDataAction()
    }
    
    @IBAction func soundSwitchAction(sender: UISwitch) {
        let sound = LxxPlaySound.init(forPlayingSound: ())
        if sender.on == true {
            sound.play()
            CommClass.sharedCommon().localObject("0", forKey: "soundOn")
        }
        else
        {
            sound.closed()
            CommClass.sharedCommon().localObject("1", forKey: "soundOn")
        }
    }
    
    @IBAction func vibrateSwitchAction(sender: UISwitch) {
        let vibrate = LxxPlaySound.init(forPlayingVibrate: ())
        if sender.on == true {
            vibrate.play()
            CommClass.sharedCommon().localObject("0", forKey: "vibrateOn")
        }
        else
        {
            vibrate.closed()
            CommClass.sharedCommon().localObject("1", forKey: "vibrateOn")
        }
    }
    
    //MARK: - Api request homePage handle action
    func apiRequstNoteListDataAction() {
        self.showHUD()
        let userId = CommClass.sharedCommon().localObjectForKey(USER_ID)
        let params = ["action_type":"set_receive_type", "user_id":userId, "is_tj":is_tj, "is_bj":is_bj]
        clientNetwork.requestDataMethodSystemParameters(params, success:
            { (data:AnyObject!, response:NSURLResponse!) in
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.hiddenHUD()
                })
                
        }) { (error:NSError!) in
            dispatch_async(dispatch_get_main_queue(), {
                self.hiddenHUD()
            })
            print(error)
        }
    }
    
}
