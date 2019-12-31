//
//  ADMoveListTVC.m
//  ADNavigationBar_Example
//
//  Created by zhongaidong on 2019/12/31.
//  Copyright © 2019 goodswifter. All rights reserved.
//

#import "ADMoveListTVC.h"

@interface ADMoveListTVC ()

@end

@implementation ADMoveListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"移动导航栏";
    
    self.datas = @[@"超过临界点移动导航栏", @"没有系统返回按钮的情况"];
}

@end
