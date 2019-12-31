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
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
