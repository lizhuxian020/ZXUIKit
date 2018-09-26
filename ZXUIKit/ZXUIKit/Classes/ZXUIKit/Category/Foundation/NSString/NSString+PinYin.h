//
//  NSString+PinYin.h
//  ZXUIKit
//
//  Created by mac on 26/9/2018.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (PinYin)


/**
 按下标输出指定字符的首拼(测试通过)
 Source: https://blog.csdn.net/james_1010/article/details/18660929
 @param idx 下标
 @return 首拼
 */
- (char)pinyinIndex:(NSInteger)idx;

@end

NS_ASSUME_NONNULL_END
