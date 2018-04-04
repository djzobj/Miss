//
//  DJZNetworking.m
//  Miss
//
//  Created by 张得军 on 2018/4/2.
//  Copyright © 2018年 djz. All rights reserved.
//

#import "DJZNetworking.h"
#import <AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>

#define DJZ_ERROR [NSError errorWithDomain:@"com.hZB.ZBNetworking.ErrorDomain" code:-999 userInfo:@{ NSLocalizedDescriptionKey:@"网络出现错误，请检查网络连接"}]

#define TIMEOUT 30.0f
static NSMutableArray *requestTaskPool;
static NSDictionary   *headers;
static AFNetworkReachabilityStatus networkReachabilityStatus;

@implementation NSURLRequest (decide)

//判断是否是同一个请求（根据市请求url和参数是否相同）
- (BOOL)isTheSameRequest:(NSURLRequest *)request{
    if ([self.HTTPMethod isEqualToString:request.HTTPMethod]) {
        if ([self.URL.absoluteString isEqualToString:request.URL.absoluteString]) {
            if ([self.HTTPMethod isEqualToString:@"GET"] || [self.HTTPBody isEqualToData:request.HTTPBody]) {
                NSLog(@"同一个请求还没执行完，又来请求☹️");
                return YES;
            }
        }
    }
    return NO;
}


@end

@interface DJZNetworking ()
@property(nonatomic, assign)AFHTTPSessionManager *manager;
@end

@implementation DJZNetworking

+ (void)load{
    //开始监听网络
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        networkReachabilityStatus = status;
    }];
}

+ (instancetype)shareInstance{
    static DJZNetworking *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
        requestTaskPool = @[].mutableCopy;
    });
    return instance;
}

#pragma mark - manager
- (AFHTTPSessionManager *)maneger{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    if (!_manager) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        //默认解析模式
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        manager.requestSerializer.timeoutInterval = TIMEOUT;
        
        //配置响应序列化
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", @"application/octet-stream", @"application/zip"]];
        _manager = manager;
    }
    for (NSString *key in headers.allKeys) {
        if (headers[key] != nil) {
            [_manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
        }
    }
    return _manager;
}


#pragma mark - GET
- (NSURLSessionTask *)getWithUrl:(NSString *)url cache:(BOOL)cache params:(NSDictionary *)params progressBlock:(DJZGetProgress)progressBlock successBlock:(DJZRresponseSuccessBlock)successBlock failBlock:(DJZRresponseFailBlock)failBlock{
    
    AFHTTPSessionManager *manager = [self manager];
    __block NSURLSessionTask *session = nil;
    //网络验证
    if (networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        if (failBlock) {
            failBlock(DJZ_ERROR);
        }
        return session;
    }
    
   session = [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progressBlock) {
            progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BOOL isValid = [self networkResponseManage:responseObject];
        if (successBlock && isValid) {
            successBlock(responseObject);
        }
        [requestTaskPool removeObject:session];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        if (failBlock) {
            failBlock(error);
        }
        [requestTaskPool removeObject:session];
    }];
    //判断重复请求，如果有重复请求，取消新请求
    if ([self haveSameRequestInTaskPool:session]) {
        [session cancel];
        return session;
    }else{
        //无论是否有旧的请求，先执行取消就请求，反正都要刷新请求
        NSURLSessionTask *oldTask = [self cancelSameRequestInTaskPool:session];
        if (oldTask) {
            [requestTaskPool removeObject:oldTask];
        }
        if (session) {
            [requestTaskPool addObject:session];
        }
        [session resume];
        return session;
    }
    return session;
}

- (NSArray *)currentRunningTasks {
    return [requestTaskPool copy];
}


#pragma mark - 判断网络请求池中是否有相同的请求
- (BOOL)haveSameRequestInTaskPool:(NSURLSessionTask *)task{
    __block BOOL isSame = NO;
    [[self currentRunningTasks] enumerateObjectsUsingBlock:^(NSURLSessionTask *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.originalRequest isTheSameRequest:task.originalRequest]) {
            isSame = YES;
            *stop = YES;
        }
    }];
    return isSame;
}

#pragma mark - 如果有旧的请求则取消旧请求
- (NSURLSessionTask *)cancelSameRequestInTaskPool:(NSURLSessionTask *)task{
    __block NSURLSessionTask *oldTask = nil;
    [[self currentRunningTasks] enumerateObjectsUsingBlock:^(NSURLSessionTask *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.originalRequest isTheSameRequest:task.originalRequest]) {
            if (obj.state == NSURLSessionTaskStateRunning) {
                [obj cancel];
                oldTask = obj;
            }
            *stop = YES;
        }
    }];
    return oldTask;
}

#pragma mark - 网络回调统一处理
//网络回调统一处理
- (BOOL)networkResponseManage:(id)responseObject{
    NSData *data = nil;
    NSError *error = nil;
    if ([responseObject isKindOfClass:[NSData class]]) {
        data = responseObject;
    }else if ([responseObject isKindOfClass:[NSDictionary class]]){
        data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:&error];
    }
    //    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    //    NSLog(@"%@",json);
    
    //统一判断所有请求返回状态，例如：强制更新为6，若为6就返回YES，
    int stat = 0;
    switch (stat) {
        case -1:{//强制退出
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSLog(@"点击了取消");
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"重新登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSLog(@"点击了确定");
            }]];
            
            UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
            [rootViewController presentViewController:alert animated:YES completion:^{
                
            }];
            return NO;
        }
            break;
        case -2:{//强制更新
            return NO;
        }
            break;
        case -3:{//弹出对话框
            return NO;
        }
            break;
        default:
            break;
    }
    return YES;
}

@end
