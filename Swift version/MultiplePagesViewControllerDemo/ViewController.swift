//
//  ViewController.swift
//  MultiplePagesViewControllerDemo
//
//  Created by Hongchao Zhang on 6/21/16.
//  Copyright © 2016 Hongchao Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MultiplePagesViewControllerDelegate {
    
    private var multiplePagesViewController = MultiplePagesViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.addSubview(self.multiplePagesViewController.view)
        self.addChildViewController(self.multiplePagesViewController)
        self.addDefaultPageViewControllers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.multiplePagesViewController.view.frame = self.view.frame
    }
    
    func pageChange(to pageIndex: Int) {
        // do something when page changed in MultiplePagesViewController
        return
    }
    
    private func initializeProperties() {
        self.multiplePagesViewController.view.frame = self.view.frame
        self.multiplePagesViewController.delegate = self
    }
    
    private func addDefaultPageViewControllers() {
        let vcCount = 3
        for i in 0...(vcCount - 1) {
            let svc = SampleViewController(fromString: String(i))
            self.multiplePagesViewController.addViewController(svc)
        }
    }
    
    
}

