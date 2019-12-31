//
//  ADCustomListTVC.m
//  ADNavigationBar_Example
//
//  Created by zhongaidong on 2019/12/31.
//  Copyright © 2019 goodswifter. All rights reserved.
//

#import "ADCustomListTVC.h"

@interface ADCustomListTVC ()

@end

@implementation ADCustomListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"自定义";
    
    self.datas = @[@"主页", @"导航栏显示图片", @"实现导航栏渐变色的另一种方式"];
}

@end
