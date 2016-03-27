//
//  SampleViewController.m
//  MultiplePagesViewControllerDemo
//
//  Created by Hongchao Zhang on 3/27/16.
//  Copyright © 2016 Hongchao Zhang. All rights reserved.
//

#import "SampleViewController.h"

@interface SampleViewController ()
@property (strong, nonatomic) IBOutlet UILabel *centerLabel;
@property (strong, nonatomic) NSString *centerLabelText;

@end

@implementation SampleViewController

- (instancetype)initWithText:(NSString *)labelText {
    if (self = [self init]) {
        self.centerLabelText = labelText;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.centerLabel.text = self.centerLabelText;
    
}




@end
