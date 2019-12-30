//
//  ADCustomNavigationBar.h
//  ADNavigationBar_Example
//
//  Created by zhongaidong on 2019/12/30.
//  Copyright © 2019 goodswifter. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ADCustomNavigationBar : UIView

@property (nonatomic, copy) void(^onClickLeftButton)(void);
@property (nonatomic, copy) void(^onClickRightButton)(void);

@property (nonatomic, copy)   NSString *title;
@property (nonatomic, strong) UIColor  *titleLabelColor;
@property (nonatomic, strong) UIFont   *titleLabelFont;
@property (nonatomic, strong) UIColor  *barBackgroundColor;
@property (nonatomic, strong) UIImage  *barBackgroundImage;

+ (instancetype)customNavigationBar;

- (void)ad_setBottomLineHidden:(BOOL)hidden;
- (void)ad_setBackgroundAlpha:(CGFloat)alpha;
- (void)ad_setTintColor:(UIColor *)color;

// 默认返回事件
//- (void)ad_setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted title:(NSString *)title titleColor:(UIColor *)titleColor;
//- (void)ad_setLeftButtonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor;
- (void)ad_setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted;
- (void)ad_setLeftButtonWithImage:(UIImage *)image;
- (void)ad_setLeftButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;

//- (void)ad_setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted title:(NSString *)title titleColor:(UIColor *)titleColor;
//- (void)ad_setRightButtonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor;
- (void)ad_setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted;
- (void)ad_setRightButtonWithImage:(UIImage *)image;
- (void)ad_setRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;

@end

NS_ASSUME_NONNULL_END
