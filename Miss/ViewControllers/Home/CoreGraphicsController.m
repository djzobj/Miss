//
//  CoreGraphicsController.m
//  Miss
//
//  Created by 张得军 on 2018/9/26.
//  Copyright © 2018年 djz. All rights reserved.
//

#import "CoreGraphicsController.h"
#import "GraphicsView.h"

@interface CoreGraphicsController ()

@end

@implementation CoreGraphicsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    GraphicsView *view = [GraphicsView new];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = self.view.bounds;
    [self.view addSubview:view];
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
