//
//  GraphicsView.m
//  Miss
//
//  Created by 张得军 on 2018/9/26.
//  Copyright © 2018年 djz. All rights reserved.
//

#import "GraphicsView.h"

@implementation GraphicsView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor red] setFill];
    CGContextSaveGState(context);
    [[UIColor yellowColor] setFill];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 70, 70)];
    [path fill];
    CGContextRestoreGState(context);
    
    path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(200, 50, 70, 70)];
    [path fill];
}

@end
