//
//  LogFormatter.h
//  ZXUIKit
//
//  Created by mac on 12/9/2018.
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelError;
#endif

@interface LogFormatter : NSObject<DDLogFormatter>

+(void)startLog;

@end
