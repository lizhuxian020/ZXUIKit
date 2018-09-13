//
//  ZXCoreRequest.h
//  ZXUIKit
//
//  Created by mac on 13/9/2018.
//

#import <Foundation/Foundation.h>

typedef void(^CoreRequest_CompleteBLK)(NSDictionary *responseDic, NSError *error);

@interface ZXCoreRequest : NSObject

+ (instancetype)shareInstance;

- (void)startRequestWithURL:(NSString *)url params:(NSDictionary *)params finishCallback:(CoreRequest_CompleteBLK)finishBlock;

@end
