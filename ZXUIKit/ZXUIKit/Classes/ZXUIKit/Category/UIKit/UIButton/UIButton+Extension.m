//
//  UIButton+Extension.m
//  ZXUIKit
//
//  Created by mac on 12/9/2018.
//

#import "UIButton+Extension.h"
#import <objc/runtime.h>

@implementation UIButton (Extension)

- (void)addAction:(ButtonBlock)block
{
    objc_setAssociatedObject(self, @selector(action:), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addAction:(ButtonBlock)block forControlEvents:(UIControlEvents)controlEvents
{
    objc_setAssociatedObject(self, @selector(action:), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(action:) forControlEvents:controlEvents];
}

- (void)action:(id)sender
{
    ButtonBlock blockAction = (ButtonBlock)objc_getAssociatedObject(self, _cmd);
    if (blockAction) blockAction(self);
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
