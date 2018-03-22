//
//  MyFingerpostController.swift
//  LianHuServices
//
//  Created by denglong on 16/4/17.
//  Copyright © 2016年 邓龙. All rights reserved.
//  办事指南

import UIKit

class MyFingerpostController: BaseViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var myFingerTableView: UITableView!
    @IBOutlet weak var departmentBtn: UIButton!
    @IBOutlet weak var searchTextfield: UITextField!
    var divisionList:Array<Dictionary<String, String>>! = []
    var searchList:Array<Dictionary<String, String>>! = []
    var pickerView:UIView!
    var selectDivision:String! = "全部部门"
    var node_id:String! = ""
    var keyword:String! = ""
    var isFirstIn:Bool = true
    var indexPage:NSInteger = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        departmentBtn.layer.borderWidth = 0.5
        departmentBtn.layer.borderColor = UIColor(hex: "CCCCCC").CGColor
        registerTableCellAction()
        createDownArrow()
        apiRequstDivisionListDataAction()
        createRefreshAction(myFingerTableView)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        hiddenPickerViewAction()
    }
    
    func createDownArrow() {
        let downArrow = UIImageView(frame: CGRectMake(VIEWWIDTH - 55, 0, 15, 15))
        downArrow.image = CommClass.image(UIImage(named: "look_icon"), rotation: UIImageOrientation.Right)
        downArrow.center = CGPoint(x: downArrow.center.x, y: departmentBtn.frame.size.height/2)
        departmentBtn.addSubview(downArrow)
    }

    func registerTableCellAction() {
        myFingerTableView.registerNib(UINib(nibName: "MyFingerViewCell", bundle: nil), forCellReuseIdentifier: "MyFingerViewCell")
    }
    
    func createPickerViewAction() {
        pickerView = UIView(frame: CGRectMake(0, VIEWHEIGHT, VIEWWIDTH, VIEWHEIGHT/4))
        pickerView.backgroundColor = view.backgroundColor
        let bgView = UIView(frame: CGRectMake(0, 30, VIEWWIDTH, VIEWHEIGHT/4 - 30))
        bgView.backgroundColor = UIColor.grayColor()
        bgView.alpha = 0.5
        pickerView.addSubview(bgView)
        
        let picker = UIPickerView(frame: CGRectMake(0, 20, VIEWWIDTH, VIEWHEIGHT/4))
        picker.dataSource = self
        picker.delegate = self
        pickerView.addSubview(picker)
        
        let confirmBtn = UIButton(frame: CGRectMake(VIEWWIDTH - 50, 0, 40, 30))
        confirmBtn.setTitle("确定", forState: UIControlState.Normal)
        confirmBtn.setTitleColor(UIColor(hex: "167AF8"), forState: UIControlState.Normal)
        confirmBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        confirmBtn.addTarget(self, action: #selector(MyFingerpostController.clickConfirmAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        pickerView.addSubview(confirmBtn)
        let window = UIApplication.sharedApplication().keyWindow
        window?.addSubview(pickerView)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return divisionList.count + 1
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return "全部部门"
        }
        return divisionList[row - 1]["title"]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            node_id = ""
            selectDivision = "全部部门"
        }
        else
        {
            node_id = divisionList[row - 1]["id"]
            selectDivision = divisionList[row - 1]["title"]
        }
        print(node_id)
    }
    
    //MARK: - Click confirm handle action
    func clickConfirmAction(sender:UIButton) {
        hiddenPickerViewAction()
        departmentBtn.setTitle(selectDivision, forState: UIControlState.Normal)
    }
    
    func hiddenPickerViewAction() {
        if pickerView != nil {
            UIView.animateWithDuration(0.5) {
                self.pickerView.frame = CGRectMake(0, VIEWHEIGHT, VIEWWIDTH, VIEWHEIGHT/4)
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 43
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyFingerViewCell") as! MyFingerViewCell
        if searchList.count > 0 {
            cell.setTitleButtonTextName(searchList[indexPath.row]["item_class_name"]!)
            cell.contentLab.text = searchList[indexPath.row]["title"]
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let ID = searchList[indexPath.row]["id"]
        let userId = CommClass.sharedCommon().localObjectForKey(USER_ID) as? String
        let general = GeneralWebController(nibName: "GeneralWebController", bundle: nil)
        general.title = "办事指南"
        general.isShowShare = true
        general.urlStr = String(stringInterpolation: API_URL,"?action_type=bszn_info","&id=",ID!, "&uid=", userId!)
        navigationController?.pushViewController(general, animated: true)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if pickerView != nil {
            UIView.animateWithDuration(0.5) {
                self.pickerView.frame = CGRectMake(0, VIEWHEIGHT, VIEWWIDTH, VIEWHEIGHT/4)
            }
        }
        searchTextfield.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        hiddenPickerViewAction()
    }
    
    @IBAction func clickChooseDivisionAction(sender: UIButton) {
        UIView.animateWithDuration(0.5) { 
            self.pickerView.frame = CGRectMake(0, VIEWHEIGHT - VIEWHEIGHT/4, VIEWWIDTH, VIEWHEIGHT/4)
        }
        searchTextfield.resignFirstResponder()
    }
    
    @IBAction func clickSearchBtnAction(sender: UIButton) {
        isFirstIn = false
        hiddenPickerViewAction()
        searchTextfield.resignFirstResponder()
        keyword = searchTextfield.text
        searchList = []
        headerRefreshing()
    }
    
    //MARK: - Api request divisionList handle action
    func apiRequstDivisionListDataAction() {
        let params = ["action_type":"bszn_dept", "node_id":"2"]
        clientNetwork.requestDataMethParameters(params, success:
            { (data:AnyObject!, response:NSURLResponse!) in
                
                self.divisionList = data as! Array
                dispatch_async(dispatch_get_main_queue(), {
                    self.createPickerViewAction()
                })
        }) { (error:NSError!) in
            print(error)
        }
    }
    
    override func headerRefreshing() {
        if isFirstIn == true {
            self.refreshHeaderView.endRefreshing()
        }
        else
        {
            indexPage = 1
            searchList = []
           apiRequstSearchListDataAction(node_id, keyword: keyword)
        }
        
    }
    
    override func footerRefreshing() {
        indexPage += 1
        apiRequstSearchListDataAction(node_id, keyword: keyword)
    }
    
    //MARK: - Api request search handle action
    func apiRequstSearchListDataAction(node_id:String, keyword:String) {
        showHUD()
        let params = ["action_type":"bszn_list", "node_id":node_id, "kw":keyword, "cp":String(indexPage)]
        clientNetwork.requestDataMethParameters(params, success:
            { (data:AnyObject!, response:NSURLResponse!) in
                
                dispatch_async(dispatch_get_main_queue(), {
                    let dataList:Array<Dictionary<String, String>> = data as! Array
                    if dataList.count == 0 {
                        if self.indexPage > 1 {
                            self.indexPage -= 1
                        }
                    }
                    for dic:Dictionary<String, String> in dataList {
                        self.searchList.append(dic)
                    }
                    
                    self.hiddenHUD()
                    self.refreshHeaderView.endRefreshing()
                    self.refreshFooterView.endRefreshing()
                    self.myFingerTableView.reloadData()
                })
                
        }) { (error:NSError!) in
            if self.indexPage > 1 {
                self.indexPage -= 1
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.hiddenHUD()
                self.refreshHeaderView.endRefreshing()
                self.refreshFooterView.endRefreshing()
                self.myFingerTableView.reloadData()
            })
            print(error)
        }
    }
}
