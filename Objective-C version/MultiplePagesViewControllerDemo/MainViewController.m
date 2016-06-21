//
//  ViewController.m
//  MultiplePagesViewControllerDemo
//
//  Created by Hongchao Zhang on 3/27/16.
//  Copyright © 2016 Hongchao Zhang. All rights reserved.
//

#import "MainViewController.h"

#import "SampleViewController.h"

@interface MainViewController ()
@property (strong, nonatomic) MultiplePagesViewController *multiplePagesViewController;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.multiplePagesViewController.view];
    [self addChildViewController:self.multiplePagesViewController];
    
    [self addDefaultPageViewControllers];
}

- (void)addDefaultPageViewControllers {
    NSInteger vcCount = 3;
    for (NSInteger i = 0; i < vcCount; i++) {
        SampleViewController *svc = [[SampleViewController alloc] initWithText:[NSString stringWithFormat:@"%ld", i]];
        [self.multiplePagesViewController addViewController:svc];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.multiplePagesViewController.view.frame = self.view.frame;
}

#pragma mark - <MultiplePagesViewControllerDelegate>

- (void)pageChangedTo:(NSInteger)pageIndex {
    // do something when page changed in MultiplePagesViewController
}


#pragma mark - getters and setters
- (MultiplePagesViewController*)multiplePagesViewController {
    if (!_multiplePagesViewController) {
        _multiplePagesViewController = [[MultiplePagesViewController alloc] init];
        _multiplePagesViewController.view.frame = self.view.frame;
        _multiplePagesViewController.delegate = self;
    }
    
    return _multiplePagesViewController;
}
@end
