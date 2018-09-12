//
//  NSString+Extension.h
//  ZXUIKit
//
//  Created by mac on 12/9/2018.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/**
 校验: 手机号码
 */
- (BOOL)isMobileNumber;
/**
 校验: 邮箱
 */
- (BOOL)isEmail;

/**
 校验: 身份证号码
 */
- (BOOL)isIDCard;

/**
 获取JSON
 
 @param obj NSArray | NSDictionary
 */
+ (NSString *)JSONStringWithObject:(id)obj;

/**
 去掉空格
 */
- (NSString *)stringWithoutWhiteSpace;

/**
 根据给定字体大小和宽度, 返回Size
 
 @param font 字体大小
 @param width 宽度
 @return 返回大小
 */
-(CGSize)stringheightWithFont:(UIFont *)font andWidth:(CGFloat)width;

/**
 手机号添加掩码: *
 */
-(NSString *)securePhoneNumber;

/**
 银行卡号码隐藏处理(加星号处理)
 */
-(NSString *)secureBankCardNumber;

/**
 身份证号码隐藏处理(加星号处理)显示前6位
 */
-(NSString *)secureIDCardNumber;

/**
 MD5加密
 */
- (NSString *)md5String;

- (NSString *)aesString;

// 获取字符串的字节长
- (NSUInteger)getBytesLength;

// URL编码
- (NSString *)urlInURLEncoding;
@end
