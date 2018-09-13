//
//  ZXUIKitManager.m
//  ZXUIKit
//
//  Created by mac on 13/9/2018.
//

#import "ZXUIKitManager.h"
#import "LogFormatter.h"

@implementation ZXUIKitManager

+ (instancetype)shareManager {
    static ZXUIKitManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = ZXUIKitManager.new;
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self networkStatusChangeAFN];
//        !_logEnable ?: [LogFormatter startLog];
        [LogFormatter startLog];
    }
    return self;
}

-(void)networkStatusChangeAFN
{
    //1.获得一个网络状态监听管理者
    AFNetworkReachabilityManager *manager =  [AFNetworkReachabilityManager sharedManager];
    
    //2.监听状态的改变(当网络状态改变的时候就会调用该block)
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        /*
         AFNetworkReachabilityStatusUnknown          = -1,  未知
         AFNetworkReachabilityStatusNotReachable     = 0,   没有网络
         AFNetworkReachabilityStatusReachableViaWWAN = 1,    3G|4G
         AFNetworkReachabilityStatusReachableViaWiFi = 2,   WIFI
         */
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"3G|4G");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知");
                break;
                
            default:
                break;
        }
    }];
    
    //3.手动开启 开始监听
    [manager startMonitoring];
}

@end
