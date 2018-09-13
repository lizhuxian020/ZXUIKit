//
//  ZXUIKitManager.h
//  ZXUIKit
//
//  Created by mac on 13/9/2018.
//

#import <Foundation/Foundation.h>

@interface ZXUIKitManager : NSObject

@property(nonatomic, assign) BOOL logEnable;


+ (instancetype)shareManager;

@end
