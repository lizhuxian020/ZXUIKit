//
//  ZXRequest.m
//  ZXUIKit
//
//  Created by Lee on 24/7/2018.
//  Copyright © 2018 Lee. All rights reserved.
//

#import "ZXRequest.h"
#import "ZXCoreRequest.h"

const NSString *RequestParam_loginId    = @"loginId";
const NSString *RequestParam_token      = @"token";

@interface ZXRequest()

@property(nonatomic, assign) BOOL showLoading;

@property(nonatomic, assign) BOOL combineCommonParam;

@property(nonatomic, assign) BOOL checkLogin;

@property(nonatomic, assign) BOOL checkData;

@property(nonatomic, copy) NSString *subURL;

@property(nonatomic, copy) NSDictionary *params;

@property(nonatomic, copy) finishCallback finishCallback;

@property(nonatomic, copy) errorCallback errorBLK;

@property(nonatomic, copy) finalCallback finalBLK;

@end

@implementation ZXRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.showLoading = YES;
        self.combineCommonParam = YES;
        self.checkLogin = YES;
    }
    return self;
}

- (void)startRequestWithResponse:(void(^)(NSDictionary *))responseDicBLK{
    //检查登录入参
    if (_checkLogin && ![self checkLoginValid]) {
        self.finalBLK();
        return;
    };
    //合并通用入参
    if (_combineCommonParam) {
        NSMutableDictionary *mDic = [NSMutableDictionary dictionaryWithDictionary:self.params];
        //TODO: 合并默认入参
//        [mDic setObject:kLoginId ? kLoginId : @"" forKey:RequestParam_loginId];
//        [mDic setObject:kToken_user ? kToken_user : @"" forKey:RequestParam_token];
        self.params = mDic.copy;
    }
    _showLoading ? [SVProgressHUD show] : nil;
    ZXCoreRequest *request = [ZXCoreRequest shareInstance];
    //这里不能用kself, 这里需要被YMRequest强引用!
    [request startRequestWithURL:self.subURL params:self.params finishCallback:^(NSDictionary *resDic, NSError *error) {
        self.showLoading ? [SVProgressHUD dismiss] : nil;
        void(^normalblock)(void) = ^{

            //只有code为"0000"才能执行finishCallback
            if (resDic && !error) {
                if (self.checkData &&( ![resDic.allKeys containsObject:@"data"] || (![resDic[@"data"] isKindOfClass:NSDictionary.class] && ![resDic[@"data"] isKindOfClass:NSArray.class]))) {
                    //TODO: 数据格式检测
                }
                self.finishCallback(resDic, @"000000");
                if (responseDicBLK) responseDicBLK(resDic);
                return;
            }

            //如果有dic, 则优先处理
            NSString *errorMessage, *errorCode;
            if (resDic) {
                errorMessage = resDic[@"message"];
                errorCode = resDic[@"code"];

                if (self.checkLogin) {
                    //这里统一处理登录CODE
                    if ([self isLoginCode:errorCode message:errorMessage]) return;
                }
            } else if (error) {
                //没有dic, 再看看error, 有则处理
                //不是ZX的CODE的ERROR, 返回提示信息
                switch (error.code) {
                    case NSURLErrorTimedOut: {
                        errorCode = (NSString *)ZXRequestErrorCode_Timeout;
                        errorMessage = @"网络连接超时";
                    }
                        break;
                    case NSURLErrorCannotConnectToHost:
                    case NSURLErrorBadServerResponse: {
                        errorCode = (NSString *)ZXRequestErrorCode_ConnectError;
                        errorMessage = @"网络连接失败";
                    }
                        break;
                    case NSURLErrorCannotDecodeContentData: {
                        errorCode = (NSString *)ZXRequestErrorCode_DecodeError;
                        errorMessage = @"数据解析失败";
                    }
                        break;
                    default: {
                        errorCode = (NSString *)ZXRequestErrorCode_UnknownError;
                        errorMessage = error.localizedDescription;
                    }
                        break;
                }
            } else {
                //没有dic, 也没有error ??
                errorCode = (NSString *)ZXRequestErrorCode_UnknownError;
                errorMessage = @"未知错误";
            }

            self.errorBLK(errorCode, errorMessage);
        };

        normalblock();
        self.finalBLK();
    }];
}

- (void)startRequest {
    [self startRequestWithResponse:nil];
}

- (BOOL)isLoginCode:(NSString *)code message:(NSString *)message {
    //会话过期，退出登录
    //TODO: 符合登录异常的逻辑
//    if ([code isEqualToString:@"10063"] ||
//        [code isEqualToString:@"10005"] ||
//        [code isEqualToString:@"10058"]) {
//        kShowToast(message);
//        //会话过期
//        [self noticeLoginInvalid];
//        return YES;
//    }
    return NO;
}

- (BOOL)checkLoginValid {
    //TODO: 是否登录已经失效
//    if ([kLoginId isEqualToString:@""] || !kLoginId || !kToken_user ||
//        [kToken_user isEqualToString:@""]) {
//        kShowToast(@"token失效");
//        [self noticeLoginInvalid];
//        return NO;
//    }
    return YES;
}

- (void)noticeLoginInvalid {
//    [[NSNotificationCenter defaultCenter]postNotificationName:TokenInvalid object:nil];
}


#pragma mark --BLOCK
- (ZXStringBlock)setSubURL {
    KSELF
    return ^(NSString *subURL) {
        kself.subURL = subURL;
        return kself;
    };
}

- (ZXDictionaryBlock)setParams {
    KSELF
    return ^(NSDictionary *params) {
        kself.params = params;
        return kself;
    };
}

- (ZXFinishCallbackBlock)setFinishCallback {
    KSELF
    return ^(finishCallback finishCallback){
        kself.finishCallback = finishCallback;
        return kself;
    };
}

- (ZXFinalErrorCallbackBlock)setErrorCallback {
    KSELF
    return ^(errorCallback errorBLK) {
        kself.errorBLK = errorBLK;
        return kself;
    };
}

- (ZXFinalCallbackBlock)setFinalCallback {
    KSELF
    return ^(finalCallback finalBLK) {
        kself.finalBLK = finalBLK;
        return kself;
    };
}

- (ZXBoolBlock)setShowLoading {
    KSELF
    return ^(BOOL flag) {
        kself.showLoading = flag;
        return kself;
    };
}

- (ZXBoolBlock)setCombineCommonParam {
    KSELF
    return ^(BOOL combineCommonParam) {
        kself.combineCommonParam = combineCommonParam;
        return kself;
    };
}

- (ZXBoolBlock)setCheckLogin {
    KSELF
    return ^(BOOL checkLogin) {
        kself.checkLogin = checkLogin;
        return kself;
    };
}

- (ZXBoolBlock)setCheckData {
    KSELF
    return ^(BOOL checkData) {
        kself.checkData = checkData;
        return kself;
    };
}


/**
 如果没有赋值, 则使用默认的Callback
 */
#pragma mark -- GET
- (finishCallback)finishCallback {
    if (_finishCallback) return _finishCallback;
    return ^(NSDictionary *resDic, NSString *resCode) {
        
    };
}

- (errorCallback)errorBLK {
    if (_errorBLK) return _errorBLK;
    return ^(NSString *errorCode, NSString *message) {
        kShowToast(message);
    };
}

- (finalCallback)finalBLK {
    if (_finalBLK) return _finalBLK;
    return ^{
        
    };
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
