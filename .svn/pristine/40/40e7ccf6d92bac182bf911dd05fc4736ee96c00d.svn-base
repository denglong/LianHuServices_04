//
//  PersonInfoController.swift
//  LianHuServices
//
//  Created by denglong on 16/4/17.
//  Copyright © 2016年 邓龙. All rights reserved.
//  个人信息

import UIKit

class PersonInfoController: BaseViewController, UITextFieldDelegate, UIScrollViewDelegate {

    @IBOutlet weak var persionInfoTableView: UITableView!
    var titleNames:Array<String>!
    let tableViewHeight:CGFloat = 600
    var textFileds:NSMutableArray = NSMutableArray()
    var userInfo:Dictionary<String, String>! = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableViewCellAction()
        
        let headerView = UIView(frame: CGRectMake(0, 0, VIEWWIDTH, 10))
        headerView.backgroundColor = view.backgroundColor
        persionInfoTableView.tableHeaderView = headerView
        self.edgesForExtendedLayout = UIRectEdge.None
        
        showHUD()
        apiRequstGetUserInfoAction()
        registerKeyboareNotifitation()
    }
    
    func registerKeyboareNotifitation() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PersonInfoController.keyboardWasHidden(_:)), name: UIKeyboardDidHideNotification, object: nil)
    }
    
    func keyboardWasHidden(notifation:NSNotification) {
        self.persionInfoTableView.contentOffset = CGPointMake(0, 0)
    }
    
    func registerTableViewCellAction() {
        persionInfoTableView.registerNib(UINib(nibName: "PersonInfoCell", bundle: nil), forCellReuseIdentifier: "PersonInfoCell")
        titleNames = ["*真实姓名:", "身份证号码:", "*手机号码:", "QQ号:", "微信号:", "固定电话:", "电子邮件:", "联系地址:"]
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 8 {
            return 60
        }
        else
        {
            return 50
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("PersonInfoCell") as! PersonInfoCell
        if indexPath.row == 8 {
            cell.saveButton.hidden = false
            cell.titleName.hidden = true
            cell.titleTextField.hidden = true
            cell.bgImage.hidden = true
            cell.saveButton.addTarget(self, action: #selector(PersonInfoController.saveUserinfoAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        }
        else
        {
            cell.saveButton.hidden = true
            cell.titleName.hidden = false
            cell.titleTextField.hidden = false
            cell.bgImage.hidden = false
            cell.titleTextField.delegate = self
            cell.titleTextField.tag = indexPath.row
            switch indexPath.row {
            case 0:
                cell.titleTextField.text = userInfo["nickname"]
                break
            case 1:
                cell.titleTextField.text = userInfo["idcard"]
                break
            case 2:
                cell.titleTextField.text = userInfo["phone"]
                break
            case 3:
                cell.titleTextField.text = userInfo["qq"]
                break
            case 4:
                cell.titleTextField.text = userInfo["weixin"]
                break
            case 5:
                cell.titleTextField.text = userInfo["tel"]
                break
            case 6:
                cell.titleTextField.text = userInfo["email"]
                break
            case 7:
                cell.titleTextField.text = userInfo["address"]
                break
            default:
                break
            }
            
            textFileds.addObject(cell.titleTextField)
            
            cell.titleName.text = titleNames[indexPath.row]
        }
        
        return cell
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.tag > 3 {
            self.persionInfoTableView.contentOffset = CGPointMake(0, 292)
        }
    }

    func textFieldDidEndEditing(textField: UITextField) {
        switch textField.tag {
        case 0:
            userInfo["nickname"] = textField.text
            print(textField.text)
           break
        case 1:
            userInfo["idcard"] = textField.text
            print(textField.text)
            break
        case 2:
            userInfo["phone"] = textField.text
            print(textField.text)
            break
        case 3:
            userInfo["qq"] = textField.text
            print(textField.text)
            break
        case 4:
            userInfo["weixin"] = textField.text
            print(textField.text)
            break
        case 5:
            userInfo["tel"] = textField.text
            print(textField.text)
            break
        case 6:
            userInfo["email"] = textField.text
            print(textField.text)
            break
        case 7:
            userInfo["address"] = textField.text
            print(textField.text)
            break
        default:
            break
        }
    }
    
    func saveUserinfoAction(sender:UIButton) {
        for textField in textFileds {
            let textF:UITextField = textField as! UITextField
            textF.resignFirstResponder()
        }
        if (userInfo["nickname"] == nil || userInfo["nickname"] == "" || userInfo["phone"] == nil || userInfo["phone"] == "") {
            SRMessage.infoMessage("真实姓名和手机号码不能为空！")
            return;
        }
        let userId = CommClass.sharedCommon().localObjectForKey(USER_ID)
        let params = ["action_type":"mb_info_edit", "user_id":userId, "nickname":userInfo["nickname"]!, "idcard":userInfo["idcard"]!, "phone":userInfo["phone"]!, "qq":userInfo["qq"]!, "weixin":userInfo["weixin"]!, "tel":userInfo["tel"]!, "email":userInfo["email"]!, "address":userInfo["address"]!]
        apiRequstEditUserInfoAction(params)
    }
    
    //MARK: - Api request get userInfo handle action
    func apiRequstGetUserInfoAction() {
        let userId = CommClass.sharedCommon().localObjectForKey(USER_ID)
        let params = ["action_type":"mb_info", "user_id":userId]
        clientNetwork.requestDataMethParameters(params, success:
            { (data:AnyObject!, response:NSURLResponse!) in
                
                self.userInfo = data as! Dictionary
                dispatch_async(dispatch_get_main_queue(), {
                    self.hiddenHUD()
                    self.persionInfoTableView.reloadData()
                })
                
        }) { (error:NSError!) in
            dispatch_async(dispatch_get_main_queue(), {
                self.hiddenHUD()
            })
            print(error)
        }
    }
    
    //MARK: - Api request edit userInfo handle action
    func apiRequstEditUserInfoAction(params:Dictionary<String, AnyObject>) {
        clientNetwork.requestDataMethParameters(params, success:
            { (data:AnyObject!, response:NSURLResponse!) in
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.hiddenHUD()
                    CommClass.sharedCommon().localObject(self.userInfo["nickname"]!, forKey: USER_NAME)
                    MYVIEWREFRESH = true
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
