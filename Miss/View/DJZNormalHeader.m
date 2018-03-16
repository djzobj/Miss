//
//  DJZNormalHeader.m
//  Miss
//
//  Created by DJZ on 2018/3/2.
//  Copyright © 2018年 djz. All rights reserved.
//

#import "DJZNormalHeader.h"

@implementation DJZNormalHeader

-(void)prepare{
    [super prepare];
    
    //自定义
    [self setTitle:@"普通闲置状态" forState:MJRefreshStateIdle];
    [self setTitle:@"松开就可以进行刷新的状态" forState:MJRefreshStatePulling];
    [self setTitle:@"正在刷新中的状态" forState:MJRefreshStateRefreshing];
    [self setTitle:@"即将刷新的状态" forState:MJRefreshStateWillRefresh];
    [self setTitle:@"所有数据加载完毕，没有更多的数据了" forState:MJRefreshStateNoMoreData];
    
    //一些其他属性设置
    //设置字体
    self.stateLabel.font = [UIFont systemFontOfSize:15];
    self.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:15];
    
    // 设置颜色
    self.stateLabel.textColor = [UIColor redColor];
    self.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
//    // 隐藏时间
//    self.lastUpdatedTimeLabel.hidden = YES;
//    // 隐藏状态
//    self.stateLabel.hidden = YES;
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.automaticallyChangeAlpha = YES;
}

@end
