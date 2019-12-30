//
//  UIView+ADRoute.m
//  ADNavigationBar_Example
//
//  Created by zhongaidong on 2019/12/30.
//  Copyright © 2019 goodswifter. All rights reserved.
//

#import "UIViewController+ADRoute.h"

@implementation UIViewController (ADRoute)

- (void)ad_toLastViewController {
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count == 1) {
            if (self.presentingViewController) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else if(self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

+ (UIViewController *)ad_currentViewController {
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    return [self ad_currentViewControllerFrom:rootViewController];
}

+ (UIViewController *)ad_currentViewControllerFrom:(UIViewController*)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController *)viewController;
        return [self ad_currentViewControllerFrom:navigationController.viewControllers.lastObject];
    } else if([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController *)viewController;
        return [self ad_currentViewControllerFrom:tabBarController.selectedViewController];
    } else if (viewController.presentedViewController != nil) {
        return [self ad_currentViewControllerFrom:viewController.presentedViewController];
    } else {
        return viewController;
    }
}

@end
