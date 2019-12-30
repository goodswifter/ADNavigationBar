//
//  UINavigationController+ADExtension.m
//  ADNavigationBar_Example
//
//  Created by zhongaidong on 2019/12/30.
//  Copyright © 2019 goodswifter. All rights reserved.
//

#import "UINavigationController+ADExtension.h"
#import "UIViewController+ADExtension.h"
#import "UINavigationBar+ADExtension.h"
#import "UINavigationBar+ADDefault.h"
#import <objc/runtime.h>

@implementation UINavigationController (ADExtension)

static CGFloat wrPopDuration = 0.12;
static int wrPopDisplayCount = 0;
- (CGFloat)wrPopProgress {
    CGFloat all = 60 * wrPopDuration;
    int current = MIN(all, wrPopDisplayCount);
    return current / all;
}

static CGFloat wrPushDuration = 0.10;
static int wrPushDisplayCount = 0;
- (CGFloat)wrPushProgress {
    CGFloat all = 60 * wrPushDuration;
    int current = MIN(all, wrPushDisplayCount);
    return current / all;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.topViewController ad_statusBarStyle];
}

- (void)setNeedsNavigationBarUpdateForBarBackgroundImage:(UIImage *)backgroundImage {
    [self.navigationBar ad_setBackgroundImage:backgroundImage];
}

- (void)setNeedsNavigationBarUpdateForBarTintColor:(UIColor *)barTintColor {
    [self.navigationBar ad_setBackgroundColor:barTintColor];
}

- (void)setNeedsNavigationBarUpdateForBarBackgroundAlpha:(CGFloat)barBackgroundAlpha {
    [self.navigationBar ad_setBackgroundAlpha:barBackgroundAlpha];
}

- (void)setNeedsNavigationBarUpdateForTintColor:(UIColor *)tintColor {
    self.navigationBar.tintColor = tintColor;
}

- (void)setNeedsNavigationBarUpdateForShadowImageHidden:(BOOL)hidden {
    self.navigationBar.shadowImage = (hidden == YES) ? [UIImage new] : nil;
}

- (void)setNeedsNavigationBarUpdateForTitleColor:(UIColor *)titleColor {
    NSDictionary *titleTextAttributes = [self.navigationBar titleTextAttributes];
    if (titleTextAttributes == nil) {
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:titleColor};
        return;
    }
    NSMutableDictionary *newTitleTextAttributes = [titleTextAttributes mutableCopy];
    newTitleTextAttributes[NSForegroundColorAttributeName] = titleColor;
    self.navigationBar.titleTextAttributes = newTitleTextAttributes;
}

- (void)updateNavigationBarWithFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC progress:(CGFloat)progress {
    // change navBarBarTintColor
    UIColor *fromBarTintColor = [fromVC ad_navBarBarTintColor];
    UIColor *toBarTintColor = [toVC ad_navBarBarTintColor];
    UIColor *newBarTintColor = [UINavigationBar middleColor:fromBarTintColor toColor:toBarTintColor percent:progress];
    if ([UINavigationBar needUpdateNavigationBar:fromVC] || [UINavigationBar needUpdateNavigationBar:toVC]) {
        [self setNeedsNavigationBarUpdateForBarTintColor:newBarTintColor];
    }
    
    // change navBarTintColor
    UIColor *fromTintColor = [fromVC ad_navBarTintColor];
    UIColor *toTintColor = [toVC ad_navBarTintColor];
    UIColor *newTintColor = [UINavigationBar middleColor:fromTintColor toColor:toTintColor percent:progress];
    if ([UINavigationBar needUpdateNavigationBar:fromVC]) {
        [self setNeedsNavigationBarUpdateForTintColor:newTintColor];
    }

    // change navBarTitleColor（在ad_popToViewController:animated:方法中直接改变标题颜色）
    UIColor *fromTitleColor = [fromVC ad_navBarTitleColor];
    UIColor *toTitleColor = [toVC ad_navBarTitleColor];
    UIColor *newTitleColor = [UINavigationBar middleColor:fromTitleColor toColor:toTitleColor percent:progress];
    [self setNeedsNavigationBarUpdateForTitleColor:newTitleColor];
    
    // change navBar _UIBarBackground alpha
    CGFloat fromBarBackgroundAlpha = [fromVC ad_navBarBackgroundAlpha];
    CGFloat toBarBackgroundAlpha = [toVC ad_navBarBackgroundAlpha];
    CGFloat newBarBackgroundAlpha = [UINavigationBar middleAlpha:fromBarBackgroundAlpha toAlpha:toBarBackgroundAlpha percent:progress];
    [self setNeedsNavigationBarUpdateForBarBackgroundAlpha:newBarBackgroundAlpha];
}

#pragma mark - call swizzling methods active 主动调用交换方法
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL needSwizzleSelectors[4] = {
            NSSelectorFromString(@"_updateInteractiveTransition:"),
            @selector(popToViewController:animated:),
            @selector(popToRootViewControllerAnimated:),
            @selector(pushViewController:animated:)
        };
      
        for (int i = 0; i < 4;  i++) {
            SEL selector = needSwizzleSelectors[i];
            NSString *newSelectorStr = [[NSString stringWithFormat:@"ad_%@", NSStringFromSelector(selector)] stringByReplacingOccurrencesOfString:@"__" withString:@"_"];
            Method originMethod = class_getInstanceMethod(self, selector);
            Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

- (NSArray<UIViewController *> *)ad_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // pop 的时候直接改变 barTintColor、tintColor
    [self setNeedsNavigationBarUpdateForTitleColor:[viewController ad_navBarTitleColor]];
    [self setNeedsNavigationBarUpdateForTintColor:[viewController ad_navBarTintColor]];
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        wrPopDisplayCount = 0;
    }];
    [CATransaction setAnimationDuration:wrPopDuration];
    [CATransaction begin];
    NSArray<UIViewController *> *vcs = [self ad_popToViewController:viewController animated:animated];
    [CATransaction commit];
    return vcs;
}

- (NSArray<UIViewController *> *)ad_popToRootViewControllerAnimated:(BOOL)animated {
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        wrPopDisplayCount = 0;
    }];
    [CATransaction setAnimationDuration:wrPopDuration];
    [CATransaction begin];
    NSArray<UIViewController *> *vcs = [self ad_popToRootViewControllerAnimated:animated];
    [CATransaction commit];
    return vcs;
}

// change navigationBar barTintColor smooth before pop to current VC finished
- (void)popNeedDisplay {
    if (self.topViewController != nil && self.topViewController.transitionCoordinator != nil) {
        wrPopDisplayCount += 1;
        CGFloat popProgress = [self wrPopProgress];
        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:popProgress];
    }
}

- (void)ad_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(pushNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        wrPushDisplayCount = 0;
        [viewController setPushToCurrentVCFinished:YES];
    }];
    [CATransaction setAnimationDuration:wrPushDuration];
    [CATransaction begin];
    [self ad_pushViewController:viewController animated:animated];
    [CATransaction commit];
}

// change navigationBar barTintColor smooth before push to current VC finished or before pop to current VC finished
- (void)pushNeedDisplay {
    if (self.topViewController != nil && self.topViewController.transitionCoordinator != nil) {
        wrPushDisplayCount += 1;
        CGFloat pushProgress = [self wrPushProgress];
        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:pushProgress];
    }
}

#pragma mark - deal the gesture of return
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    __weak typeof (self) weakSelf = self;
    id<UIViewControllerTransitionCoordinator> coor = [self.topViewController transitionCoordinator];
    if ([coor initiallyInteractive] == YES) {
        if (@available(iOS 10.0, *)) {
            [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                __strong typeof (self) pThis = weakSelf;
                [pThis dealInteractionChanges:context];
            }];
        } else {
            [coor notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                __strong typeof (self) pThis = weakSelf;
                [pThis dealInteractionChanges:context];
            }];
        }
        return YES;
    }
    
    NSUInteger itemCount = self.navigationBar.items.count;
    NSUInteger n = self.viewControllers.count >= itemCount ? 2 : 1;
    UIViewController *popToVC = self.viewControllers[self.viewControllers.count - n];
    
    // TODO : 为什么放到主线程就不会崩溃???
    dispatch_async(dispatch_get_main_queue(), ^{
        [self popToViewController:popToVC animated:YES];
    });
    
    return YES;
}

// deal the gesture of return break off
- (void)dealInteractionChanges:(id<UIViewControllerTransitionCoordinatorContext>)context {
    void (^animations) (UITransitionContextViewControllerKey) = ^(UITransitionContextViewControllerKey key){
        UIViewController *vc = [context viewControllerForKey:key];
        UIColor *curColor = [vc ad_navBarBarTintColor];
        CGFloat curAlpha = [vc ad_navBarBackgroundAlpha];
        [self setNeedsNavigationBarUpdateForBarTintColor:curColor];
        [self setNeedsNavigationBarUpdateForBarBackgroundAlpha:curAlpha];
    };
    
    // after that, cancel the gesture of return
    if ([context isCancelled] == YES) {
        double cancelDuration = 0;
        [UIView animateWithDuration:cancelDuration animations:^{
            animations(UITransitionContextFromViewControllerKey);
        }];
    } else {
        // after that, finish the gesture of return
        double finishDuration = [context transitionDuration] * (1 - [context percentComplete]);
        [UIView animateWithDuration:finishDuration animations:^{
            animations(UITransitionContextToViewControllerKey);
        }];
    }
}

- (void)ad_updateInteractiveTransition:(CGFloat)percentComplete {
    UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
    [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:percentComplete];
    [self ad_updateInteractiveTransition:percentComplete];
}

@end
