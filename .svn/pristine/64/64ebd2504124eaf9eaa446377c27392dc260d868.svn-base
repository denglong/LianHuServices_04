//
//  GeneralWebController.swift
//  LianHuServices
//
//  Created by denglong on 16/4/23.
//  Copyright © 2016年 邓龙. All rights reserved.
//

import UIKit

class GeneralWebController: BaseViewController, UIWebViewDelegate, UIActionSheetDelegate {

    @IBOutlet weak var generalWeb: UIWebView!
    var shareView:ShareView!
    var shareUpView:UIView!
    var shareViewBg:UIView!
    var urlStr:String!
    var isShowShare:Bool = false
    var webTitle:String! = ""
    var webContent:String! = ""
    var isPush:Bool = false
    var isFirstLoad:Bool! = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createShareViewAction()
        let url = NSURL(string: urlStr)
        let request = NSURLRequest(URL: url!)
        generalWeb.loadRequest(request)
        
        if isShowShare == true {
            let btnItem = UIBarButtonItem(image: UIImage(named: "icon_share")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(GeneralWebController.shareWecatAction))
            navigationItem.rightBarButtonItem = btnItem
        }
        showHUD()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if urlStr.componentsSeparatedByString("&uid=").count > 1  && isFirstLoad == false && !LoginInfoModel.isLogined(){
            let userId = CommClass.sharedCommon().localObjectForKey(USER_ID) as? String
            urlStr = urlStr.stringByReplacingOccurrencesOfString("&uid=", withString: "&uid="+userId!, options: NSStringCompareOptions.LiteralSearch, range: nil)
            let url = NSURL(string: urlStr)
            let request = NSURLRequest(URL: url!)
            generalWeb.loadRequest(request)
        }
    }
    
    override func backUpPageAction() {
        if generalWeb.canGoBack {
            generalWeb.goBack()
        }
        else
        {
            navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func createShareViewAction() {
        let imgs = ["icon_weChat", "icon_friend", "icon_qq"]
        let titles = ["微信", "朋友圈", "QQ"]
        shareUpView = UIView(frame: CGRectMake(0, VIEWHEIGHT, VIEWWIDTH, 140))
        shareUpView.backgroundColor = UIColor.whiteColor()
        let titleLab = UILabel(frame: CGRectMake(10, 10, 100, 16))
        titleLab.textColor = UIColor.blackColor()
        titleLab.font = UIFont.systemFontOfSize(16)
        titleLab.text = "分享到"
        shareUpView.addSubview(titleLab)
        
        for i in 0..<3 {
            shareView = NSBundle.mainBundle().loadNibNamed("ShareView", owner: self, options: nil)!.last as! ShareView
            shareView.shareBtn.setBackgroundImage(UIImage(named: imgs[i]), forState: UIControlState.Normal)
            shareView.shareTitle.text = titles[i]
            shareView.frame = CGRectMake(CGFloat(i)*(VIEWWIDTH/3), 36, VIEWWIDTH/3, 104)
            shareUpView.addSubview(shareView)
            shareView.shareBtn.tag = i
            shareView.shareBtn.addTarget(self, action: #selector(GeneralWebController.shareAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        let line = UIView(frame: CGRectMake(0, 36, VIEWWIDTH, 0.5))
        line.backgroundColor = UIColor(hex: "CCCCCC")
        shareUpView.addSubview(line)
        
        shareViewBg = UIView(frame: UIScreen.mainScreen().bounds)
        shareViewBg.backgroundColor = UIColor(hex: "000000", alpha: 0.3)
        UIApplication.sharedApplication().keyWindow?.addSubview(shareViewBg)
        UIApplication.sharedApplication().keyWindow?.addSubview(shareUpView)
        shareViewBg.hidden = true
        shareUpView.hidden = true
        shareUpView.frame = CGRectMake(0, VIEWHEIGHT, VIEWWIDTH, 0)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(GeneralWebController.hiddenShareAction))
        shareViewBg.addGestureRecognizer(tap)
    }
    
    func hiddenShareAction() {
        UIView.animateWithDuration(0.5, animations: {
            self.shareUpView.frame = CGRectMake(0, VIEWHEIGHT, VIEWWIDTH, 0)
            
        }) { (success) in
            self.shareUpView.hidden = true
            self.shareViewBg.hidden = true
        }
    }

    func webViewDidStartLoad(webView: UIWebView) {
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        hiddenHUD()
        if isShowShare == true {
            webTitle = webView.stringByEvaluatingJavaScriptFromString("document.title")
            webContent = generalWeb.stringByEvaluatingJavaScriptFromString("getContext()");
            if isPush == true {
                title = webTitle
            }
        }
        else
        {
            if title != nil {
                webTitle = webView.stringByEvaluatingJavaScriptFromString("document.title")
                if isPush == true {
                    title = webTitle
                }
            }
        }
        if urlStr.componentsSeparatedByString("&uid=").count > 0 {
           isFirstLoad = false
        }
        
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        hiddenHUD()
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print(request.URL?.absoluteURL)
        let url = String(format: "%@", request.URL!)
        let strs = url.componentsSeparatedByString("&uid=")
        if strs.count > 1 {
            let str = strs[1]
            if isFirstLoad == false && str == "" && !(url.componentsSeparatedByString("ysbefore.jsp").count > 1) {
                if !LoginInfoModel.isLogined() {
                    let login = LoginController(nibName: "LoginController", bundle: nil)
                    let navigation = NavigationController(rootViewController: login)
                    presentViewController(navigation, animated: true, completion: nil)
                    return false
                }
            }
        }

        return true
    }
    
    func shareWecatAction() {
        UIView.animateWithDuration(0.5) { 
            self.shareViewBg.hidden = false
            self.shareUpView.hidden = false
            self.shareUpView.frame = CGRectMake(0, VIEWHEIGHT - 140, VIEWWIDTH, 140)
        }
    }
    
    func shareAction(sender: UIButton) {
        
        UIView.animateWithDuration(0.5, animations: {
            self.shareUpView.frame = CGRectMake(0, VIEWHEIGHT, VIEWWIDTH, 0)
            
        }) { (success) in
             self.shareUpView.hidden = true
            self.shareViewBg.hidden = true
        }
        
        switch sender.tag {
        case 0:
            ShareWeCat.shareAction(webTitle, description: webContent, linkUrl: urlStr, shareType: 0)
            break
        case 1:
            ShareWeCat.shareAction(webTitle, description: webContent, linkUrl: urlStr, shareType: 1)
            break
        case 2:
            ShareWeCat.shareQQAction(webTitle, content: webContent, linkUrl: urlStr)
            break
        default:
            break
        }
        
    }
    
}
