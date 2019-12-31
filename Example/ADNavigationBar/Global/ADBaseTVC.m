//
//  ADBaseTVC.m
//  ADNavigationBar_Example
//
//  Created by zhongaidong on 2019/12/31.
//  Copyright © 2019 goodswifter. All rights reserved.
//

#import "ADBaseTVC.h"

@interface ADBaseTVC () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ADBaseTVC

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 66;
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - System Delegate
#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = self.datas[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Getter and Setter
- (void)setDatas:(NSArray<NSString *> *)datas {
    _datas = datas;
    
    [self.tableView reloadData];
}

@end
