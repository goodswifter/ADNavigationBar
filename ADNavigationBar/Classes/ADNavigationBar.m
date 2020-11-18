//
//  ADNavigationBar.m
//  ADNavigationBar_Example
//
//  Created by zhongaidong on 2019/12/31.
//  Copyright © 2019 goodswifter. All rights reserved.
//

#import "ADNavigationBar.h"

@implementation ADNavigationBar

+ (BOOL)isIphoneX {
    return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) && ((int)([UIScreen mainScreen].bounds.size.width / [UIScreen mainScreen].bounds.size.height * 100) == 216 || (int)([UIScreen mainScreen].bounds.size.width / [UIScreen mainScreen].bounds.size.height * 100) == 46);
}

+ (CGFloat)navBarAndStatusBarHeight {
    return [self statusBarHeight] + 44;
}

+ (CGFloat)tabBarHeight {
    return [self isIphoneX] ? 83 : 49;
}

+ (CGFloat)statusBarHeight {
    CGFloat statusBarHeight = 0;
    if (@available(iOS 13.0, *)) {
        statusBarHeight = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height;
    } else {
        statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    return statusBarHeight;
}

+ (CGFloat)screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

@end
