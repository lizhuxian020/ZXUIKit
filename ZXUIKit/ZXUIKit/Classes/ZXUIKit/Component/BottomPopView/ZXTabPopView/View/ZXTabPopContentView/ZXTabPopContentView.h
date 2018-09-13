//
//  KMTTabPopContentView.h
//  KMDeparture
//
//  Created by mac on 16/8/2018.
//  Copyright © 2018 KMT. All rights reserved.
//

#import "ZXView.h"

/**
 tab内容组件
 1. tab与tab之间会根据情况,自身等间距排版,可以通过设置minimumTabMargin控制最小间距
 2. 以下属性每设置一次都会reload一次, 初始化的时候最好使用initAPI, 把所需都设置好了再reload, 否则一个个设置会损耗资源
 */
@interface ZXTabPopContentView : ZXView
//Tab数组(DataSource)
@property(nonatomic, strong) NSArray *texts;
//tabItem的左右margin
@property(nonatomic, assign) CGFloat tabItemLeftRightMargin;
//tabItem的上下margin
@property(nonatomic, assign) CGFloat tabItemTopBottomMargin;
//tab字体大小
@property(nonatomic, strong) UIFont *tabFont;
//tab与tab之间最小margin
@property(nonatomic, assign) CGFloat minimumTabMargin;
//整体内容的上下margin
@property(nonatomic, assign) CGFloat contentTopBottomMargin;

/**
 tab可以多选, 则ClickLeftLBL和ClickRightLbl返回NSArray<NSString *>
 默认NO
 */
@property(nonatomic, assign) BOOL canMultipleSelect;

- (instancetype)initWithTexts:(NSArray *)texts
       tabItemLeftRightMargin:(CGFloat)tabItemLeftRightMargin
       tabItemTopBottomMargin:(CGFloat)tabItemTopBottomMargin
                      tabFont:(UIFont *)tabFont
             minimumTabMargin:(CGFloat)minimumTabMargin
       contentTopBottomMargin:(CGFloat)contentTopBottomMargin;

/**
 返回被选中tabItem的Text
 1. 如果canMultipleSelect为NO, 则数组只有一个元素
 */
- (NSArray<NSString *> *)selectedText;

@end
