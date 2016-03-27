//
//  MultiplePagesViewController.h
//  PageControlApp
//
//  Created by Hongchao Zhang on 3/10/16.
//  Copyright © 2016 Hongchao Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MultiplePagesViewControllerDelegate <NSObject>

- (void)pageChangedTo:(NSInteger)pageIndex;

@end



@interface MultiplePagesViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, weak) id<MultiplePagesViewControllerDelegate> delegate;

/**
 *  add a new <UIViewController*> instance
 *
 *  @param viewController
 */
- (void)addViewController:(UIViewController*)viewController;

/**
 *  remove an existing view controller by index
 *
 *  @param viewControllerIndex
 */
- (void)removeViewController:(NSUInteger)viewControllerIndex;


/*
- (UIViewController*)getCurrentViewController;
- (NSMutableArray*)getAllViewControllerTitles;
- (UIViewController*)getViewControllerAtIndex:(NSInteger)viewControllerIndex;
- (NSInteger)getViewControllerCount;
*/

@end
