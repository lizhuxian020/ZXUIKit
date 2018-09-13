//
//  ZXCommonTools.h
//  ZXUIKit
//
//  Created by mac on 13/9/2018.
//

#import <Foundation/Foundation.h>

#define CommonTools [ZXCommonTools shareTools]
#define kIsEmpty(obj) [CommonTools isEmpty:obj]

@interface ZXCommonTools : NSObject

/**
 返回单例对象
 */
+ (instancetype)shareTools;


/**
 检查是否为空
 
 @param obj NSString, NSArray, NSDictionary
 @return result
 */
- (BOOL)isEmpty:(id)obj;

/**
 输入文本和正则文本, 返回第一个符合正则的文本range, 没找到返回range(0,0)
 
 @param text 待测文本
 @param regexStr 正则文本
 @return range
 */
- (NSRange)validateString:(NSString *)text regex:(NSString *)regexStr;
@end
