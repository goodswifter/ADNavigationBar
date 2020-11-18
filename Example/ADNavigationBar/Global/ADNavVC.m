//
//  ADNavVC.m
//  ADNavigationBar_Example
//
//  Created by 钟爱东 on 2019/12/30.
//  Copyright © 2019 goodswifter. All rights reserved.
//

#import "ADNavVC.h"

@interface ADNavVC ()

@end

@implementation ADNavVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置是 广泛使用ADNavigationBar, 还是局部使用ADNavigationBar, 目前默认是广泛使用
//    [ADNavigationBar ad_widely];
    // 设置导航栏默认的背景颜色
    [ADNavigationBar ad_setDefaultNavBarBarTintColor:[UIColor greenColor]];
    // 设置导航栏所有按钮的默认颜色
    [ADNavigationBar ad_setDefaultNavBarTintColor:[UIColor yellowColor]];
    // 设置导航栏标题默认颜色
    [ADNavigationBar ad_setDefaultNavBarTitleColor:[UIColor blueColor]];
    // 统一设置状态栏样式
    [ADNavigationBar ad_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
    // 如果需要设置导航栏底部分割线隐藏, 可以在这里统一设置
    [ADNavigationBar ad_setDefaultNavBarShadowImageHidden:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
