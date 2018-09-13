//
//  ZXRequest.h
//  ZXUIKit
//
//  Created by Lee on 24/7/2018.
//  Copyright © 2018 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

static const NSString *ZXRequestErrorCode_Timeout          = @"900001";
static const NSString *ZXRequestErrorCode_ConnectError     = @"900002";
static const NSString *ZXRequestErrorCode_DecodeError      = @"900003";
static const NSString *ZXRequestErrorCode_UnknownError     = @"999999";

typedef void(^finishCallback)();
typedef void(^errorCallback)();
typedef void(^finalCallback)(void);

@class ZXRequest;

typedef ZXRequest *(^ZXStringBlock)(NSString *);

typedef ZXRequest *(^ZXDictionaryBlock)(NSDictionary *);

typedef ZXRequest *(^ZXBoolBlock)(BOOL);

typedef ZXRequest *(^ZXFinishCallbackBlock)(finishCallback);

typedef ZXRequest *(^ZXFinalErrorCallbackBlock)(errorCallback);

typedef ZXRequest *(^ZXFinalCallbackBlock)(finalCallback);

@interface ZXRequest : NSObject

//----------- required -----------//

/**
 设置SubURL
 */
@property(nonatomic, copy, readonly) ZXStringBlock setSubURL;

/**
 设置入参
 */
@property(nonatomic, copy, readonly) ZXDictionaryBlock setParams;

/**
 设置完成block
 */
@property(nonatomic, copy, readonly) ZXFinishCallbackBlock setFinishCallback;


//----------- optional -----------//

/**
 对error的执行, 可以缺省, 默认showToast
 */
@property(nonatomic, copy, readonly) ZXFinalErrorCallbackBlock setErrorCallback;

/**
 设置最后执行的block(无论是否成功都会执行)
 */
@property(nonatomic, copy, readonly) ZXFinalCallbackBlock setFinalCallback;

/**
 设置是否显示loading, 默认YES
 */
@property(nonatomic, copy, readonly) ZXBoolBlock setShowLoading;

/**
 设置是否需要合并通用参数(loginId, token), 默认YES
 */
@property(nonatomic, copy, readonly) ZXBoolBlock setCombineCommonParam;

/**
 设置是否需要检测登录态, 默认YES
 */
@property(nonatomic, copy, readonly) ZXBoolBlock setCheckLogin;

/**
 设置是否需要检查Data字段
 */
@property(nonatomic, copy, readonly) ZXBoolBlock setCheckData;

/**
 开始请求
 */
- (void)startRequest;

@end
