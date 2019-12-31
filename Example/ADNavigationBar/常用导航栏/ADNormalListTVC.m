//
//  ADNormalListTVC.m
//  ADNavigationBar_Example
//
//  Created by zhongaidong on 2019/12/31.
//  Copyright © 2019 goodswifter. All rights reserved.
//

#import "ADNormalListTVC.h"
#import "ADCustomNavigationBar.h"
#import "ADWeiboTVC.h"
#import "ADQQTVC.h"
#import "ADQQZoneTVC.h"
#import "ADZhihuTVC.h"
#import "ADQQMineTVC.h"
#import "ADAntForestTVC.h"
#import "ADMultiHideNavTVC.h"
#import "ADLaGouTVC.h"
#import "ADSpecialVC.h"
#import "ADTestIQKeyVC.h"

@interface ADNormalListTVC () <UITableViewDelegate>
/// 控制器数组
@property (nonatomic, strong) NSArray *vcs;
@end

@implementation ADNormalListTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"常用";
    
    self.datas = @[@"新浪微博个人中心", @"类似qq应用空间效果", @"类似QQ空间效果", @"知乎日报", @"QQ我的资料页", @"蚂蚁森林", @"连续多个界面隐藏导航栏", @"拉钩App首页", @"WRNavigationBar 对其不产生任何印象", @"测试 IQKeyBoardManager 对其影响"];
    
    self.vcs = @[ADWeiboTVC.class, ADQQTVC.class, ADQQZoneTVC.class, ADZhihuTVC.class, ADQQMineTVC.class, ADAntForestTVC.class, ADMultiHideNavTVC.class, ADLaGouTVC.class, ADSpecialVC.class, ADTestIQKeyVC.class];
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row >= self.vcs.count) return;
    
    UIViewController *destVc = [self.vcs[indexPath.row] new];
//    destVc.title = self.datas[indexPath.row];
    
    [self.navigationController pushViewController:destVc animated:YES];
}

@end
