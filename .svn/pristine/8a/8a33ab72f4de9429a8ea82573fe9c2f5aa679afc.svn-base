//
//  TableBarController.swift
//  LianHuServices
//
//  Created by denglong on 4/11/16.
//  Copyright © 2016 邓龙. All rights reserved.
//

import UIKit

class TableBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTabBarBackgroundColor()
        setTabBarTitleColor()
        setTabbarImgColor()
    }

    func setTabBarBackgroundColor() {
        
        let bgColor = UIColor(hex: BGCOLOR)
        self.tabBar.barTintColor = bgColor
    }
    
    func setTabBarTitleColor() {
        
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSForegroundColorAttributeName: UIColor(hex: "8E8E8E")], forState:.Normal)
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSForegroundColorAttributeName: UIColor(hex: COMMONALITYCOLOR)], forState:.Selected)
    }
    
    func setTabbarImgColor() {

        self.tabBar.tintColor = UIColor(hex: COMMONALITYCOLOR)
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {

    }
}
