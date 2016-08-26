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
// swiftlint:disable line_length
private let pageControlHeight: CGFloat = 20.0

protocol MultiplePagesViewControllerDelegate : class {
    func pageChange(to pageIndex: Int)
}

class MultiplePagesViewController: UIViewController, UIScrollViewDelegate {

    var ownerViewController: ViewController?
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

        self.mainScrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.pageControl.frame = CGRect(x: 0, y: self.view.frame.size.height - pageControlHeight, width: self.view.frame.size.width, height: pageControlHeight)
        for vcIndex in 0...(self.viewControllers.count - 1) {
            let vc = self.viewControllers[vcIndex]
            vc.view.frame = CGRect(x: self.mainScrollView.frame.size.width * CGFloat(vcIndex), y: 0, width: self.mainScrollView.frame.size.width, height: self.mainScrollView.frame.size.height)
        }

        self.mainScrollView.contentSize = CGSize(width: self.mainScrollView.frame.size.width * CGFloat(self.viewControllers.count), height: self.mainScrollView.frame.size.height)

        let currentOffset = CGPoint(x: CGFloat(self.currentPageIndex) * self.mainScrollView.frame.size.width, y: 0)
        self.mainScrollView.setContentOffset(currentOffset, animated: false)
    }

    /*!
     add an UIViewController into MultiplePagesViewController

     - parameter viewController: instance kind of UIViewController
     */
    func addViewController(viewController: UIViewController) {
        if !self.viewControllers.contains(viewController) {
            let x = self.mainScrollView.frame.size.width * CGFloat(self.viewControllers.count)
            let width = self.mainScrollView.frame.size.width
            let height = self.mainScrollView.frame.size.height

            viewController.view.frame = CGRect(x: x, y: 0, width: width, height: height)
            self.mainScrollView.addSubview(viewController.view)

            let sizeWidth = self.mainScrollView.frame.size.width * CGFloat(self.viewControllers.count + 1)
            let sizeHeight = self.mainScrollView.frame.size.height
            self.mainScrollView.contentSize = CGSize(width: sizeWidth, height: sizeHeight)

            self.viewControllers.append(viewController)

            self.pageControl.numberOfPages += 1
        }
    }

    /*!
     remove an UIViewController by index
     - parameter index: index of UIViewController
     */
    func removeViewController(withIndex viewControllerIndex: Int) {
        if viewControllerIndex < self.viewControllers.count && self.viewControllers.count > 1 {
            let vc = self.viewControllers[viewControllerIndex]
            if (vc.view.superview) != nil {
                vc.view.removeFromSuperview()
            }

            let frameSize = self.mainScrollView.frame.size
            for i in (viewControllerIndex + 1)...(self.viewControllers.count - 1) {
                let tempVc = self.viewControllers[i]
                let x = tempVc.view.frame.origin.x - frameSize.width
                let width = frameSize.width
                let height = frameSize.height
                tempVc.view.frame = CGRect(x: x, y: 0, width: width, height: height)
            }

            let sizeWidth = frameSize.width * CGFloat(self.viewControllers.count - 1)
            let sizeHeight = frameSize.height
            self.mainScrollView.contentSize = CGSize(width: sizeWidth, height: sizeHeight)

            if self.currentPageIndex == self.viewControllers.count - 1 { // the last one
                self.currentPageIndex -= 1
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
        self.mainScrollView.contentSize = CGSize(width: 0, height: 0)

        self.initializePageControl()
        self.initializeMainScrollView()

    }

    private func initializePageControl() {
        pageControl.frame = CGRect(x: 0, y: self.view.frame.size.height - pageControlHeight, width: self.view.frame.size.width, height: pageControlHeight)
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.darkGrayColor()

    }

    private func initializeMainScrollView() {
        mainScrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
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
// swiftlint:enable line_length
