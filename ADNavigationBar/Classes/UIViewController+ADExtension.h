//
//  UIViewController+ADExtension.h
//  ADNavigationBar_Example
//
//  Created by zhongaidong on 2019/12/30.
//  Copyright © 2019 goodswifter. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (ADExtension)

/// record current ViewController navigationBar backgroundImage
/// warning: ad_setDefaultNavBarBackgroundImage is deprecated! place use WRCustomNavigationBar
//- (void)ad_setNavBarBackgroundImage:(UIImage *)image;
- (UIImage *)ad_navBarBackgroundImage;

/// record current ViewController navigationBar barTintColor
- (void)ad_setNavBarBarTintColor:(UIColor *)color;
- (UIColor *)ad_navBarBarTintColor;

/// record current ViewController navigationBar backgroundAlpha
- (void)ad_setNavBarBackgroundAlpha:(CGFloat)alpha;
- (CGFloat)ad_navBarBackgroundAlpha;

/// record current ViewController navigationBar tintColor
- (void)ad_setNavBarTintColor:(UIColor *)color;
- (UIColor *)ad_navBarTintColor;

/// record current ViewController titleColor
- (void)ad_setNavBarTitleColor:(UIColor *)color;
- (UIColor *)ad_navBarTitleColor;

/// record current ViewController statusBarStyle
- (void)ad_setStatusBarStyle:(UIStatusBarStyle)style;
- (UIStatusBarStyle)ad_statusBarStyle;

/// record current ViewController navigationBar shadowImage hidden
- (void)ad_setNavBarShadowImageHidden:(BOOL)hidden;
- (BOOL)ad_navBarShadowImageHidden;

/// record current ViewController custom navigationBar
/// warning: ad_setDefaultNavBarBackgroundImage is deprecated! place use WRCustomNavigationBar
//- (void)ad_setCustomNavBar:(WRCustomNavigationBar *)navBar;

- (void)setPushToCurrentVCFinished:(BOOL)isFinished;

@end

NS_ASSUME_NONNULL_END
