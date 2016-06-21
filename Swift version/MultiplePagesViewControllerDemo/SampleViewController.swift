//
//  SampleViewController.swift
//  MultiplePagesViewControllerDemo
//
//  Created by Hongchao Zhang on 5/5/16.
//  Copyright © 2016 Hongchao Zhang. All rights reserved.
//

import Foundation
import UIKit

class SampleViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    var labelText: String
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fromString labelText: String) {
        self.labelText = labelText;
        super.init(nibName: nil, bundle: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.label.text = self.labelText
    }
    
}