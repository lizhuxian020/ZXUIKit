//
//  CrashCatcher.h
//  ZXUIKit
//
//  Created by mac on 12/9/2018.
//

#import <Foundation/Foundation.h>

@interface CrashCatcher : NSObject

void uncaughtExceptionHandler(NSException *exception);

@end
