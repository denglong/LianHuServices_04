//
//  NoteDetailController.swift
//  LianHuServices
//
//  Created by denglong on 16/5/15.
//  Copyright © 2016年 邓龙. All rights reserved.
//

import UIKit

var TITLETEXT:String!
var CONTENTTEXT:String!
var SENDDATA:String!

class NoteDetailController: BaseViewController {
    @IBOutlet weak var sendData: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = TITLETEXT
        contentLabel.text = CONTENTTEXT
        sendData.text = SENDDATA
    }
}
