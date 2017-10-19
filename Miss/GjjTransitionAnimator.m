//
//  GjjTransitionAnimator.m
//  gjj51
//
//  Created by DJZ on 2017/9/21.
//  Copyright © 2017年 jianbing. All rights reserved.
//

#import "GjjTransitionAnimator.h"

@implementation GjjTransitionAnimator

#pragma mark -  Init Method

- (instancetype)init
{
    if (self = [super init])
    {
        [self setupDefaults];
    }
    
    return self;
}

// 设置默认参数
- (void)setupDefaults
{
    _duration = .5f;
    _style    = GjjTransitionAnimatorStylePresent;
}

/**
 *  开始动画，具体动画实现细节，由子类去实现
 */
- (void)beginAnimation
{
    switch (self.style)
    {
        case GjjTransitionAnimatorStylePresent:
        {
            [self presentAnimation];
            break;
        }
        case GjjTransitionAnimatorStyleDismiss:
        {
            [self dismissAnimation];
            break;
        }
    }
}

/**
 *  结束动画
 */
- (void)endAnimation
{
    [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
}

#pragma mark -  UIViewControllerAnimatedTransitioning

/**
 *  转场动画时间
 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}

/**
 *  动画的具体实现
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = fromViewController.view;
    UIView *toView   = toViewController.view;
    
    UIView *contaionerView = [transitionContext containerView];
    _transitionContext = transitionContext;
    
    _fromViewController = fromViewController;
    _toViewController   = toViewController;
    _fromView       = fromView;
    _toView         = toView;
    _contaionerView = contaionerView;
    
    /// 动画事件
    [self beginAnimation];
}


@end
