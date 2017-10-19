//
//  TransitionBubbleAnimator.h
//  gjj51
//
//  Created by DJZ on 2017/9/21.
//  Copyright © 2017年 jianbing. All rights reserved.
//

#import "GjjTransitionAnimator.h"

@interface TransitionBubbleAnimator : GjjTransitionAnimator

/**  动画开始的frame  */
@property (assign, nonatomic) CGRect sourceRect;

/**  填充颜色  */
@property (strong, nonatomic) UIColor *strokeColor;

@end
