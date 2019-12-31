//
//  ADTestTVC.m
//  ADNavigationBar_Example
//
//  Created by zhongaidong on 2019/12/31.
//  Copyright © 2019 goodswifter. All rights reserved.
//

#import "ADTestTVC.h"

@interface ADTestTVC ()

@end

@implementation ADTestTVC

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.rowHeight = 60;
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - System Delegate
#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"ADNavigationBar - %ld", indexPath.row];
    return cell;
}

@end
