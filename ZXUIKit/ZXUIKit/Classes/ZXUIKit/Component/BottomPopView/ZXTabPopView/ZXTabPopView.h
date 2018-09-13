//
//  ZXTabPopView.h
//  ZXUIKit
//
//  Created by Lee on 15/8/2018.
//  Copyright © 2018 Lee. All rights reserved.
//

#import "ZXCoreBottomView.h"

typedef NS_ENUM(NSInteger, ZXTabPopViewType) {
    ZXTabPopViewType_Normal,
    ZXTabPopViewType_TextField
    
};

/**
 标签选择PopView
 */
@interface ZXTabPopView : ZXCoreBottomView

@property(nonatomic, strong) NSArray *texts;

/**
 tab可以多选, 则ClickLeftLBL和ClickRightLbl返回NSArray<NSString *>
 默认NO
 */
@property(nonatomic, assign) BOOL canMultipleSelect;


/**
 初始化方法

 @param title 标题
 @param texts tab数组
 @param tabItemLeftRightMargin tab左右margin(影响tabItem宽度), 不填传0, 缺省:30
 @param tabItemTopBottomMargin tab上下margin(影响tabItem高度), 不填传0, 缺省:10
 @param tabFont tab字体大小, 缺省:KMTFont(30)
 @param minimumTabMargin tab与tab之间最小margin, 不填传0, 缺省:10
 @param contentTopBottomMargin tab内容的上下margin, 不填传0, 缺省:20
 */
- (instancetype)initWithTitle:(NSString *)title
                        Texts:(NSArray *)texts
       tabItemLeftRightMargin:(CGFloat)tabItemLeftRightMargin
       tabItemTopBottomMargin:(CGFloat)tabItemTopBottomMargin
                      tabFont:(UIFont *)tabFont
             minimumTabMargin:(CGFloat)minimumTabMargin
       contentTopBottomMargin:(CGFloat)contentTopBottomMargin;

/**
 添加一个输入框

 @param text 初始化内容
 @param font 字体大小
 @param placeHolder 提示
 @param didEndEdit 完成编写时的callback
 */
- (void)addTextFieldWithText:(NSString *)text
                        font:(UIFont *)font
                 placeHolder:(NSString *)placeHolder
          didEndEditCallback:(void (^)(NSString *content))didEndEdit;

/**
 获取当前输入框内容
 */
- (NSString *)getTFContent;

/**
 设置TF的内容
 */
- (void)setTFContent:(NSString *)content;

/**
 如果设置了,就自己完成所有代理逻辑, 不设置可走Callback

 @param delegate UITextFieldDelegate
 */
- (void)setTextFieldDelegate:(id<UITextFieldDelegate>)delegate;

@end
