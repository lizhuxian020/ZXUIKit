//
//  ZXCommonTools.m
//  ZXUIKit
//
//  Created by mac on 13/9/2018.
//

#import "ZXCommonTools.h"

@implementation ZXCommonTools

+ (instancetype)shareTools {
    static ZXCommonTools *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[ZXCommonTools alloc] init];
    });
    return tool;
}

- (BOOL)isEmpty:(id)obj {
    if (!obj) return YES;
    if ([obj isKindOfClass:NSString.class]) {
        NSString *str = obj;
        return str.stringWithoutWhiteSpace.length <= 0;
    }
    if ([obj isKindOfClass:NSArray.class]) {
        NSArray *arr = obj;
        return arr.count <= 0;
    }
    if ([obj isKindOfClass:NSDictionary.class]) {
        NSDictionary *dic = obj;
        return [self isEmpty:dic.allKeys];
    }
    return NO;
}

- (NSRange)validateString:(NSString *)text regex:(NSString *)regexStr
{
    if (!regexStr || regexStr.length == 0) {
        return NSMakeRange(0, 0);
    }
    NSError *error;
    // 创建NSRegularExpression对象并指定正则表达式
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:regexStr
                                  options:0
                                  error:&error];
    if (!error) { // 如果没有错误
        // 获取特特定字符串的范围
        NSRange range = [regex rangeOfFirstMatchInString:text options:0 range:NSMakeRange(0, text.length)];
        if (range.location == NSNotFound) {
            return NSMakeRange(0, 0);
        }
        return range;
    } else { // 如果有错误，则把错误打印出来
        return NSMakeRange(0, 0);
    }
    
}
@end
