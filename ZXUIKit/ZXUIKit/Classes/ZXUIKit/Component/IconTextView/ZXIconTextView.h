//
//  KMTIconTextView.h
//  KMDeparture
//
//  Created by mac on 13/7/2018.
//  Copyright © 2018 KMT. All rights reserved.
//

#import "ZXView.h"
#import <CJLabel/CJLabel.h>

@class ZXIconTextView;

typedef ZXIconTextView *(^FloatAssignBLK)(CGFloat);
typedef ZXIconTextView *(^FontAssignBLK)(UIFont*);
typedef ZXIconTextView *(^ColorAssignBLK)(UIColor*);

/**
 文本视图:
 1. 图标和描述文案, 比如:  🐶 狗子
 2. 标题和描述文案, 比如:  狗子 一条狗子
 3. 可给定的margin和字体大小和宽度, 自适应高度
 PS: 必须给定宽度, 其他有缺省值
 */
@interface ZXIconTextView : ZXView

@property(nonatomic, copy, readonly) FloatAssignBLK setHeaderTextMargin;
@property(nonatomic, copy, readonly) FloatAssignBLK setTextSubTextMargin;
@property(nonatomic, copy, readonly) FontAssignBLK setTitleFont;
@property(nonatomic, copy, readonly) FontAssignBLK setTextFont;
@property(nonatomic, copy, readonly) FontAssignBLK setSubTextFont;
@property(nonatomic, copy, readonly) ColorAssignBLK setTitleColor;
@property(nonatomic, copy, readonly) ColorAssignBLK setTextColor;
@property(nonatomic, copy, readonly) ColorAssignBLK setSubTextColor;

/**
 初始化方法, 必须执行宽度, 才能自适配高度
 */
+ (instancetype)viewWithWidth:(CGFloat)width;

/**
 调用前先指定好view的width
 */
- (void)reloadWithIcon:(UIImage *)icon text:(NSString *)text subText:(NSString *)subText;

/**
 调用前先指定好view的width
 */
- (void)reloadWithTitle:(NSString *)title text:(NSString *)text subText:(NSString *)subText;

/**
 可添加正则匹配表达式, 并加入富文本属性, 和点击事件
 
 @param regexs 传入数组, 里面是正则表达式, 匹配TextLbl, 不匹配subTextLbl
 @param attribute 符合匹配到正则的字符串, 就带入这些属性
 @param params 之前是用于点击事件的入参, 先放着以后用
 @param block 正则匹配到文字的点击事件
 */
- (void)textAddRegexs:(NSArray<NSString *> *)regexs attribute:(NSDictionary *)attribute params:(id)params didClick:(CJLabelLinkModelBlock)block;



@end
