//
//  UIButton+Extension.h
//  ZXUIKit
//
//  Created by mac on 12/9/2018.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonBlock)(UIButton* btn);

@interface UIButton (Extension)

- (void)addAction:(ButtonBlock)block;
- (void)addAction:(ButtonBlock)block forControlEvents:(UIControlEvents)controlEvents;

@end
