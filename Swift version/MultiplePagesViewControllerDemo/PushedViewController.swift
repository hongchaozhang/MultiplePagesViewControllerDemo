//
//  PushedViewController.swift
//  MultiplePagesViewControllerDemo
//
//  Created by Hongchao Zhang on 7/11/16.
//  Copyright © 2016 Hongchao Zhang. All rights reserved.
//

import Foundation
import UIKit

class PushedViewController: UIViewController {

    private let testLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        testLabel.text = "pushed"
        testLabel.frame = CGRect(x: 50, y: 50, width: 200, height: 100)
        testLabel.backgroundColor = UIColor.redColor()
        self.view.addSubview(testLabel)
    }

}
