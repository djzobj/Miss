//
//  WXImgLoaderDefaultImpl.m
//  Miss
//
//  Created by DJZ on 2017/12/5.
//  Copyright © 2017年 djz. All rights reserved.
//

#import "WXImgLoaderDefaultImpl.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation WXImgLoaderDefaultImpl

-(id<WXImageOperationProtocol>)downloadImageWithURL:(NSString *)url imageFrame:(CGRect)imageFrame userInfo:(NSDictionary *)options completed:(void (^)(UIImage *, NSError *, BOOL))completedBlock{
    return (id<WXImageOperationProtocol>)[[SDWebImageManager sharedManager]loadImageWithURL:[NSURL URLWithString:url] options:0 progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        if (completedBlock) {
            
            completedBlock(image, error, finished);
            
        }
    }];
}

@end
