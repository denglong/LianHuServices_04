//
//  SummarizingViewController.swift
//  LianHuServices
//
//  Created by denglong on 16/5/5.
//  Copyright © 2016年 邓龙. All rights reserved.
//

import UIKit

class SummarizingViewController: BaseViewController, CustomAlertDelegete {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var startTime: UIButton!
    @IBOutlet weak var endTime: UIButton!
    var pickerView:KKDatePickerView!
    var clickStart:Bool!
    var startStr:String! = ""
    var endStr:String! = ""
    var starts:Array<String>! = []
    var ends:Array<String>! = []
    var startY:NSInteger!
    var startM:NSInteger!
    var startD:NSInteger!
    var endY:NSInteger!
    var endM:NSInteger!
    var endD:NSInteger!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bgView.layer.borderColor = UIColor(hex: "CCCCCC").CGColor
        bgView.layer.borderWidth = 0.5
        
        createPickerViewAction()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        hiddenPickerViewAction()
    }
    
    func createPickerViewAction() {
        pickerView = KKDatePickerView(frame: CGRectMake(0, VIEWHEIGHT, VIEWWIDTH, 200))
        pickerView.delegate = self
        UIApplication.sharedApplication().keyWindow?.addSubview(pickerView)
    }
    
    func hiddenPickerViewAction() {
        if pickerView != nil {
            UIView.animateWithDuration(0.5) {
                self.pickerView.frame = CGRectMake(0, VIEWHEIGHT, VIEWWIDTH, 200)
            }
        }
    }

    @IBAction func startTimeAction(sender: UIButton) {
        clickStart = true
        hiddenPickerViewAction()
        UIView.animateWithDuration(0.5) {
            self.pickerView.frame = CGRectMake(0, VIEWHEIGHT - 200, VIEWWIDTH, 200)
        }
    }

    @IBAction func endTimeAction(sender: UIButton) {
        clickStart = false
        hiddenPickerViewAction()
        UIView.animateWithDuration(0.5) {
            self.pickerView.frame = CGRectMake(0, VIEWHEIGHT - 200, VIEWWIDTH, 200)
        }
    }
    
    func btnindex(model: KKDatePickerViewModel!, show: Bool) {
        hiddenPickerViewAction()
        
        if show == true {
            if clickStart == true {
                startY = NSInteger(model.year)
                startM = NSInteger(model.moth)
                startD = NSInteger(model.day)
                starts = [model.year, model.moth, model.day]
                startStr = model.year + "-" + model.moth + "-" + model.day
                startTime.setTitle(model.year+"年"+model.moth+"月"+model.day+"日", forState: UIControlState.Normal)
            }
            else
            {
                endY = NSInteger(model.year)
                endM = NSInteger(model.moth)
                endD = NSInteger(model.day)
                ends = [model.year, model.moth, model.day]
                endStr = model.year + "-" + model.moth + "-" + model.day
                endTime.setTitle(model.year+"年"+model.moth+"月"+model.day+"日", forState: UIControlState.Normal)
            }
        }
    }

    @IBAction func summerAction(sender: UIButton) {
        hiddenPickerViewAction()
        
        if (starts.count == 0 || ends.count == 0) {
            return;
        }
        
        if endY >= startY && endM >= startM && endD >= startD {
            let userId = CommClass.sharedCommon().localObjectForKey(USER_ID) as? String
            let general = GeneralWebController(nibName: "GeneralWebController", bundle: nil)
            general.title = "办件汇总"
            general.urlStr = String(stringInterpolation: API_URL_SYSTEM,"?action_type=hz_count", "&user_id=", userId!, "&st=", startStr, "&et=", endStr)
            navigationController?.pushViewController(general, animated: true)
        }
    }
}
