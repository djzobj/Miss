//
//  ViewController.m
//  Miss
//
//  Created by DJZ on 2017/8/31.
//  Copyright © 2017年 djz. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>
#import "BViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doOpen)];
    [self.view addGestureRecognizer:tap];
}

-(void)doOpen{
    UIViewController *controller = [[BViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)drawText{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.view.bounds.size.height);
    CGContextScaleCTM(context, 0, -1);
    
    //回调指针
    CTRunDelegateCallbacks callbacks;
    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));
    callbacks.version = kCTRunDelegateVersion1;
    callbacks.getAscent = ascentCallback;
    callbacks.getDescent = decentCallback;
    callbacks.getWidth = widthCallback;
    
    NSDictionary *iconInfo = @{@"width":@100,@"height":@30};
    
    //设置ctrun的代理
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, (__bridge void *)(iconInfo));
    unichar replacementChar = 0xFFFC;
    NSString *icon = [NSString stringWithCharacters:&replacementChar length:1];
    NSMutableAttributedString *space = [[NSMutableAttributedString alloc] initWithString:icon];
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)space, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
    CFRelease(delegate);
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, self.view.bounds);
    
    NSMutableAttributedString *aa = [[NSMutableAttributedString alloc]initWithString:@""];
    [aa insertAttributedString:space atIndex:0];
    
    
    
    CTFramesetterRef framesetterRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)aa);
    
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetterRef, CFRangeMake(0, aa.length), path, NULL);
    
    CTFrameDraw(frameRef, context);
    
    CFRelease(framesetterRef);
    CFRelease(frameRef);
    CFRelease(path);
}

-(CGRect)caculateIconCTFrame:(CTFrameRef)ctframe{
    NSArray *lines = (NSArray *)CTFrameGetLines(ctframe);
    NSInteger lineCount = lines.count;
    CGPoint lineOrigins[lineCount];
    CTFrameGetLineOrigins(ctframe, CFRangeMake(0, 0), lineOrigins);
    
    for (NSInteger i = 0; i < lineCount; i++) {
        CTLineRef line = (__bridge CTLineRef)lines[i];
        NSArray *runs = (NSArray *)CTLineGetGlyphRuns(line);
        
        for (int j = 0; j < runs.count; j++) {
            CTRunRef run = (__bridge CTRunRef)runs[j];
            NSDictionary *runAttributr = (NSDictionary *)CTRunGetAttributes(run);
            CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)runAttributr[(id)kCTRunDelegateAttributeName];
            if (!delegate) {
                continue;
            }
            NSDictionary *mateDic = CTRunDelegateGetRefCon(delegate);
            if (![mateDic isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            CGRect runBounds;
            CGFloat ascent;
            CGFloat descent;
            
            runBounds.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
            runBounds.size.height = ascent + descent;
            
            CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
            runBounds.origin.x = lineOrigins[i].x + xOffset;
            runBounds.origin.y = lineOrigins[i].y;
            runBounds.origin.y -= descent;
            
            CGPathRef pathRef = CTFrameGetPath(ctframe);
            CGRect colRect = CGPathGetBoundingBox(pathRef);
            
            CGRect delegateBounds = CGRectOffset(runBounds, colRect.origin.x, colRect.origin.y);
            return delegateBounds;
        }
    }
    return CGRectZero;
}

static CGFloat ascentCallback(void *ref){
    return [[(__bridge NSDictionary *)ref objectForKey:@"height"] floatValue];
}

static CGFloat decentCallback(void *ref){
    return 0;
}

static CGFloat widthCallback(void *ref){
     return [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"width"] floatValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
