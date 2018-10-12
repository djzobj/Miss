//
//  UIViewController+Syn.h
//  Miss
//
//  Created by 张得军 on 2018/9/25.
//  Copyright © 2018年 djz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageButtonView : UIImageView{
    __weak id _object;
    SEL _sel;
}
@property(nonatomic,weak)UIBarButtonItem *item;
-(void)setTarget:(id)object action:(SEL)action;

@end

@interface TextButtonView : UILabel{
    __weak id _object;
    SEL _sel;
}
@property(nonatomic,weak)UIBarButtonItem *item;
-(void)setTarget:(id)object action:(SEL)action;

@end

@interface UIBarButtonItem (ImageButton)

-(UIBarButtonItem *)initWithImage:(UIImage*)image target:(id)object action:(SEL)action;
-(UIBarButtonItem *)initWithTitle:(NSString *)title fontSize:(CGFloat)size textColor:(UIColor*)color  target:(id)object action:(SEL)action;
@end

@interface UIViewController (Syn)

@property(nonatomic,retain)UIColor *backIconColor;
- (void)setupDefaultTheme;

@end
