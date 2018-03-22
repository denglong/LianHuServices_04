//
//  NavigationController.swift
//  LianHuServices
//
//  Created by denglong on 4/11/16.
//  Copyright © 2016 邓龙. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBarBackgroundColor()
        setNavigationBarTitleAttribute()
    }

    func setNavigationBarBackgroundColor() {
        let bgColor = UIColor(hex: COMMONALITYCOLOR)
        self.navigationBar.barTintColor = bgColor
        self.navigationBar.translucent = false
    }
    
    func setNavigationBarTitleAttribute() {
        
        let titleColor = UIColor(hex: "FFFFFF")
        let navigationTitleAttribute: NSDictionary = NSDictionary(object: titleColor, forKey: NSForegroundColorAttributeName)
        self.navigationBar.titleTextAttributes = navigationTitleAttribute as? [String : AnyObject]
    }
}
