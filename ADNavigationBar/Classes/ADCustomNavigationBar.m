//
//  ADCustomNavigationBar.m
//  ADNavigationBar_Example
//
//  Created by zhongaidong on 2019/12/30.
//  Copyright © 2019 goodswifter. All rights reserved.
//

#import "ADCustomNavigationBar.h"
#import "UIViewController+ADRoute.h"
#import "sys/utsname.h"

#define kWRDefaultTitleSize 18
#define kWRDefaultTitleColor [UIColor blackColor]
#define kWRDefaultBackgroundColor [UIColor whiteColor]
#define kWRScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ADCustomNavigationBar ()

@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UIButton    *leftButton;
@property (nonatomic, strong) UIButton    *rightButton;
@property (nonatomic, strong) UIView      *bottomLine;
@property (nonatomic, strong) UIView      *backgroundView;
@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation ADCustomNavigationBar

#pragma mark - Life Cycle


- (instancetype)init {
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

#pragma mark - Public Function
+ (instancetype)customNavigationBar {
    ADCustomNavigationBar *navigationBar = [[self alloc] initWithFrame:CGRectMake(0, 0, kWRScreenWidth, [ADCustomNavigationBar navBarBottom])];
    return navigationBar;
}

#pragma mark - Private Function
- (void)setupView {
    [self addSubview:self.backgroundView];
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.leftButton];
    [self addSubview:self.titleLabel];
    [self addSubview:self.rightButton];
    [self addSubview:self.bottomLine];
    [self updateFrame];
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView.backgroundColor = kWRDefaultBackgroundColor;
}

// TODO:这边结合 WRCellView 会不会更好呢？
- (void)updateFrame {
    NSInteger top = ([ADCustomNavigationBar isIphoneX]) ? 44 : 20;
    NSInteger margin = 0;
    NSInteger buttonHeight = 44;
    NSInteger buttonWidth = 44;
    NSInteger titleLabelHeight = 44;
    NSInteger titleLabelWidth = 180;

    self.backgroundView.frame = self.bounds;
    self.backgroundImageView.frame = self.bounds;
    self.leftButton.frame = CGRectMake(margin, top, buttonWidth, buttonHeight);
    self.rightButton.frame = CGRectMake(kWRScreenWidth - buttonWidth - margin, top, buttonWidth, buttonHeight);
    self.titleLabel.frame = CGRectMake((kWRScreenWidth - titleLabelWidth) / 2, top, titleLabelWidth, titleLabelHeight);
    self.bottomLine.frame = CGRectMake(0, (CGFloat)(self.bounds.size.height-0.5), kWRScreenWidth, 0.5);
}

#pragma mark - 导航栏左右按钮事件
- (void)clickBack {
    if (self.onClickLeftButton) {
        self.onClickLeftButton();
    } else {
        UIViewController *currentVC = [UIViewController ad_currentViewController];
        [currentVC ad_toLastViewController];
    }
}

- (void)clickRight {
    if (self.onClickRightButton) {
        self.onClickRightButton();
    }
}

- (void)ad_setBottomLineHidden:(BOOL)hidden {
    self.bottomLine.hidden = hidden;
}

- (void)ad_setBackgroundAlpha:(CGFloat)alpha {
    self.backgroundView.alpha = alpha;
    self.backgroundImageView.alpha = alpha;
    self.bottomLine.alpha = alpha;
}

- (void)ad_setTintColor:(UIColor *)color {
    [self.leftButton setTitleColor:color forState:UIControlStateNormal];
    [self.rightButton setTitleColor:color forState:UIControlStateNormal];
    [self.titleLabel setTextColor:color];
}

#pragma mark - 左右按钮
- (void)ad_setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted title:(NSString *)title titleColor:(UIColor *)titleColor {
    self.leftButton.hidden = NO;
    [self.leftButton setImage:normal forState:UIControlStateNormal];
    [self.leftButton setImage:highlighted forState:UIControlStateHighlighted];
    [self.leftButton setTitle:title forState:UIControlStateNormal];
    [self.leftButton setTitleColor:titleColor forState:UIControlStateNormal];
}

- (void)ad_setLeftButtonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor {
    [self ad_setLeftButtonWithNormal:image highlighted:image title:title titleColor:titleColor];
}

- (void)ad_setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted {
    [self ad_setLeftButtonWithNormal:normal highlighted:highlighted title:nil titleColor:nil];
}

- (void)ad_setLeftButtonWithImage:(UIImage *)image {
    [self ad_setLeftButtonWithNormal:image highlighted:image title:nil titleColor:nil];
}

- (void)ad_setLeftButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor {
    [self ad_setLeftButtonWithNormal:nil highlighted:nil title:title titleColor:titleColor];
}

- (void)ad_setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted title:(NSString *)title titleColor:(UIColor *)titleColor {
    self.rightButton.hidden = NO;
    [self.rightButton setImage:normal forState:UIControlStateNormal];
    [self.rightButton setImage:highlighted forState:UIControlStateHighlighted];
    [self.rightButton setTitle:title forState:UIControlStateNormal];
    [self.rightButton setTitleColor:titleColor forState:UIControlStateNormal];
}

- (void)ad_setRightButtonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor {
    [self ad_setRightButtonWithNormal:image highlighted:image title:title titleColor:titleColor];
}

- (void)ad_setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted {
    [self ad_setRightButtonWithNormal:normal highlighted:highlighted title:nil titleColor:nil];
}

- (void)ad_setRightButtonWithImage:(UIImage *)image {
    [self ad_setRightButtonWithNormal:image highlighted:image title:nil titleColor:nil];
}

- (void)ad_setRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor {
    [self ad_setRightButtonWithNormal:nil highlighted:nil title:title titleColor:titleColor];
}

#pragma mark - setter
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.hidden = NO;
    self.titleLabel.text = _title;
}

- (void)setTitleLabelColor:(UIColor *)titleLabelColor {
    _titleLabelColor = titleLabelColor;
    self.titleLabel.textColor = _titleLabelColor;
}

- (void)setTitleLabelFont:(UIFont *)titleLabelFont {
    _titleLabelFont = titleLabelFont;
    self.titleLabel.font = _titleLabelFont;
}

- (void)setBarBackgroundColor:(UIColor *)barBackgroundColor {
    self.backgroundImageView.hidden = YES;
    _barBackgroundColor = barBackgroundColor;
    self.backgroundView.hidden = NO;
    self.backgroundView.backgroundColor = _barBackgroundColor;
}

- (void)setBarBackgroundImage:(UIImage *)barBackgroundImage {
    self.backgroundView.hidden = YES;
    _barBackgroundImage = barBackgroundImage;
    self.backgroundImageView.hidden = NO;
    self.backgroundImageView.image = _barBackgroundImage;
}

#pragma mark - getter
- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] init];
        [_leftButton addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
        _leftButton.imageView.contentMode = UIViewContentModeCenter;
        _leftButton.hidden = YES;
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] init];
        [_rightButton addTarget:self action:@selector(clickRight) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.imageView.contentMode = UIViewContentModeCenter;
        _rightButton.hidden = YES;
    }
    return _rightButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = kWRDefaultTitleColor;
        _titleLabel.font = [UIFont systemFontOfSize:kWRDefaultTitleSize];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.hidden = YES;
    }
    return _titleLabel;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor colorWithRed:(CGFloat)(218.0/255.0) green:(CGFloat)(218.0/255.0) blue:(CGFloat)(218.0/255.0) alpha:1.0];
    }
    return _bottomLine;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
    }
    return _backgroundView;
}

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.hidden = YES;
    }
    return _backgroundImageView;
}

+ (int)navBarBottom {
    return 44 + ([self isIphoneX] ? 44 : 20);
}

+ (BOOL)isIphoneX {
    return ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) && ((int)([UIScreen mainScreen].bounds.size.width / [UIScreen mainScreen].bounds.size.height * 100) == 216 || (int)([UIScreen mainScreen].bounds.size.width / [UIScreen mainScreen].bounds.size.height * 100) == 46);
}


@end
