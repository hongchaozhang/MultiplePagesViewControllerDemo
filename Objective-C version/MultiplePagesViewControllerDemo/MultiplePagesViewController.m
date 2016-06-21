//
//  MultiplePagesViewController.m
//  PageControlApp
//
//  Created by Hongchao Zhang on 3/10/16.
//  Copyright © 2016 Hongchao Zhang. All rights reserved.
//

#import "MultiplePagesViewController.h"

#define PAGE_CONTROL_HEIGHT 20

@interface MultiplePagesViewController ()
@property (nonatomic, strong)NSMutableArray<__kindof UIViewController*> *viewControllers;
@property (nonatomic, strong)UIPageControl *pageControl;
@property (nonatomic)NSInteger currentPageIndex;
@property (nonatomic, strong)UIScrollView *mainScrollView;

@end


@implementation MultiplePagesViewController

#pragma mark - life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initializeProperties];
    [self.view addSubview:self.mainScrollView];
    [self.view addSubview:self.pageControl];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.mainScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.pageControl.frame = CGRectMake(0, self.view.frame.size.height - PAGE_CONTROL_HEIGHT, self.view.frame.size.width, PAGE_CONTROL_HEIGHT);
    for (NSInteger vcIndex = 0; vcIndex < [self.viewControllers count]; vcIndex++) {
        UIViewController *vc = [self.viewControllers objectAtIndex:vcIndex];
        vc.view.frame = CGRectMake(self.mainScrollView.frame.size.width * vcIndex, 0, self.mainScrollView.frame.size.width, self.mainScrollView.frame.size.height);
    }
    
    self.mainScrollView.contentSize = CGSizeMake(self.mainScrollView.frame.size.width * [self.viewControllers count], self.mainScrollView.frame.size.height);
    
    CGPoint currentOffset = CGPointMake(self.currentPageIndex * self.mainScrollView.frame.size.width, 0);
    [self.mainScrollView setContentOffset:currentOffset];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - public
- (void)addViewController:(UIViewController *)viewController {
    if (![self.viewControllers containsObject:viewController]) {
        viewController.view.frame = CGRectMake(self.mainScrollView.frame.size.width * [self.viewControllers count], 0, self.mainScrollView.frame.size.width, self.mainScrollView.frame.size.height);
        [self.mainScrollView addSubview:viewController.view];
        self.mainScrollView.contentSize = CGSizeMake(self.mainScrollView.frame.size.width * ([self.viewControllers count] + 1), self.mainScrollView.frame.size.height);
        
//        [self addChildViewController:viewController];
        [self.viewControllers addObject:viewController];
        
        self.pageControl.numberOfPages += 1;
    }
    
}

- (void)removeViewController:(NSUInteger)viewControllerIndex {
    if (viewControllerIndex < [self.viewControllers count] && [self.viewControllers count] > 1) {
        UIViewController *vc = [self.viewControllers objectAtIndex:viewControllerIndex];
        if (vc.view.superview) {
            [vc.view removeFromSuperview];
        }
        
        for (NSInteger i = viewControllerIndex + 1; i < [self.viewControllers count]; i++) {
            UIViewController *tempVc = [self.viewControllers objectAtIndex:i];
            tempVc.view.frame = CGRectMake(tempVc.view.frame.origin.x - self.mainScrollView.frame.size.width, 0, self.mainScrollView.frame.size.width, self.mainScrollView.frame.size.height);
        }
        
        self.mainScrollView.contentSize = CGSizeMake(self.mainScrollView.frame.size.width * ([self.viewControllers count] - 1), self.mainScrollView.frame.size.height);
        
        if (self.currentPageIndex == [self.viewControllers count] - 1) { // the last one
            self.currentPageIndex -= 1;
        }
        
//        [[self.viewControllers objectAtIndex:viewControllerIndex] removeFromParentViewController];
        [self.viewControllers removeObjectAtIndex:viewControllerIndex];
        
        self.pageControl.numberOfPages = [self.viewControllers count];
        self.pageControl.currentPage = self.currentPageIndex;
        
        [self.delegate pageChangedTo:self.currentPageIndex];
        
        
    }
}

/*
- (UIViewController*)getCurrentViewController {
    if ([self.viewControllers count] > self.currentPageIndex) {
        return [self.viewControllers objectAtIndex:self.currentPageIndex];
    } else {
        return nil;
    }
}

- (NSMutableArray*)getAllViewControllerTitles {
    NSMutableArray *titleArray = [[NSMutableArray alloc] init];
    for (UIViewController *vc in self.viewControllers) {
        [titleArray addObject:vc.title];
    }
    
    return titleArray;
}

- (UIViewController*)getViewControllerAtIndex:(NSInteger)viewControllerIndex {
    if ([self.viewControllers count] > viewControllerIndex && viewControllerIndex >= 0) {
        return [self.viewControllers objectAtIndex:viewControllerIndex];
    }
    
    return nil;
}

- (NSInteger)getViewControllerCount {
    return [self.viewControllers count];
}
 */



#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.currentPageIndex = floor((scrollView.contentOffset.x - scrollView.frame.size.width / 2) / scrollView.frame.size.width) + 1;
    self.pageControl.currentPage = self.currentPageIndex;
    [self.delegate pageChangedTo:self.currentPageIndex];
}


#pragma mark - getter and setter
- (UIScrollView*)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.scrollsToTop = NO;
        _mainScrollView.alwaysBounceVertical = NO;
        _mainScrollView.bounces = NO;
        _mainScrollView.directionalLockEnabled = YES;
        _mainScrollView.delegate = self;
    }
    
    return _mainScrollView;
}
- (NSMutableArray*)viewControllers {
    if (!_viewControllers) {
        _viewControllers = [[NSMutableArray alloc] init];
    }
    
    return _viewControllers;
}

- (UIPageControl*)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.frame = CGRectMake(0, self.view.frame.size.height - PAGE_CONTROL_HEIGHT, self.view.frame.size.width, PAGE_CONTROL_HEIGHT);
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    }
    
    return _pageControl;
}

#pragma mark - private

- (void)initializeProperties {
    self.currentPageIndex = 0;
    self.pageControl.numberOfPages = 0;
    self.pageControl.currentPage = self.currentPageIndex;
    self.mainScrollView.contentSize = CGSizeMake(0, 0);
}

@end
