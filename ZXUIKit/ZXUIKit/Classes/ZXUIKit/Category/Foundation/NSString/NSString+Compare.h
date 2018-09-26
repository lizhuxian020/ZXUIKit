//
//  NSString+Compare.h
//  ZXUIKit
//
//  Created by mac on 26/9/2018.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Compare)


/**
 比较字符串的笔画(测试失败=.=)
 Source: KKBox-iOS-dev.pdf
 @param anthorString 比较对象
 @return 比较结果
 */
- (NSComparisonResult)strokeCompare:(NSString *)anthorString;

@end

NS_ASSUME_NONNULL_END
