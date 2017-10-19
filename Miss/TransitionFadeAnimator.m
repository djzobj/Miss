//
//  TransitionFadeAnimator.m
//  gjj51
//
//  Created by DJZ on 2017/9/22.
//  Copyright © 2017年 jianbing. All rights reserved.
//

#import "TransitionFadeAnimator.h"

@implementation TransitionFadeAnimator

-(void)presentAnimation{
    [self.contaionerView addSubview:self.toView];
    [self.contaionerView addSubview:self.fromView];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.fromView.alpha = 0;
    } completion:^(BOOL finished) {
        [self endAnimation];
    }];
}


@end
