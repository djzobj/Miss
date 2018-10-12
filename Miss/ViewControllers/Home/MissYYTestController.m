//
//  MissYYTestController.m
//  Miss
//
//  Created by 张得军 on 2018/9/25.
//  Copyright © 2018年 djz. All rights reserved.
//

#import "MissYYTestController.h"

@interface MissYYTestController () <UIScrollViewDelegate>
@end

@implementation MissYYTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self addUI];
}

- (void)addUI {

    UIView *navigationBar = [UIView new];
    [self.view addSubview:navigationBar];
    [navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(kNavigationBarHeight);
    }];
    
    UIImageView *backIcon = [UIImageView new];
    backIcon.userInteractionEnabled = YES;
    backIcon.backgroundColor = [UIColor red];
    [navigationBar addSubview:backIcon];
    [backIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.width.mas_equalTo(32);
        make.height.mas_equalTo(32);
        make.bottom.mas_equalTo(-6);
    }];
    
    YYLabel *label = [YYLabel new];
    label.numberOfLines = 2;
    label.preferredMaxLayoutWidth = kScreenWidth - 200;
    label.text = @"和加热反而俄日胡回去热会害人过去隔热胡国瑞分类取票机飞入㛑被告人还不饿";
    label.font = [UIFont systemFontOfSize:17];
    label.textColor = [UIColor darkGray];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(100);
        make.right.mas_equalTo(-100);
    }];
    NSLog(@"");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIViewController *controller = [NSClassFromString(@"MissYYTestController") new];
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    self.navigationController.delegate = nil;
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
