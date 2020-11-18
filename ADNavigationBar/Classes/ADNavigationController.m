//
//  ADNavigationController.m
//  ADNavigationBar
//
//  Created by zhongaidong on 2020/11/18.
//

#import "ADNavigationController.h"
#import "UINavigationController+ADExtension.h"
#import "UIViewController+ADExtension.h"

@interface ADNavigationController ()

@end

@implementation ADNavigationController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.topViewController ad_statusBarStyle];
}

@end
