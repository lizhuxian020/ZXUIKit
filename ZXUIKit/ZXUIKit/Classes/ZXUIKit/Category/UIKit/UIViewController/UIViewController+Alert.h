//
//  UIViewController+Alert.h
//  ZXUIKit
//
//  Created by mac on 12/9/2018.
//

#import <UIKit/UIKit.h>

typedef void(^ActionHanlder)(UIAlertAction *action);
@interface UIAlertAction (ZX)
/* 分类添加index属性**/
@property (strong, nonatomic) NSNumber *index;
@end

@interface UIViewController (Alert)

- (void)alertWithTitle:(NSString *)title message:(NSString *)message actionTitles:(NSArray *)actionTitles actionHandler:(ActionHanlder)handler;

@end
