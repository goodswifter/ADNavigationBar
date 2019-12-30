//
//  UINavigationBar+ADExtension.h
//  ADNavigationBar_Example
//
//  Created by zhongaidong on 2019/12/30.
//  Copyright © 2019 goodswifter. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (ADExtension)

/// 设置导航栏所有BarButtonItem的透明度
- (void)ad_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator;

/// 设置导航栏在垂直方向上平移多少距离
- (void)ad_setTranslationY:(CGFloat)translationY;

/// 获取当前导航栏在垂直方向上偏移了多少
- (CGFloat)ad_getTranslationY;

/// set navigationBar backgroundImage
- (void)ad_setBackgroundImage:(UIImage *)image;

/// set navigationBar barTintColor
- (void)ad_setBackgroundColor:(UIColor *)color;

/// set _UIBarBackground alpha (_UIBarBackground subviews alpha <= _UIBarBackground alpha)
- (void)ad_setBackgroundAlpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
