//
//  DJZNetworking.h
//  Miss
//
//  Created by 张得军 on 2018/4/2.
//  Copyright © 2018年 djz. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 成功回调
 *
 * @param response 成功后的返回数据
 */
typedef void(^DJZRresponseSuccessBlock)(id response);

/**
 * 失败回调
 *
 * @param error 失败后返回的错误信息
 */
typedef void(^DJZRresponseFailBlock)(NSError *error);

/**
 * 下载进度
 *
 * @param bytesRead 已下载的大小
 * @param totalBytes 总下载大小
 */
typedef void(^DJZDownloadProgressBlock)(int64_t bytesRead, int64_t totalBytes);

/**
 * 下载成功回调
 *
 * @param url 下载存放的路径
 */
typedef void(^DJZDownloadSuccessBlock)(NSURL *url);


typedef DJZDownloadProgressBlock DJZGetProgress;
typedef DJZDownloadProgressBlock DJZPostProgress;
typedef DJZRresponseFailBlock DJZDownloadDFailBlock;

@interface DJZNetworking : NSObject

+ (instancetype)shareInstance;

/**
 * 正在运行的网络任务
 */
- (NSArray *)currentRunningTasks;

/**
 * 配置请求头
 */
- (void)configHttpHeader:(NSDictionary *)httpHeader;

/**
 * 取消GET请求
 */
- (void)cancelRequestWithURL:(NSString *)url;

/**
 * 取消所有请求
 */
- (void)cancelAllRequest;

/**
 * GET请求
 *
 * @param url                请求路径
 * @param cache              是否缓存
 * @param params             参数
 * @param progressBlock      进度回调
 * @param successBlock       成功回调
 * @param failBlock          失败回调
 *
 * @return 返回的对象中可取消请求
 */

- (NSURLSessionTask *)getWithUrl:(NSString *)url cache:(BOOL)cache params:(NSDictionary *)params progressBlock:(DJZGetProgress)progressBlock successBlock:(DJZRresponseSuccessBlock)successBlock failBlock:(DJZRresponseFailBlock)failBlock;


/**
 * POST请求
 *
 * @param url                请求路径
 * @param cache              是否缓存
 * @param params             参数
 * @param progressBlock      进度回调
 * @param successBlock       成功回调
 * @param failBlock          失败回调
 *
 * @return 返回的对象中可取消请求
 */

- (NSURLSessionTask *)postWithUrl:(NSString *)url cache:(BOOL)cache params:(NSDictionary *)params progressBlock:(DJZGetProgress)progressBlock successBlock:(DJZRresponseSuccessBlock)successBlock failBlock:(DJZRresponseFailBlock)failBlock;

@end
