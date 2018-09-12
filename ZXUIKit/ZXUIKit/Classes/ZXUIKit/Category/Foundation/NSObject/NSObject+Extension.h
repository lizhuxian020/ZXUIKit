//
//  NSObject+Extension.h
//  ZXUIKit
//
//  Created by mac on 12/9/2018.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)

/**
 *  是否为空:
 *  字符串: nil, "", "  "
 *  数组: nil, @[]
 *  字典: nil, @{}
*/
- (BOOL)isEmpty;

@end
