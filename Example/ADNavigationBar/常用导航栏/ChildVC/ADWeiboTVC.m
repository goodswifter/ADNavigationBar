//
//  ADWeiboTVC.m
//  ADNavigationBar_Example
//
//  Created by zhongaidong on 2019/12/31.
//  Copyright © 2019 goodswifter. All rights reserved.
//

#import "ADWeiboTVC.h"
#import "ADWeiboHeaderView.h"
#import "ADTestTVC.h"

#define HEADER_HEIGHT 220
#define NAV_HEIGHT 64
#define NAVBAR_COLORCHANGE_POINT (HEADER_HEIGHT - NAV_HEIGHT * 2)

@interface ADWeiboTVC () <UIScrollViewDelegate>
/// contentView
@property (nonatomic, strong) ADWeiboHeaderView *contentView;
/// TableView滑动offsetY
@property (nonatomic, assign) CGFloat offsetY;
@end

@implementation ADWeiboTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 修改默认的contentInset
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    // 设置初始导航栏透明度
    [self ad_setNavBarBackgroundAlpha:0];
    
    ADWeiboHeaderView *contentView = [ADWeiboHeaderView ad_viewFromXib];
    contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, HEADER_HEIGHT);
    contentView.autoresizingMask = UIViewAutoresizingNone;
    self.tableView.tableHeaderView = contentView;
    
    // 设置导航栏颜色
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//    [ADNavigationBar ad_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24]}];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_info_white"] style:UIBarButtonItemStylePlain target:self action:@selector(info)];
}

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self setupNavBar:self.offsetY];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self ad_setNavBarBackgroundAlpha:1];
    // 设置导航栏颜色
    [self ad_setNavBarBarTintColor:[UIColor greenColor]];
//    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    [self ad_setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)info {
    
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    self.offsetY = offsetY;
    [self setupNavBar:offsetY];
}

/// 根据offsetY设置导航栏相关颜色
/// @param offsetY TableView Y轴移动的距离
- (void)setupNavBar:(CGFloat)offsetY {
    if (offsetY > NAVBAR_COLORCHANGE_POINT) {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
        [self ad_setNavBarBackgroundAlpha:alpha];
        [self ad_setNavBarTintColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self ad_setNavBarTitleColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self ad_setNavBarBarTintColor:[UIColor redColor]];
        [self ad_setStatusBarStyle:UIStatusBarStyleDefault];
//        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
        self.title = @"我的";
    } else {
        [self ad_setNavBarBackgroundAlpha:0];
        [self ad_setNavBarTintColor:[UIColor whiteColor]];
        [self ad_setNavBarTitleColor:[UIColor whiteColor]];
        [self ad_setStatusBarStyle:UIStatusBarStyleLightContent];
//        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
        self.title = @"";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ADTestTVC *testTvc = [[ADTestTVC alloc] init];
    [self.navigationController pushViewController:testTvc animated:YES];
}

@end
