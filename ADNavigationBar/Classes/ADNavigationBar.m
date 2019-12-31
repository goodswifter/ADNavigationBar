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
    return [self isIphoneX] ? 88 : 64;
}

+ (CGFloat)tabBarHeight {
    return [self isIphoneX] ? 83 : 49;
}

+ (CGFloat)screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

@end
