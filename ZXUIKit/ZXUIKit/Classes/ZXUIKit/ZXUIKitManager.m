//
//  ZXUIKitManager.m
//  ZXUIKit
//
//  Created by mac on 13/9/2018.
//

#import "ZXUIKitManager.h"

@implementation ZXUIKitManager

+ (instancetype)shareManager {
    static ZXUIKitManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = ZXUIKitManager.new;
    });
    return manager;
}

@end
