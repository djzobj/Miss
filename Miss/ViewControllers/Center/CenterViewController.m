//
//  CenterViewController.m
//  Miss
//
//  Created by DJZ on 2017/12/5.
//  Copyright © 2017年 djz. All rights reserved.
//

#import "CenterViewController.h"

@interface CenterViewController () <UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"中心";
    [self.view addSubview:self.tableView];
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
