//
//  UIViewController+ADExtension.m
//  ADNavigationBar_Example
//
//  Created by zhongaidong on 2019/12/30.
//  Copyright © 2019 goodswifter. All rights reserved.
//

#import "UIViewController+ADExtension.h"
#import "UINavigationBar+ADDefault.h"
#import "UIViewController+ADExtension.h"
#import "UINavigationController+ADExtension.h"
#import <objc/runtime.h>

//==========================================================================
#pragma mark - UIViewController
//==========================================================================
@implementation UIViewController (ADExtension)

static char kWRPushToCurrentVCFinishedKey;
static char kWRPushToNextVCFinishedKey;
static char kWRNavBarBackgroundImageKey;
static char kWRNavBarBarTintColorKey;
static char kWRNavBarBackgroundAlphaKey;
static char kWRNavBarTintColorKey;
static char kWRNavBarTitleColorKey;
static char kWRStatusBarStyleKey;
static char kWRNavBarShadowImageHiddenKey;
static char kWRCustomNavBarKey;
static char kWRSystemNavBarBarTintColorKey;
static char kWRSystemNavBarTintColorKey;
static char kWRSystemNavBarTitleColorKey;

// navigationBar barTintColor can not change by currentVC before fromVC push to currentVC finished
- (BOOL)pushToCurrentVCFinished {
    id isFinished = objc_getAssociatedObject(self, &kWRPushToCurrentVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}

- (void)setPushToCurrentVCFinished:(BOOL)isFinished {
    objc_setAssociatedObject(self, &kWRPushToCurrentVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar barTintColor can not change by currentVC when currentVC push to nextVC finished
- (BOOL)pushToNextVCFinished {
    id isFinished = objc_getAssociatedObject(self, &kWRPushToNextVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}

- (void)setPushToNextVCFinished:(BOOL)isFinished {
    objc_setAssociatedObject(self, &kWRPushToNextVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar backgroundImage
- (UIImage *)ad_navBarBackgroundImage {
    UIImage *image = (UIImage *)objc_getAssociatedObject(self, &kWRNavBarBackgroundImageKey);
    image = (image == nil) ? [UINavigationBar defaultNavBarBackgroundImage] : image;
    return image;
}

- (void)ad_setNavBarBackgroundImage:(UIImage *)image {
    if ([[self ad_customNavBar] isKindOfClass:[UINavigationBar class]]) {
    //  UINavigationBar *navBar = (UINavigationBar *)[self ad_customNavBar];
    //  [navBar ad_setBackgroundImage:image];
    } else {
        objc_setAssociatedObject(self, &kWRNavBarBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

// navigationBar systemBarTintColor
- (UIColor *)ad_systemNavBarBarTintColor {
    return (UIColor *)objc_getAssociatedObject(self, &kWRSystemNavBarBarTintColorKey);
}

- (void)ad_setSystemNavBarBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRSystemNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)ad_navBarBarTintColor {
    UIColor *barTintColor = (UIColor *)objc_getAssociatedObject(self, &kWRNavBarBarTintColorKey);
    if (![UINavigationBar needUpdateNavigationBar:self]) {
        if ([self ad_systemNavBarBarTintColor] == nil) {
            barTintColor = self.navigationController.navigationBar.barTintColor;
        } else {
            barTintColor = [self ad_systemNavBarBarTintColor];
        }
    }
    return (barTintColor != nil) ? barTintColor : [UINavigationBar defaultNavBarBarTintColor];
}

- (void)ad_setNavBarBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self ad_customNavBar] isKindOfClass:[UINavigationBar class]]) {
    //  UINavigationBar *navBar = (UINavigationBar *)[self ad_customNavBar];
    //  [navBar ad_setBackgroundColor:color];
    } else {
        BOOL isRootViewController = (self.navigationController.viewControllers.firstObject == self);
        if (([self pushToCurrentVCFinished] == YES || isRootViewController == YES) && [self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:color];
        }
    }
}

// navigationBar _UIBarBackground alpha
- (CGFloat)ad_navBarBackgroundAlpha {
    id barBackgroundAlpha = objc_getAssociatedObject(self, &kWRNavBarBackgroundAlphaKey);
    return (barBackgroundAlpha != nil) ? [barBackgroundAlpha floatValue] : [UINavigationBar defaultNavBarBackgroundAlpha];
}

- (void)ad_setNavBarBackgroundAlpha:(CGFloat)alpha {
    objc_setAssociatedObject(self, &kWRNavBarBackgroundAlphaKey, @(alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self ad_customNavBar] isKindOfClass:[UINavigationBar class]]) {
    //  UINavigationBar *navBar = (UINavigationBar *)[self ad_customNavBar];
    //  [navBar ad_setBackgroundAlpha:alpha];
    } else {
        BOOL isRootViewController = (self.navigationController.viewControllers.firstObject == self);
        if (([self pushToCurrentVCFinished] == YES || isRootViewController == YES) && [self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:alpha];
        }
    }
}

// navigationBar systemTintColor
- (UIColor *)ad_systemNavBarTintColor {
    return (UIColor *)objc_getAssociatedObject(self, &kWRSystemNavBarTintColorKey);
}

- (void)ad_setSystemNavBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRSystemNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar tintColor
- (UIColor *)ad_navBarTintColor {
    UIColor *tintColor = (UIColor *)objc_getAssociatedObject(self, &kWRNavBarTintColorKey);
    if (![UINavigationBar needUpdateNavigationBar:self]) {
        if ([self ad_systemNavBarTintColor] == nil) {
            tintColor = self.navigationController.navigationBar.tintColor;
        } else {
            tintColor = [self ad_systemNavBarTintColor];
        }
    }
    return (tintColor != nil) ? tintColor : [UINavigationBar defaultNavBarTintColor];
}

- (void)ad_setNavBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self ad_customNavBar] isKindOfClass:[UINavigationBar class]]) {
    //  UINavigationBar *navBar = (UINavigationBar *)[self ad_customNavBar];
    //  navBar.tintColor = color;
    } else {
        if ([self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForTintColor:color];
        }
    }
}

// navigationBar systemTitleColor
- (UIColor *)ad_systemNavBarTitleColor {
    return (UIColor *)objc_getAssociatedObject(self, &kWRSystemNavBarTitleColorKey);
}

- (void)ad_setSystemNavBarTitleColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRSystemNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBarTitleColor
- (UIColor *)ad_navBarTitleColor {
    UIColor *titleColor = (UIColor *)objc_getAssociatedObject(self, &kWRNavBarTitleColorKey);
    if (![UINavigationBar needUpdateNavigationBar:self]) {
        if ([self ad_systemNavBarTitleColor] == nil) {
            titleColor = self.navigationController.navigationBar.titleTextAttributes[@"NSColor"];
        } else {
            titleColor = [self ad_systemNavBarTitleColor];
        }
    }
    return (titleColor != nil) ? titleColor : [UINavigationBar defaultNavBarTitleColor];
}

- (void)ad_setNavBarTitleColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kWRNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self ad_customNavBar] isKindOfClass:[UINavigationBar class]]) {
    //  UINavigationBar *navBar = (UINavigationBar *)[self ad_customNavBar];
    //  navBar.titleTextAttributes = @{NSForegroundColorAttributeName:color};
    } else {
        if ([self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForTitleColor:color];
        }
    }
}

// statusBarStyle
- (UIStatusBarStyle)ad_statusBarStyle {
    id style = objc_getAssociatedObject(self, &kWRStatusBarStyleKey);
    return (style != nil) ? [style integerValue] : [UINavigationBar defaultStatusBarStyle];
}

- (void)ad_setStatusBarStyle:(UIStatusBarStyle)style {
    objc_setAssociatedObject(self, &kWRStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsStatusBarAppearanceUpdate];
}

// shadowImage
- (void)ad_setNavBarShadowImageHidden:(BOOL)hidden {
    objc_setAssociatedObject(self, &kWRNavBarShadowImageHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationController setNeedsNavigationBarUpdateForShadowImageHidden:hidden];
}

- (BOOL)ad_navBarShadowImageHidden {
    id hidden = objc_getAssociatedObject(self, &kWRNavBarShadowImageHiddenKey);
    return (hidden != nil) ? [hidden boolValue] : [UINavigationBar defaultNavBarShadowImageHidden];
}

// custom navigationBar
- (UIView *)ad_customNavBar {
    UIView *navBar = objc_getAssociatedObject(self, &kWRCustomNavBarKey);
    return (navBar != nil) ? navBar : [UIView new];
}

- (void)ad_setCustomNavBar:(UINavigationBar *)navBar {
    objc_setAssociatedObject(self, &kWRCustomNavBarKey, navBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       SEL needSwizzleSelectors[4] = {
           @selector(viewWillAppear:),
           @selector(viewWillDisappear:),
           @selector(viewDidAppear:),
           @selector(viewDidDisappear:)
       };
        
       for (int i = 0; i < 4;  i++) {
           SEL selector = needSwizzleSelectors[i];
           NSString *newSelectorStr = [NSString stringWithFormat:@"ad_%@", NSStringFromSelector(selector)];
           Method originMethod = class_getInstanceMethod(self, selector);
           Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
           method_exchangeImplementations(originMethod, swizzledMethod);
       }
    });
}

- (void)ad_viewWillAppear:(BOOL)animated {
    if ([self canUpdateNavigationBar]) {
        if (![UINavigationBar needUpdateNavigationBar:self]) {
            if ([self ad_systemNavBarBarTintColor] == nil) {
                [self ad_setSystemNavBarBarTintColor:[self ad_navBarBarTintColor]];
            }
            if ([self ad_systemNavBarTintColor] == nil) {
                [self ad_setSystemNavBarTintColor:[self ad_navBarTintColor]];
            }
            if ([self ad_systemNavBarTitleColor] == nil) {
                [self ad_setSystemNavBarTitleColor:[self ad_navBarTitleColor]];
            }
            [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self ad_navBarTintColor]];
        }
        [self setPushToNextVCFinished:NO];
        [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self ad_navBarTitleColor]];
    }
    [self ad_viewWillAppear:animated];
}

- (void)ad_viewWillDisappear:(BOOL)animated {
    if ([self canUpdateNavigationBar] == YES) {
        [self setPushToNextVCFinished:YES];
    }
    [self ad_viewWillDisappear:animated];
}

- (void)ad_viewDidAppear:(BOOL)animated
{
    if ([self isRootViewController] == NO) {
        self.pushToCurrentVCFinished = YES;
    }
    if ([self canUpdateNavigationBar] == YES)
    {
        UIImage *barBgImage = [self ad_navBarBackgroundImage];
        if (barBgImage != nil) {
            [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundImage:barBgImage];
        } else {
            if ([UINavigationBar needUpdateNavigationBar:self]) {
                [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:[self ad_navBarBarTintColor]];
            }
        }
        [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:[self ad_navBarBackgroundAlpha]];
        [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self ad_navBarTintColor]];
        [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self ad_navBarTitleColor]];
        [self.navigationController setNeedsNavigationBarUpdateForShadowImageHidden:[self ad_navBarShadowImageHidden]];
    }
    [self ad_viewDidAppear:animated];
}

- (void)ad_viewDidDisappear:(BOOL)animated {
    if (![UINavigationBar needUpdateNavigationBar:self] && !self.navigationController) {
        [self ad_setSystemNavBarBarTintColor:nil];
        [self ad_setSystemNavBarTintColor:nil];
        [self ad_setSystemNavBarTitleColor:nil];
    }
    [self ad_viewDidDisappear:animated];
}

- (BOOL)canUpdateNavigationBar {
    return [self.navigationController.viewControllers containsObject:self];
}

- (BOOL)isRootViewController {
    UIViewController *rootViewController = self.navigationController.viewControllers.firstObject;
    if ([rootViewController isKindOfClass:[UITabBarController class]] == NO) {
        return rootViewController == self;
    } else {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [tabBarController.viewControllers containsObject:self];
    }
}

@end
