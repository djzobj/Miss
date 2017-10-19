//
//  GjjTransitionAnimator.h
//  gjj51
//
//  Created by DJZ on 2017/9/21.
//  Copyright © 2017年 jianbing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GjjTransitionAnimatorStyle)
{
    /// 显示：present
    GjjTransitionAnimatorStylePresent = 0,
    /// 消失：dismiss
    GjjTransitionAnimatorStyleDismiss
};

@interface GjjTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

#pragma mark - Public
/**  动画的样式：入栈、出栈  */
@property (assign, nonatomic) GjjTransitionAnimatorStyle style;
/**  动画执行的时间（默认为 0.3s）  */
@property (assign, nonatomic) NSTimeInterval duration;

#pragma mark -  Private

/**  转场的上下文  */
@property (weak, nonatomic, readonly) id<UIViewControllerContextTransitioning> transitionContext;
/** 源控制器 */
@property (weak, nonatomic, readonly) UIViewController *fromViewController;
/** 目标控制器 */
@property (weak, nonatomic, readonly) UIViewController *toViewController;
/**  源控制器的 view  */
@property (weak, nonatomic, readonly) UIView *fromView;
/**  目标控制器的 view  */
@property (weak, nonatomic, readonly) UIView *toView;
/** 进行动画过渡的场所 */
@property (weak, nonatomic, readonly) UIView *contaionerView;


/**
 *  开始动画，具体动画实现细节，由子类去实现
 */
- (void)beginAnimation;

/**
 *  结束动画
 */
- (void)endAnimation;

-(void)presentAnimation;

-(void)dismissAnimation;

@end
