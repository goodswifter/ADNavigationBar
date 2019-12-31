//
//  ADWeiboTVC.m
//  ADNavigationBar_Example
//
//  Created by zhongaidong on 2019/12/31.
//  Copyright © 2019 goodswifter. All rights reserved.
//

#import "ADWeiboTVC.h"
#import "ADWeiboHeaderView.h"

#define HEADER_HEIGHT 220
#define NAV_HEIGHT 64
#define NAVBAR_COLORCHANGE_POINT (HEADER_HEIGHT - NAV_HEIGHT * 2)

@interface ADWeiboTVC () <UIScrollViewDelegate>
/// contentView
@property (nonatomic, strong) ADWeiboHeaderView *contentView;
@end

@implementation ADWeiboTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)){
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    ADWeiboHeaderView *contentView = [ADWeiboHeaderView ad_viewFromXib];
    contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, HEADER_HEIGHT);
    contentView.autoresizingMask = UIViewAutoresizingNone;
    self.tableView.tableHeaderView = contentView;
    
    // 设置导航栏颜色
    [self ad_setNavBarBarTintColor:[UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0]];
    
    // 设置初始导航栏透明度
    [self ad_setNavBarBackgroundAlpha:0];
    
    // 设置导航栏按钮和标题颜色
    [self ad_setNavBarTintColor:[UIColor whiteColor]];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_COLORCHANGE_POINT) {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
        [self ad_setNavBarBackgroundAlpha:alpha];
        [self ad_setNavBarTintColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self ad_setNavBarTitleColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self ad_setStatusBarStyle:UIStatusBarStyleDefault];
        self.title = @"goodswifter";
    }
    else
    {
        [self ad_setNavBarBackgroundAlpha:0];
        [self ad_setNavBarTintColor:[UIColor whiteColor]];
        [self ad_setNavBarTitleColor:[UIColor whiteColor]];
        [self ad_setStatusBarStyle:UIStatusBarStyleLightContent];
        self.title = @"";
    }
}

@end
