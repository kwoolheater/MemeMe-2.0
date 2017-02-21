//
//  ShowMemeNavigationController.swift
//  MemeMe 2.0
//
//  Created by Kiyoshi Woolheater on 2/21/17.
//  Copyright © 2017 Kiyoshi Woolheater. All rights reserved.
//

import UIKit

class ShowMemeNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ShowMemeViewController.editButton))
    }
    
    
    
}
