//
//  HomeViewController.swift
//  LianHuServices
//
//  Created by denglong on 4/8/16.
//  Copyright © 2016 邓龙. All rights reserved.
//

import UIKit

var not:AnyObject?

class HomeViewController: BaseViewController, UIScrollViewDelegate, BottomSelectDelegate, HomeSelectDelegate, HeaderSelectDelegate, BedpanServiceDelegate, TitleSelectDelegate, CXCarouseViewDelegate, CXTitleDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var homeTableView: UITableView!
    var pageControlView: PageControlView!
    var pageControl: PageControl!
    var pageControlBedpan: PageControlView!
    var carousel:CXCarouselView!
    var tableHeaderView:UIView!
    var homeScroll:UIScrollView!
    var homeScrollView:UIScrollView!
    var adTitleLabel:UILabel!
    var adTitleBgView:UIView!
    var infoDic:NSDictionary!
    var infoList_zwyw:Array<Dictionary<String, String>>! = []
    var infoList_bmdt:Array<Dictionary<String, String>>! = []
    var infoList_jddt:Array<Dictionary<String, String>>! = []
    var informList:Array<Dictionary<String, String>>! = []
    var noteTableList:Array<UITableView>! = []
    var titleList:NSArray! = []
    var titleBtnList:NSArray! = []
    var titleNames:Array<String>!
    var bottonSelectTag:NSInteger = 0
    var imageNames:Array<String>! = []
    var adImageIDs:Array<String>! = []
    var adTitles:Array<String>! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNavigationTitle()
        registerTableViewCell()
        createPageControlAction()
        apiRequstHomeDataAction()
        apiRequstHomeAdListAction()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        createNavigationTitle()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        ISREGISTER = true
        ROOTVIEWCONTROLLER = self
        if (not != nil) {
            let dic = not as! NSDictionary
            jumpGeneralViewAction(dic)
            not = nil
        }
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
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        setNavigationTitle()
    }
    
    func createNavigationTitle() {
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.Default, animated: true)
        navigationController!.navigationBar.barTintColor = UIColor.whiteColor()
        
        let titleColor = UIColor(hex: "00558e")
        let navigationTitleAttribute: NSDictionary = NSDictionary(object: titleColor, forKey: NSForegroundColorAttributeName)
        navigationController!.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String : AnyObject]
        
        var image = UIImage(named: "icon_searchHome")
        image = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(HomeViewController.jumpToSearchViewAction))
    }
    
    func jumpToSearchViewAction() {
        let homeSearch = HomeSearchController(nibName: "HomeSearchController", bundle: nil)
        navigationController?.pushViewController(homeSearch, animated: true)
    }
    
    func createPageControlAction() {
        
        pageControlView = NSBundle.mainBundle().loadNibNamed("PageControlView", owner: self, options: nil)!.first as! PageControlView
        pageControlView.frame = PAGECONTFRAME
        createHeaderViewAction(false)
        
        pageControlBedpan = NSBundle.mainBundle().loadNibNamed("PageControlView", owner: self, options: nil)!.first as! PageControlView
        pageControlView.frame = PAGECONTFRAME
        createHeaderViewAction(false)
        
        pageControl = NSBundle.mainBundle().loadNibNamed("PageControl", owner: self, options: nil)!.first as! PageControl
        pageControl.frame = PAGECONTFRAME
        createHeaderViewAction(false)
        
        titleNames = ["要闻", "部门", "街道", "通知"]
        self.homeScrollView = self.createScrollTableView()
    }
    
    func registerTableViewCell() {
        
        homeTableView.registerNib(UINib(nibName: "HomeHeaderImgCell", bundle: nil), forCellReuseIdentifier: "HomeHeaderImgCell")
        homeTableView.registerNib(UINib(nibName: "HeaderSelectCell", bundle: nil), forCellReuseIdentifier: "HeaderSelectCell")
        homeTableView.registerNib(UINib(nibName: "HomeScrollCell", bundle: nil), forCellReuseIdentifier: "HomeScrollCell")
        homeTableView.registerNib(UINib(nibName: "TitleLabelCell", bundle: nil), forCellReuseIdentifier: "TitleLabelCell")
        homeTableView.registerNib(UINib(nibName: "MiddleSelectCell", bundle: nil), forCellReuseIdentifier: "MiddleSelectCell")
        homeTableView.registerNib(UINib(nibName: "BottomSelectCell", bundle: nil), forCellReuseIdentifier: "BottomSelectCell")
        homeTableView.registerNib(UINib(nibName: "BottomTitleCell", bundle: nil), forCellReuseIdentifier: "BottomTitleCell")
        homeTableView.registerNib(UINib(nibName: "BedpanServiceCell", bundle: nil), forCellReuseIdentifier: "BedpanServiceCell");
        //homeTableView.registerNib(UINib(nibName: "BedpanHeaderCell", bundle: nil), forCellReuseIdentifier: "BedpanHeaderCell");
        
        let footView = UIView(frame: CGRectMake(0, 0, VIEWWIDTH, 15))
        homeTableView.tableFooterView = footView
    }
    
    func createHeaderViewAction(isTrue:Bool) {
        
        if adTitleLabel != nil {
            adTitleLabel.removeFromSuperview()
        }
        
        if adTitleBgView != nil {
            adTitleBgView.removeFromSuperview()
        }
        
        adTitleBgView = UIView(frame: CGRectMake(0, VIEWWIDTH*(36/64) - 30, VIEWWIDTH, 30))
        adTitleBgView.backgroundColor = UIColor(hex: "000000", alpha: 0.5)
        
        adTitleLabel = UILabel(frame: CGRectMake(10, VIEWWIDTH*(36/64) - 30, VIEWWIDTH - 20, 30))
        adTitleLabel.textAlignment = NSTextAlignment.Left
        adTitleLabel.textColor = UIColor.whiteColor()
        adTitleLabel.font = UIFont.systemFontOfSize(14)
        
        if carousel != nil {
            carousel.removeFromSuperview()
        }

        carousel = CXCarouselView.initWithFrame(CGRectMake(0, 0, VIEWWIDTH, VIEWWIDTH*(36/64)), hasTimer: true, interval: 3, placeHolder: UIImage(named: "top_img"))
        carousel.delegate = self
        carousel.titleDelegate = self
        if isTrue == true
        {
            carousel.setupWithArray(imageNames)
            if adTitles.count > 0 {
                adTitleLabel.text = adTitles[0]
            }
        }
        tableHeaderView = carousel
    }
    
    func titleIndexPage(index: Int) {
        if adTitles.count >= index {
            adTitleLabel.text = adTitles[index]
        }
    }
    
    func createScrollTableView() -> UIScrollView {
        homeScroll = UIScrollView(frame: CGRectMake(0, 40, VIEWWIDTH, noteViewHeight - notiveViewHeight))
        homeScroll.tag = 1
        homeScroll.delegate = self
        homeScroll.pagingEnabled = true
        for i in 0..<4 {
            let noteTableView = UITableView(frame: CGRectMake(CGFloat(i)*VIEWWIDTH, 0, VIEWWIDTH, homeScroll.frame.size.height))
            noteTableView.separatorStyle = UITableViewCellSeparatorStyle.None
            noteTableView.bounces = false
            noteTableView.delegate = self
            noteTableView.dataSource = self
            noteTableView.tag = i + 1
            homeScroll.addSubview(noteTableView)
            noteTableView.registerNib(UINib(nibName: "NotiveCell", bundle: nil), forCellReuseIdentifier: "NotiveCell")
            noteTableList.append(noteTableView)
        }
        homeScroll.contentSize = CGSizeMake(VIEWWIDTH*4, 0)
        return homeScroll
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView.tag > 0 {
            return 1
        }
        return 6
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag > 0 {
            return 5
        }
        
        if section == 0 {
            if infoList_zwyw.count > 0 {
                return 2
            }
            else
            {
                return 1
            }
        }
        if section == 1
        {
            return 2
        }
        if section == 3
        {
            return 1
        }
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView.tag > 0 {
            return bottomSubHeight
        }
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                return VIEWWIDTH*(36/64)
            }
            else
            {
                return noteViewHeight
            }
        case 1:
            if indexPath.row == 0 {
                return notiveViewHeight
            }
            else
            {
                return headerCellHeight
            }
        case 2:
            return homeScrollHeight
        case 3:
            //if indexPath.row == 0 {
                return notiveViewHeight
            //}
            //else
            //{
            //    return homeScrollHeight
            //}
        case 4:
            return homeScrollHeight
        default:
            return bottomViewHeight
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView.tag > 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("NotiveCell") as! NotiveCell
            switch tableView.tag {
            case 1:
                cell.contentLab.text = infoList_zwyw[indexPath.row]["title"]
                break
            case 2:
                cell.contentLab.text = infoList_bmdt[indexPath.row]["title"]
                break
            case 3:
                cell.contentLab.text = infoList_jddt[indexPath.row]["title"]
                break
            default:
                cell.contentLab.text = informList[indexPath.row]["title"]
                break
            }
            
            return cell
        }
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("HomeHeaderImgCell") as! HomeHeaderImgCell
                cell.addSubview(tableHeaderView)
                if adTitles.count > 0 {
                    cell.addSubview(adTitleBgView)
                    cell.addSubview(adTitleLabel)
                }
                return cell
            }
            else
            {
                let cell = tableView.dequeueReusableCellWithIdentifier("BottomTitleCell") as! BottomTitleCell
                cell.createLastClickBtnAction()
                titleList = cell.bottomImgList
                titleBtnList = cell.clickBtnList
                cell.addSubview(homeScrollView)
                cell.delegate = self
                return cell
            }
        case 1:
            if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCellWithIdentifier("HeaderSelectCell") as! HeaderSelectCell
                cell.delegate = self
                cell.setPageControlAction(pageControl)
                cell.myScrollView.delegate = self
                return cell
            }
            let cell = tableView.dequeueReusableCellWithIdentifier("TitleLabelCell") as! TitleLabelCell
            cell.titlelabel.text = "政务大厅"
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("HomeScrollCell") as! HomeScrollCell
            cell.delegate = self
            cell.setPageControlAction(pageControlView)
            cell.myScrollView.delegate = self
            return cell
        case 3:
            //if indexPath.row == 1 {
            //    let cell = tableView.dequeueReusableCellWithIdentifier("BedpanHeaderCell") as! BedpanHeaderCell
            //    cell.delegate = self
            //    return cell
            //}
            let cell = tableView.dequeueReusableCellWithIdentifier("TitleLabelCell") as! TitleLabelCell
            cell.titlelabel.text = "便民服务中心"
            return cell
        case 4:
            let cell = tableView.dequeueReusableCellWithIdentifier("BedpanServiceCell") as! BedpanServiceCell
            cell.delegate = self
            cell.setPageControlAction(pageControlBedpan)
            cell.myScrollView.delegate = self
            return cell;
        case 5:
            let cell = tableView.dequeueReusableCellWithIdentifier("BottomSelectCell") as! BottomSelectCell
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 || section == 4 {
            return 0
        }
        return 10
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0, 0, VIEWWIDTH, 10))
        headerView.backgroundColor = UIColor(hex: BGCOLOR)
        return headerView
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.tag == 2 {
            pageControlView.pageControl.currentPage = Int(abs(scrollView.contentOffset.x)/VIEWWIDTH)
        }
        if scrollView.tag == 3 {
            pageControl.pageControl.currentPage = Int(abs(scrollView.contentOffset.x)/VIEWWIDTH)
        }
        if scrollView.tag == 4 {
            pageControlBedpan.pageControl.currentPage = Int(abs(scrollView.contentOffset.x)/VIEWWIDTH)
        }
        if scrollView.tag == 1 {
            for  i in 0..<titleList.count {
                let button = titleBtnList[i] as! UIButton
                button.setTitleColor(UIColor(hex: COMMONALITYGRAYCOLOR), forState: UIControlState.Normal)
                let imgView = titleList[i] as! UIImageView
                imgView.backgroundColor = UIColor.clearColor()
            }
            let imgView = titleList[Int(abs(scrollView.contentOffset.x)/VIEWWIDTH)] as! UIImageView
            imgView.backgroundColor = UIColor(hex: "ec9d00")
            let clickBtn = titleBtnList[Int(abs(scrollView.contentOffset.x)/VIEWWIDTH)] as! UIButton
            clickBtn.setTitleColor(UIColor(hex: COMMONALITYGRAYCOLOR), forState: UIControlState.Normal)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView.tag > 0 {
            var titleStr = "zwyw_content"
            var titleIndexTag:String!
            switch tableView.tag {
            case 1:
                titleIndexTag = infoList_zwyw[indexPath.row]["id"]
                break
            case 2:
                titleIndexTag = infoList_bmdt[indexPath.row]["id"]
                break
            case 3:
                titleIndexTag = infoList_jddt[indexPath.row]["id"]
                break
            default:
                titleStr = "info_content"
                titleIndexTag = informList[indexPath.row]["id"]
                break
            }
            let general = GeneralWebController(nibName: "GeneralWebController", bundle: nil)
            general.isShowShare = true
            general.isPush = true
            general.urlStr = String(stringInterpolation: API_URL,"?action_type=",titleStr,"&id=",titleIndexTag!)
            navigationController?.pushViewController(general, animated: true)
        }
    }
    
    func carouselTouch(carousel: CXCarouselView!, atIndex index: UInt) {
        print(index)
        if adImageIDs.count > 0 {
            let titleIndexTag = adImageIDs[NSInteger(index)]
            let general = GeneralWebController(nibName: "GeneralWebController", bundle: nil)
            general.isPush = true
            general.isShowShare = true
            general.urlStr = String(stringInterpolation: API_URL,"?action_type=zwyw_content","&id=",titleIndexTag)
            navigationController?.pushViewController(general, animated: true)
        }
    }
    
    //MARK: - Clicked headerbutton handle action
    func clickHeaderSelectAction(tag:NSInteger) {
        switch pageControl.pageControl.currentPage {
        case 0:
            print(tag)
            let index = tag
            switch index {
            case 0:
                performSegueWithIdentifier("fingerpost", sender: self)
                break
            case 1:
                let general = GeneralWebController(nibName: "GeneralWebController", bundle: nil)
                general.title = "咨询"
                general.isShowShare = false
                general.urlStr = "https://zw.lianhu.gov.cn/hdlbwap/index.htm"
                navigationController?.pushViewController(general, animated: true)
                break
            case 2:
                HOMESUBTITLE = "预审"
                performSegueWithIdentifier("homeSub", sender: self)
                break
            case 3:
                performSegueWithIdentifier("manageSearch", sender: self)
                break
            default:
                break
            }
            break
        default:
            print(tag + 4)
            let index = tag + 4
            switch index {
            case 4:
                let general = GeneralWebController(nibName: "GeneralWebController", bundle: nil)
                general.title = "交通路线"
                general.isShowShare = false
                general.urlStr = "https://zw.lianhu.gov.cn/jtlxwap/index.htm"
                navigationController?.pushViewController(general, animated: true)
                break
            case 5:
                let general = GeneralWebController(nibName: "GeneralWebController", bundle: nil)
                general.title = "楼层分布"
                general.isShowShare = false
                general.urlStr = "https://zw.lianhu.gov.cn/lcfbwap/index.htm"
                navigationController?.pushViewController(general, animated: true)
                break
            case 6:
                performSegueWithIdentifier("handbroom", sender: self)
                break
            case 7:
                let general = GeneralWebController(nibName: "GeneralWebController", bundle: nil)
                general.title = "云服务"
                general.isShowShare = false
                general.urlStr = infoDic.objectForKey("yunfuwu_url") as! String
                navigationController?.pushViewController(general, animated: true)
                break
            default:
                break
            }
            break
        }
    }
    
    //MARK: - Clicked I have handle action
    func clickHomeSelectAction(tag:NSInteger) {
        switch pageControlView.pageControl.currentPage {
        case 1:
            let index = tag + 4
            print(index)
            switch index {
            case 4:
                MYHAVETITLE = "办老年证"
                HOME_NOTE_ID = "39"
                performSegueWithIdentifier("myHave", sender: self)
                break
            case 5:
                MYHAVETITLE = "保障房"
                HOME_NOTE_ID = "44"
                performSegueWithIdentifier("myHave", sender: self)
                break
            case 6:
                MYHAVETITLE = "办公证"
                HOME_NOTE_ID = "45"
                performSegueWithIdentifier("myHave", sender: self)
                break
            case 7:
                MYHAVETITLE = "文化许可"
                HOME_NOTE_ID = "46"
                performSegueWithIdentifier("myHave", sender: self)
                break
            default:
                break
            }
        case 2:
            let index = tag + 8
            print(index)
            switch index {
            case 8:
                MYHAVETITLE = "卫生许可"
                HOME_NOTE_ID = "47"
                performSegueWithIdentifier("myHave", sender: self)
                break
            case 9:
                MYHAVETITLE = "餐饮许可"
                HOME_NOTE_ID = "42"
                performSegueWithIdentifier("myHave", sender: self)
                break
            case 10:
                MYHAVETITLE = "电梯登记"
                HOME_NOTE_ID = "64"
                performSegueWithIdentifier("myHave", sender: self)
                break
            case 11:
                MYHAVETITLE = "更多"
                performSegueWithIdentifier("fingerpost", sender: self)
                break
            default:
                break
            }
        default:
            let index = tag
            print(index)
            switch index {
            case 0:
                MYHAVETITLE = "环保绿标"
                HOME_NOTE_ID = "62"
                performSegueWithIdentifier("myHave", sender: self)
                break
            case 1:
                MYHAVETITLE = "婚姻登记"
                HOME_NOTE_ID = "36"
                performSegueWithIdentifier("myHave", sender: self)
                break
            case 2:
                MYHAVETITLE = "企业登记"
                HOME_NOTE_ID = "37"
                performSegueWithIdentifier("myHave", sender: self)
                break
            case 3:
                MYHAVETITLE = "补医保卡"
                HOME_NOTE_ID = "38"
                performSegueWithIdentifier("myHave", sender: self)
                break
            default:
                break
            }
        }
    }
    
    //MARK: - 便民服务
    /**func clickBedpanHeaderAction(tag: NSInteger) {
        let bedpanNames = ["健康顾问", "心理咨询", "挂失登报", "刻公章"]
        let urlStrs = ["http://dx.zoosnet.net/lrserver/lr/chatpre.aspx?id=lzs42223511&cid=143937416924572228851&lng=cn&sid=143937416924572228851&p=http%3a//cs.xadxyy.cn/&rf1=&rf2=&bid=&d=1439347032547&r=&rf1=https%3A//www.baidu&rf2=.com/link%3Furl%3DDdKlMREG5z7UPGr7jKOZRG9KR3hbCErClPSB294ScH3%26wd%3D%26eqid%3D97411e3f0000386d0000000257ea0563", "http://www.lhkfb.gov.cn/info/iList.jsp?cat_id=10498&tm_id=289", "http://www.lhkfb.gov.cn/kzhdb/db.html", "http://www.lhkfb.gov.cn/kzhdb/kgz.html"]
        
        let general = GeneralWebController(nibName: "GeneralWebController", bundle: nil)
        general.title = bedpanNames[tag]
        general.urlStr = urlStrs[tag]
        general.isShowShare = false
        general.isPush = true
        navigationController?.pushViewController(general, animated: true)
    }*/
    
    func clickBedpanServiceAction(tag: NSInteger) {
        let nameLists = ["青年路", "北院门", "环城西路", "西关", "土门", "红庙坡", "桃园路", "枣园", "北关"]
        let urlStrs = ["https://zw.lianhu.gov.cn/wap/qnl.htm", "https://zw.lianhu.gov.cn/bym/", "https://zw.lianhu.gov.cn/huanxi/", "https://zw.lianhu.gov.cn/xiguan/", "https://zw.lianhu.gov.cn/tumen/", "https://zw.lianhu.gov.cn/hmp/", "https://zw.lianhu.gov.cn/tyl/", "https://zw.lianhu.gov.cn/zaoyuan/", "https://zw.lianhu.gov.cn/beiguan/"]
        var index:NSInteger!
        
        switch pageControlBedpan.pageControl.currentPage {
        case 0:
            index = tag
        case 1:
            index = tag + 4
        case 2:
            index = tag + 8
        default:
            break
        }
        print(index)
        
        let general = GeneralWebController(nibName: "GeneralWebController", bundle: nil)
        general.title = nameLists[index]
        general.urlStr = urlStrs[index]
        general.isShowShare = false
        general.isPush = true
        navigationController?.pushViewController(general, animated: true)
    }

    //MARK: - Clicked one office three center handle action
    func clickBottomButtonTag(tag:NSInteger) {
        
        if (tag == 0) {
            SRMessage.infoMessage("暂未开通", delegate: self)
            return
        }
        
        let oneOfficeCenters = ["公共法律服务中心", "中小企业服务中心", "融资服务中心", "出入境接待大厅"]
        let urlStrs = ["http://www.lianhu.gov.cn/info/iList.jsp?tm_id=499", "https://zw.lianhu.gov.cn/qyfwwap/index.htm", "https://zw.lianhu.gov.cn/rzwap/index.htm", "https://zw.lianhu.gov.cn/jddtwap/index.htm"]
        
        let general = GeneralWebController(nibName: "GeneralWebController", bundle: nil)
        general.title = oneOfficeCenters[tag]
        general.urlStr = urlStrs[tag]
        general.isShowShare = false
        general.isPush = true
        navigationController?.pushViewController(general, animated: true)
    }
    
    //MARK: - Clicked titleButton handle action
    func clickTitleSelectAction(sender: UIButton, titleBtnList: NSArray, bottomImgList: NSArray) {
        for  i in 0..<titleBtnList.count {
            let button = titleBtnList[i] as! UIButton
            button.setTitleColor(UIColor(hex: COMMONALITYGRAYCOLOR), forState: UIControlState.Normal)
            let imgView = bottomImgList[i] as! UIImageView
            imgView.backgroundColor = UIColor.clearColor()
        }
        let imgView = bottomImgList[sender.tag] as! UIImageView
        imgView.backgroundColor = UIColor(hex: "ec9d00")
        sender.setTitleColor(UIColor(hex: COMMONALITYGRAYCOLOR), forState: UIControlState.Normal)
        
        homeScroll.contentOffset = CGPointMake(CGFloat(sender.tag)*VIEWWIDTH, 0)

        let title = ["要闻", "部门", "街道", "通知"]
        let requestTags = ["10002", "10003", "10004",""]
        BULLETINLISTTITLENAME = title[sender.tag]
        BULLETINREQUESTTAG = requestTags[sender.tag]
        performSegueWithIdentifier("bulletinList", sender: self)
    }
    
    //MARK: - Api request homePage handle action
    func apiRequstHomeDataAction() {
        self.showHUD()
        let params = ["action_type":"zwyw_index"]
        clientNetwork.requestDataMethParameters(params, success:
            { (data:AnyObject!, response:NSURLResponse!) in
                
                print(data)
                dispatch_async(dispatch_get_main_queue(), {
                    self.infoDic = data as! NSDictionary
                    self.infoList_zwyw = self.infoDic.objectForKey("zwyw") as! Array
                    self.infoList_bmdt = self.infoDic.objectForKey("bmdt") as! Array
                    self.infoList_jddt = self.infoDic.objectForKey("jddt") as! Array
                    self.informList = self.infoDic.objectForKey("tzgg") as! Array
                    self.hiddenHUD()
                    for table in self.noteTableList {
                        table.reloadData()
                    }
                    self.homeTableView.reloadData()
                })
                
        }) { (error:NSError!) in
            dispatch_async(dispatch_get_main_queue(), {
                self.hiddenHUD()
            })
            print(error)
        }
    }
    
    //MARK: - Api request home AD handle action
    func apiRequstHomeAdListAction() {
        let params = ["action_type":"zwyw_top_img"]
        clientNetwork.requestDataMethParameters(params, success:
            { (data:AnyObject!, response:NSURLResponse!) in
                
                print(data)
                dispatch_async(dispatch_get_main_queue(), {
                    let imgs = data as! NSArray
                    for imgDic in imgs {
                        let dic = imgDic as! NSDictionary
                        self.imageNames.append(dic.objectForKey("img") as! String)
                        self.adImageIDs.append(dic.objectForKey("id") as! String)
                        self.adTitles.append(dic.objectForKey("title") as! String)
                    }
                    
                    self.createHeaderViewAction(true)
                    self.homeTableView.reloadData()
                })
                
        }) { (error:NSError!) in
            print(error)
        }
    }
}
