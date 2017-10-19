//
//  GjjPresentation.h
//  gjj51
//
//  Created by DJZ on 2017/9/21.
//  Copyright © 2017年 jianbing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GjjTransitionAnimator.h"

@interface GjjPresentation : UIPresentationController


/**
 *  显示一个 弹框视图控制器
 *
 *  @param presentationAnimation    动画类
 *  @param presentedViewController  目标控制器（最终要展示的控制器）
 *  @param presentingViewController 源控制器（是从哪个控制器推出的
 */
+ (void)presentWithPresentationAnimation:(GjjTransitionAnimator *)presentationAnimation
                 presentedViewController:(UIViewController *)presentedViewController
                presentingViewController:(UIViewController *)presentingViewController;

@end
