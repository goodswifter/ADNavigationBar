//
//  AppDelegate.m
//  ADNavigationBar
//
//  Created by goodswifter on 12/30/2019.
//  Copyright (c) 2019 goodswifter. All rights reserved.
//

#import "AppDelegate.h"
#import "ADNavVC.h"
#import "ADNormalListTVC.h"
#import "ADCustomListTVC.h"
#import "ADMoveListTVC.h"
#import "ADNavigationBarHeader.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UITabBarController *tabBarVc = [[UITabBarController alloc] init];
    // 设置子控制器
    [self setupTabBarVCs:tabBarVc];
    // 设置TabBar的items
    [self setupTabBarItems:tabBarVc];
    
    self.window.rootViewController = tabBarVc;
    
    // 设置NavBar属性
    [self setupNavBarAppearence];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - Private Function
- (void)setupTabBarVCs:(UITabBarController *)tabBarVc {
    NSArray *childVcs = @[ADNormalListTVC.class, ADCustomListTVC.class, ADMoveListTVC.class];
    
    NSMutableArray *vcs = [NSMutableArray array];
    [childVcs enumerateObjectsUsingBlock:^(Class obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ADNavVC *navVc = [[ADNavVC alloc] initWithRootViewController:[obj new]];
        [vcs addObject:navVc];
    }];
    
    tabBarVc.viewControllers = vcs;
}

- (void)setupTabBarItems:(UITabBarController *)tabBarVc {
    NSArray *titles = @[@"常用导航栏", @"自定义导航栏", @"移动导航栏"];
    NSArray *normalImages = @[@"mine", @"mine", @"mine"];
    NSArray *highlightImages = @[@"mine_h", @"mine_h", @"mine_h"];
    [tabBarVc.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.title = titles[idx];
        obj.image = [[UIImage imageNamed:normalImages[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        obj.selectedImage = [[UIImage imageNamed:highlightImages[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }];
}

- (void)setupNavBarAppearence {
    // 正常设置
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor purpleColor]}];
//    [UINavigationBar appearance].tintColor = [UIColor yellowColor];
//    [UINavigationBar appearance].barTintColor = [UIColor redColor];
    
    // 设置是 广泛使用ADNavigationBar, 还是局部使用ADNavigationBar, 目前默认是广泛使用
    [ADNavigationBar ad_widely];
//    [UINavigationBar ad_setBlacklist:@[@"SpecialController",
//                                       @"TZPhotoPickerController",
//                                       @"TZGifPhotoPreviewController",
//                                       @"TZAlbumPickerController",
//                                       @"TZPhotoPreviewController",
//                                       @"TZVideoPlayerController"]];
    
    // 设置导航栏默认的背景颜色
    [ADNavigationBar ad_setDefaultNavBarBarTintColor:[UIColor redColor]];
    // 设置导航栏所有按钮的默认颜色
    [ADNavigationBar ad_setDefaultNavBarTintColor:[UIColor yellowColor]];
    // 设置导航栏标题默认颜色
    [ADNavigationBar ad_setDefaultNavBarTitleColor:[UIColor greenColor]];
    // 统一设置状态栏样式
    [ADNavigationBar ad_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
    // 如果需要设置导航栏底部分割线隐藏, 可以在这里统一设置
    [ADNavigationBar ad_setDefaultNavBarShadowImageHidden:YES];
}

@end
