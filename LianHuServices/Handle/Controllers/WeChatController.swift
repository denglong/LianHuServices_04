//
//  WeChatController.swift
//  LianHuServices
//
//  Created by denglong on 5/29/16.
//  Copyright © 2016 邓龙. All rights reserved.
//

import UIKit

class WeChatController: BaseViewController, UIWebViewDelegate {

    @IBOutlet weak var weChatWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "https://zw.lianhu.gov.cn/gfwxwap/index.htm")
        let request = NSURLRequest(URL: url!)
        weChatWebView.loadRequest(request)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        ROOTVIEWCONTROLLER = self
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        showHUD()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        hiddenHUD()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        hiddenHUD()
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
