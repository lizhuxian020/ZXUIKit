//
//  ZXCoreRequest.m
//  ZXUIKit
//
//  Created by mac on 13/9/2018.
//

#import "ZXCoreRequest.h"

@implementation ZXCoreRequest

+ (instancetype)shareInstance {
    static ZXCoreRequest *request = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request = ZXCoreRequest.new;
    });
    return request;
}

- (void)startRequestWithURL:(NSString *)url params:(NSDictionary *)params finishCallback:(CoreRequest_CompleteBLK)finishCallback {
    //响应回调
    void (^responseBlock)(NSURLSessionDataTask *task, id responseObject, NSError *error) = ^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        
        finishCallback(responseObject, error);
        
    };
    //网络请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
////    [securityPolicy setValidatesDomainName:NO];
////    securityPolicy.allowInvalidCertificates = YES; //还是必须设成YES
//    manager.securityPolicy = securityPolicy;
    
    ZXLog(@"请求参数:url===>%@ \n parameters===>%@",url, [NSString JSONStringWithObject:params]);
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSString *json = [NSString JSONStringWithObject:responseObject];
        ZXLog(@" \n ================ responseObject_SUCCESS ================ \n%@",json);
        if (responseBlock) responseBlock(task, responseObject, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZXLog(@" \n ================ responseObject_ERROR ================ \n%@",error);
        if (responseBlock) responseBlock(task, nil, error);
    }];
}

@end
