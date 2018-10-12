//
//  UIViewController+Syn.m
//  Miss
//
//  Created by 张得军 on 2018/9/25.
//  Copyright © 2018年 djz. All rights reserved.
//

#import "UIViewController+Syn.h"
#import <objc/runtime.h>

@implementation ImageButtonView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [UIView animateWithDuration:.2
                     animations:^{
                         self.alpha = .3;
                     }];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [UIView animateWithDuration:.2
                     animations:^{
                         self.alpha = 1;
                     }];
    if(_object && [_object respondsToSelector:_sel]){
        [_object performSelector:_sel withObject:self.item];
    }
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    [UIView animateWithDuration:.2
                     animations:^{
                         self.alpha = 1;
                     }];
}

-(void)setTarget:(id)object action:(SEL)action{
    _object = object;
    _sel = action;
}

@end


@implementation TextButtonView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [UIView animateWithDuration:.2
                     animations:^{
                         self.alpha = .3;
                     }];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [UIView animateWithDuration:.2
                     animations:^{
                         self.alpha = 1;
                     }];
    if(_object && [_object respondsToSelector:_sel]){
        [_object performSelector:_sel withObject:self.item];
    }
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    [UIView animateWithDuration:.2
                     animations:^{
                         self.alpha = 1;
                     }];
}

-(void)setTarget:(id)object action:(SEL)action{
    _object = object;
    _sel = action;
}

@end

@implementation UIBarButtonItem (ImageButton)

+(void)load{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        Method _new_setImage = class_getInstanceMethod(self, @selector(_new_setImage:));
        Method setImage = class_getInstanceMethod(self, @selector(setImage:));
        method_exchangeImplementations(_new_setImage, setImage);
    });
}

-(UIBarButtonItem *)initWithImage:(UIImage *)image target:(id)object action:(SEL)action{
    ImageButtonView *button = [[ImageButtonView alloc] initWithImage:image];
    [button setTarget:object action:action];
    UIBarButtonItem *result = [self initWithCustomView:button];
    button.item = result;
    return result;
}

-(UIBarButtonItem *)initWithTitle:(NSString *)title fontSize:(CGFloat)size textColor:(UIColor*)color  target:(id)object action:(SEL)action{
    TextButtonView *button = [[TextButtonView alloc] init];
    button.userInteractionEnabled = YES;
    button.font = [UIFont systemFontOfSize:size];
    button.textColor = color;
    button.text = title;
    button.frame = (CGRect){.origin=CGPointZero,.size=[title sizeWithAttributes:@{NSFontAttributeName:button.font}]};
    [button setTarget:object action:action];
    UIBarButtonItem *result = [self initWithCustomView:button];
    button.item = result;
    return result;
}

-(void)_new_setImage:(UIImage *)image{
    [self _new_setImage:image];
    if ([self.customView isKindOfClass:[ImageButtonView class]]) {
        ((ImageButtonView*)self.customView).image = image;
    }
}

@end

@implementation UIViewController (Syn)

+(void)load{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        Method _new_viewWillAppear = class_getInstanceMethod(self, @selector(_new_viewWillAppear:));
        Method viewWillAppear = class_getInstanceMethod(self, @selector(viewWillAppear:));
        method_exchangeImplementations(_new_viewWillAppear, viewWillAppear);
    });
}

-(void)_new_viewWillAppear:(BOOL)animated{
    [self _new_viewWillAppear:animated];
    
    if(self.navigationController){
        NSArray<UIViewController*> *viewControllers = self.navigationController.viewControllers;
        if (viewControllers.count>1) {
            UIColor *backIconColor = viewControllers[viewControllers.count-2].backIconColor;
            if (backIconColor) {
                self.backIconColor = backIconColor;
            }
        }
    }
}

static char s_cColorKey;

-(void)setBackIconColor:(UIColor *)color{
    objc_setAssociatedObject(self, &s_cColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if(self.navigationController.viewControllers.count<=1){
    }else{
        [self setupBackIcon:color];
    }
}

-(void)setupBackIcon:(UIColor*)color{
    UIImage *destImage = [self imageWithPath:@"ico_title_back" color:color];
    ImageButtonView *button = [[ImageButtonView alloc] initWithImage:destImage];
    [button setTarget:self action:@selector(doBack)];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    buttonItem.accessibilityIdentifier = @"backImage";
    buttonItem.image = destImage;
    buttonItem.tintColor = color;
    self.navigationItem.leftBarButtonItem = buttonItem;
}

-(UIColor *)backIconColor{
    return objc_getAssociatedObject(self, &s_cColorKey);
}

-(void)setupDefaultTheme{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor darkGray]};
    self.backIconColor = [UIColor miss_colorWithRGB:@"#333"];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
}

- (void)doBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIImage*)imageWithPath:(NSString*)imageStr color:(UIColor*)color {
    CGFloat r=0,g=0,b=0;
    [color getRed:&r green:&g blue:&b alpha:NULL];
    UIImage* sourceImage = [UIImage imageNamed:imageStr];
    CGImageRef imageRef = [sourceImage CGImage];
    CGFloat width = CGImageGetWidth(imageRef);
    CGFloat height = CGImageGetHeight(imageRef);
    
    CGDataProviderRef provider = CGImageGetDataProvider(imageRef);
    CFDataRef dataRef = CGDataProviderCopyData(provider);
    
    const UInt8 *sourceData = (UInt8 *)CFDataGetBytePtr(dataRef);
    UInt8 *destData = (UInt8*)calloc(width*height*4, sizeof(UInt8));
    
    for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
            int index = (i*width*4) + (j*4);
            if (sourceData[index+3]!=0) {
                UInt8 *p = (UInt8*)sourceData+index;
                UInt8 *q = destData+index;
                *q = *p*r;
                p++;q++;
                *q = *p*g;
                p++;q++;
                *q = *p*b;
                p++;q++;
                *q = *p;
            }
        }
    }
    int bytes_per_pix = 4;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef newContext = CGBitmapContextCreate(destData,
                                                    width, height, 8,
                                                    width * bytes_per_pix,
                                                    colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    CGImageRef destImageRef = CGBitmapContextCreateImage(newContext);
    UIImage *image = [UIImage imageWithCGImage:destImageRef scale:sourceImage.scale orientation:UIImageOrientationUp];
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(newContext);
    CGImageRelease(destImageRef);
    CFRelease(dataRef);
    free(destData);
    return image;
}

- (UIImage *)imageWithImage:(UIImage *)image alpha:(CGFloat)alpha backgroundColor:(UIColor*)color{
    CGFloat red, green, blue;
    
    [color getRed: &red
            green: &green
             blue: &blue
            alpha: NULL];
    // Create a pixel buffer in an easy to use format
    CGImageRef imageRef = [image CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    UInt8 * m_PixelBuf = malloc(sizeof(UInt8) * height * width * 4);
    NSUInteger length = height * width * 4;
    for(int i=0;i<length;i++){
        m_PixelBuf[i]=0;
    }
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(m_PixelBuf, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    //alter the alpha
    for (int i=0; i<length; i+=4){
        if (color) {
            if (m_PixelBuf[i+3]==0) {
                continue;
            }
            m_PixelBuf[i] = m_PixelBuf[i]*alpha + 255*red*(1-alpha);
            m_PixelBuf[i+1] = m_PixelBuf[i+1]*alpha + 255*green*(1-alpha);
            m_PixelBuf[i+2] = m_PixelBuf[i+2]*alpha + 255*blue*(1-alpha);
        }else{
            m_PixelBuf[i+3] = m_PixelBuf[i+3] * alpha;
        }
    }
    
    //create a new image
    CGContextRef ctx = CGBitmapContextCreate(m_PixelBuf, width, height,
                                             bitsPerComponent, bytesPerRow, colorSpace,
                                             kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGImageRef newImgRef = CGBitmapContextCreateImage(ctx);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(ctx);
    free(m_PixelBuf);
    UIImage *finalImage = [UIImage imageWithCGImage:newImgRef];
    CGImageRelease(newImgRef);
    finalImage = [[UIImage alloc]initWithCGImage:finalImage.CGImage scale:finalImage.size.width/image.size.width orientation:UIImageOrientationUp];
    finalImage = [finalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return finalImage;
}

@end
