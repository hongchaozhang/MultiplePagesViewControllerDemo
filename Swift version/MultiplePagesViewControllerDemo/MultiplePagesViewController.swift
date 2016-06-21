//
//  MultiplePagesViewController.swift
//  MultiplePagesViewControllerDemo
//
//  Created by Hongchao Zhang on 5/5/16.
//  Copyright © 2016 Hongchao Zhang. All rights reserved.
//

import Foundation
import UIKit
//import GLKit

private let PAGE_CONTROL_HEIGHT:CGFloat = 20.0

protocol MultiplePagesViewControllerDelegate : class {
    func pageChange(to pageIndex: Int)
}

class MultiplePagesViewController : UIViewController, UIScrollViewDelegate {
    //warning: use weak keyword
    weak var delegate: MultiplePagesViewControllerDelegate?
    
    private var viewControllers: Array<UIViewController> = Array()
    private let pageControl = UIPageControl()
    private var currentPageIndex: Int = 0
    //warning: how to use getter and setter
    private let mainScrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeProperties()
        self.view.addSubview(self.mainScrollView)
        self.view.addSubview(self.pageControl)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.mainScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        self.pageControl.frame = CGRectMake(0, self.view.frame.size.height - PAGE_CONTROL_HEIGHT, self.view.frame.size.width, PAGE_CONTROL_HEIGHT);
        for vcIndex in 0...(self.viewControllers.count - 1) {
            let vc = self.viewControllers[vcIndex]
            vc.view.frame = CGRectMake(self.mainScrollView.frame.size.width * CGFloat(vcIndex), 0, self.mainScrollView.frame.size.width, self.mainScrollView.frame.size.height);
        }
        
        self.mainScrollView.contentSize = CGSizeMake(self.mainScrollView.frame.size.width * CGFloat(self.viewControllers.count), self.mainScrollView.frame.size.height);
        
        let currentOffset = CGPointMake(CGFloat(self.currentPageIndex) * self.mainScrollView.frame.size.width, 0);
        self.mainScrollView.setContentOffset(currentOffset, animated: false)
    }
    
    /*!
     add an UIViewController into MultiplePagesViewController
     
     - parameter viewController: instance kind of UIViewController
     */
    func addViewController(viewController: UIViewController) {
        if (!self.viewControllers.contains(viewController)) {
            viewController.view.frame = CGRectMake(self.mainScrollView.frame.size.width * CGFloat(self.viewControllers.count), 0, self.mainScrollView.frame.size.width, self.mainScrollView.frame.size.height);
            self.mainScrollView.addSubview(viewController.view)
            
            self.mainScrollView.contentSize = CGSizeMake(self.mainScrollView.frame.size.width * CGFloat(self.viewControllers.count + 1), self.mainScrollView.frame.size.height);
            
            self.viewControllers.append(viewController)
            
            self.pageControl.numberOfPages += 1;
        }
    }
    
    /*!
     remove an UIViewController by index
     
     - parameter index: index of UIViewController
     */
    func removeViewController(withIndex viewControllerIndex: Int) {
        if (viewControllerIndex < self.viewControllers.count && self.viewControllers.count > 1) {
            let vc = self.viewControllers[viewControllerIndex]
            if ((vc.view.superview) != nil) {
                vc.view.removeFromSuperview()
            }
            
            for i in (viewControllerIndex + 1)...(self.viewControllers.count - 1) {
                let tempVc = self.viewControllers[i]
                tempVc.view.frame = CGRectMake(tempVc.view.frame.origin.x - self.mainScrollView.frame.size.width, 0, self.mainScrollView.frame.size.width, self.mainScrollView.frame.size.height);
            }
            
            self.mainScrollView.contentSize = CGSizeMake(self.mainScrollView.frame.size.width * CGFloat(self.viewControllers.count - 1), self.mainScrollView.frame.size.height);
            
            if (self.currentPageIndex == self.viewControllers.count - 1) { // the last one
                self.currentPageIndex -= 1;
            }
            
            //        [[self.viewControllers objectAtIndex:viewControllerIndex] removeFromParentViewController];
            self.viewControllers.removeAtIndex(viewControllerIndex)
            
            self.pageControl.numberOfPages = self.viewControllers.count
            self.pageControl.currentPage = self.currentPageIndex
            
            self.delegate?.pageChange(to: self.currentPageIndex)
            
            
        }
    }
    
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.currentPageIndex = Int(floor((scrollView.contentOffset.x - scrollView.frame.size.width / 2) / scrollView.frame.size.width)) + 1
        self.pageControl.currentPage = self.currentPageIndex
        self.delegate?.pageChange(to: self.currentPageIndex)
    }
    
    
    
    private func initializeProperties() {
        self.currentPageIndex = 0
        self.pageControl.numberOfPages = 0
        self.pageControl.currentPage = self.currentPageIndex
        self.mainScrollView.contentSize = CGSizeMake(0, 0)
        
        self.initializePageControl()
        self.initializeMainScrollView()
        
    }
    
    private func initializePageControl() {
        pageControl.frame = CGRectMake(0, self.view.frame.size.height - PAGE_CONTROL_HEIGHT, self.view.frame.size.width, PAGE_CONTROL_HEIGHT);
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.darkGrayColor()

    }
    
    private func initializeMainScrollView() {
        mainScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        mainScrollView.pagingEnabled = true
        mainScrollView.showsHorizontalScrollIndicator = false
        mainScrollView.showsVerticalScrollIndicator = false
        mainScrollView.scrollsToTop = false
        mainScrollView.alwaysBounceVertical = false
        mainScrollView.bounces = false
        mainScrollView.directionalLockEnabled = true
        mainScrollView.delegate = self
    }
}