//
//  UINavigationBar+ADDefault.h
//  ADNavigationBar_Example
//
//  Created by zhongaidong on 2019/12/30.
//  Copyright © 2019 goodswifter. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (ADDefault)

+ (BOOL)isIphoneX;
+ (CGFloat)navBarAndStatusBarHeight;
+ (CGFloat)tabBarHeight;
+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;

/// 局部使用该库       待开发
//+ (void)ad_local;
/// 广泛使用该库       default 暂时是默认,  ad_local 完成后, ad_local就会变成默认
+ (void)ad_widely;

/// 局部使用该库时, 设置需要用到的控制器      待开发
//+ (void)ad_setWhitelist:(NSArray<NSString *> *)list;
/// 广泛使用该库时, 设置需要屏蔽的控制器
+ (void)ad_setBlacklist:(NSArray<NSString *> *)list;

/// set default barTintColor of UINavigationBar
+ (void)ad_setDefaultNavBarBarTintColor:(UIColor *)color;

/// set default barBackgroundImage of UINavigationBar
/// warning: ad_setDefaultNavBarBackgroundImage is deprecated! place use WRCustomNavigationBar
//+ (void)ad_setDefaultNavBarBackgroundImage:(UIImage *)image;

/// set default tintColor of UINavigationBar
+ (void)ad_setDefaultNavBarTintColor:(UIColor *)color;

/// set default titleColor of UINavigationBar
+ (void)ad_setDefaultNavBarTitleColor:(UIColor *)color;

/// set default statusBarStyle of UIStatusBar
+ (void)ad_setDefaultStatusBarStyle:(UIStatusBarStyle)style;

/// set default shadowImage isHidden of UINavigationBar
+ (void)ad_setDefaultNavBarShadowImageHidden:(BOOL)hidden;

+ (UIColor *)middleColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(CGFloat)percent;

+ (BOOL)needUpdateNavigationBar:(UIViewController *)vc;

+ (CGFloat)middleAlpha:(CGFloat)fromAlpha toAlpha:(CGFloat)toAlpha percent:(CGFloat)percent;

+ (UIImage *)defaultNavBarBackgroundImage;
+ (UIColor *)defaultNavBarBarTintColor;
+ (CGFloat)defaultNavBarBackgroundAlpha;
+ (UIColor *)defaultNavBarTintColor;
+ (UIColor *)defaultNavBarTitleColor;
+ (UIStatusBarStyle)defaultStatusBarStyle;
+ (BOOL)defaultNavBarShadowImageHidden;

@end

NS_ASSUME_NONNULL_END
