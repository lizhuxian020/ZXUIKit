//
//  NSArray+Swizzle.m
//  ZXUIKit
//
//  Created by mac on 12/9/2018.
//

#import "NSArray+Swizzle.h"
#import <objc/runtime.h>

@implementation NSArray (Swizzle)
// 没啥用啊!!=.=
+ (void) load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalM = class_getInstanceMethod(self, @selector(objectAtIndex:));
        Method swizzleM = class_getInstanceMethod(self, @selector(safe_objectAtIndex:));
        method_exchangeImplementations(originalM, swizzleM);
    });
    
}

- (void)swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector{
    
//    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(self, origSelector);
    Method swizzledMethod = class_getInstanceMethod(self, newSelector);
    
    method_exchangeImplementations(originalMethod, swizzledMethod);
    
    /**
     动态运行时给类添加方法
     
     class 需要添加方法的类
     origSelector 方法名
     swizzledMethod IMP 实现这个方法的函数
     表示添加方法成功与否
     */
//    BOOL didAddMethod = class_addMethod(self,
//                                        origSelector,
//                                        method_getImplementation(swizzledMethod),
//                                        method_getTypeEncoding(swizzledMethod));
//
//    if (didAddMethod) {
//
//        class_replaceMethod(self,
//                            newSelector,
//                            method_getImplementation(originalMethod),
//                            method_getTypeEncoding(originalMethod));
//    } else {
//        method_exchangeImplementations(originalMethod, swizzledMethod);
//    }
//
}

- (id)safe_objectAtIndex:(NSInteger)index{
    
    if (index < self.count) {
        
        return [self safe_objectAtIndex:index];
        
    }else {
        ///下标越界
        NSLog(@"数组下标越界");
        return nil;
        
    }
    
}

@end
