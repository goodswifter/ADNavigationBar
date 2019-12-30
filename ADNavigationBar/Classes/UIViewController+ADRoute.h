//
//  UIView+ADRoute.h
//  ADNavigationBar_Example
//
//  Created by zhongaidong on 2019/12/30.
//  Copyright © 2019 goodswifter. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (ADRoute)

- (void)ad_toLastViewController;
+ (UIViewController *)ad_currentViewController;
+ (UIViewController *)ad_currentViewControllerFrom:(UIViewController*)viewController;

@end

NS_ASSUME_NONNULL_END
