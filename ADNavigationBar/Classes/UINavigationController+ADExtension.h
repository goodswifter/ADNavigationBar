//
//  UINavigationController+ADExtension.h
//  ADNavigationBar_Example
//
//  Created by zhongaidong on 2019/12/30.
//  Copyright © 2019 goodswifter. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (ADExtension)

- (void)setNeedsNavigationBarUpdateForBarTintColor:(UIColor *)barTintColor;
- (void)setNeedsNavigationBarUpdateForBarBackgroundAlpha:(CGFloat)barBackgroundAlpha;
- (void)setNeedsNavigationBarUpdateForTintColor:(UIColor *)tintColor;
- (void)setNeedsNavigationBarUpdateForTitleColor:(UIColor *)titleColor;
- (void)setNeedsNavigationBarUpdateForShadowImageHidden:(BOOL)hidden;
- (void)setNeedsNavigationBarUpdateForBarBackgroundImage:(UIImage *)backgroundImage;

@end

NS_ASSUME_NONNULL_END
