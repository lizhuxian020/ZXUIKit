//
//  NSString+Compare.m
//  ZXUIKit
//
//  Created by mac on 26/9/2018.
//

#import "NSString+Compare.h"

@implementation NSString (Compare)

- (NSComparisonResult)strokeCompare:(NSString *)anthorString {
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh@collation=stroke"];
    return [self compare:anthorString options:NSCaseInsensitiveSearch range:NSMakeRange(0, self.length) locale:locale];
}

@end
