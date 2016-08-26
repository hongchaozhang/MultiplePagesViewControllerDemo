//
//  SampleViewController.swift
//  MultiplePagesViewControllerDemo
//
//  Created by Hongchao Zhang on 5/5/16.
//  Copyright © 2016 Hongchao Zhang. All rights reserved.
//

import Foundation
import UIKit

// swiftlint:disable line_length

class SampleViewController: UIViewController {

    var ownerViewController: ViewController?

    @IBOutlet var label: UILabel!
    var labelText: String

    var testButton = UIButton()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(fromString labelText: String) {
        self.labelText = labelText
        super.init(nibName: nil, bundle: nil)
    }

    func handleButtonClicked() {
        print("button is clicked")

        self.ownerViewController?.navigationController?.pushViewController(PushedViewController(), animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.label.text = self.labelText

//        testButton.setTitle("Test", forState: UIControlState.Normal)
//        testButton.frame = CGRect(x: 50, y: 50, width: 200, height: 100)
//        testButton.backgroundColor = UIColor.blueColor()
//        testButton.addTarget(self, action: #selector(handleButtonClicked), forControlEvents: UIControlEvents.TouchUpInside)
//        self.view.addSubview(testButton)
    }

}
// swiftlint:enable line_length
