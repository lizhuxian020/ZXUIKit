//
//  ZXTabPopContentView.m
//  ZXUIKit
//
//  Created by Lee on 16/8/2018.
//  Copyright © 2018 Lee. All rights reserved.
//

#import "ZXTabPopContentView.h"

#define kView_TabNormalColor kBackgroundColor
#define kView_TabSelectedColor kMainYellow

@interface ZXTabPopContentView()

@property(nonatomic, strong) NSMutableArray<UIButton *> *selectedBtns;

@property(nonatomic, weak) UIButton *selectedBtn;

@end

@implementation ZXTabPopContentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        [self setDefault];
        _selectedBtns = [NSMutableArray new];
    }
    return self;
}

- (instancetype)initWithTexts:(NSArray *)texts
       tabItemLeftRightMargin:(CGFloat)tabItemLeftRightMargin
       tabItemTopBottomMargin:(CGFloat)tabItemTopBottomMargin
                      tabFont:(UIFont *)tabFont
             minimumTabMargin:(CGFloat)minimumTabMargin
       contentTopBottomMargin:(CGFloat)contentTopBottomMargin {
    self = [self init];
    if (self) {
        if (!kIsEmpty(texts)) _texts = texts;
        if (tabItemLeftRightMargin > 0) _tabItemLeftRightMargin = tabItemLeftRightMargin;
        if (tabItemTopBottomMargin > 0) _tabItemTopBottomMargin = tabItemTopBottomMargin;
        if (!kIsEmpty(tabFont)) _tabFont = tabFont;
        if (minimumTabMargin > 0) _minimumTabMargin = minimumTabMargin;
        if (contentTopBottomMargin > 0) _contentTopBottomMargin = contentTopBottomMargin;
    }
    return self;
}

- (void)setDefault {
    _tabItemLeftRightMargin = 30;
    _tabItemTopBottomMargin = 10;
    _tabFont = ZXFont(15);
    _minimumTabMargin = 10;
    _contentTopBottomMargin = 20;
}

- (void)setWidth:(CGFloat)width {
    [super setWidth:width];
    [self createUI];
}

#pragma mark --Property
- (void)setTexts:(NSArray *)texts {
    _texts = texts;
    [self createUI];
}

- (void)setTabItemLeftRightMargin:(CGFloat)tabItemLeftRightMargin {
    _tabItemLeftRightMargin = tabItemLeftRightMargin;
    [self createUI];
}

- (void)setTabItemTopBottomMargin:(CGFloat)tabItemTopBottomMargin {
    _tabItemTopBottomMargin = tabItemTopBottomMargin;
    [self createUI];
}

- (void)setTabFont:(UIFont *)tabFont {
    _tabFont = tabFont;
    [self createUI];
}

- (void)setMinimumTabMargin:(CGFloat)minimumTabMargin {
    _minimumTabMargin = minimumTabMargin;
    [self createUI];
}

- (void)setContentTopBottomMargin:(CGFloat)contentTopBottomMargin {
    _contentTopBottomMargin = contentTopBottomMargin;
    [self createUI];
}

- (NSArray<NSString *> *)selectedText {
    if (_canMultipleSelect && _selectedBtns.count > 0) {
        return [_selectedBtns valueForKeyPath:@"titleLabel.text"];
    }
    if (!_canMultipleSelect && _selectedBtn) {
        return @[_selectedBtn.titleLabel.text];
    }
    return nil;
}

- (void)createUI {
    [self removeAllSubView];
    
    CGFloat x = 0;
    CGFloat y = 0;
    NSMutableArray<UIButton *> *lastRowBtns = [NSMutableArray new];
    for (NSString *text in self.texts) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(didClickTab:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btn setTitleColor:kTextColorAleartView forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageWithColor:kView_TabNormalColor andSize:ZXSize(10, 10)] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:kView_TabSelectedColor andSize:ZXSize(10, 10)] forState:UIControlStateSelected];
        btn.adjustsImageWhenHighlighted = NO;
        btn.titleLabel.font = _tabFont;
        //形状
        [btn setTitle:text forState:UIControlStateNormal];
        [btn sizeToFit];
        btn.width = btn.width + 2*_tabItemLeftRightMargin;
        btn.height = btn.height + 2*_tabItemTopBottomMargin;
        //=.=为了让Title居中
        [btn setTitle:text forState:UIControlStateNormal];
        btn.origin = ZXPoint(x+_minimumTabMargin, _contentTopBottomMargin + y);
        [btn addCornerRadius:5];
        //是否需要换行
        if (btn.right > self.width - _minimumTabMargin) {
            x = 0;
            y = btn.bottom;
            btn.origin = ZXPoint(x+_minimumTabMargin, _contentTopBottomMargin + y);
            //lastRow重新排版
            [self reloadLastRow:lastRowBtns];
        }
        x = btn.right;
        [lastRowBtns addObject:btn];
        btn.backgroundColor = kView_TabNormalColor;
    }
    y = lastRowBtns.lastObject.bottom;
    //给最后一行重新排版
    [self reloadLastRow:lastRowBtns];
    self.height = y + _contentTopBottomMargin;
}

//重新排版
- (void)reloadLastRow:(NSMutableArray *)lastRowBtns {
    CGFloat btnsWidth = 0;
    for (UIButton *lastRowBtn in lastRowBtns) {
        btnsWidth += lastRowBtn.width;
    }
    CGFloat itemMargin = (self.width - btnsWidth) / (lastRowBtns.count+1);
    CGFloat last_X = itemMargin;
    for (UIButton *lastRowBtn in lastRowBtns) {
        lastRowBtn.x = last_X;
        last_X = lastRowBtn.right + itemMargin;
    }
    //排版完成, remove所有
    [lastRowBtns removeAllObjects];
}

- (void)didClickTab:(UIButton *)btn {
    if (!_canMultipleSelect) {
        if (_selectedBtn == btn) return;
        _selectedBtn.selected = NO;
        btn.selected =YES;
        _selectedBtn = btn;
        return;
    }
    btn.selected = !btn.selected;
    if (btn.selected) {
        [_selectedBtns addObject:btn];
    } else if ([_selectedBtns containsObject:btn]) {
        [_selectedBtns removeObject:btn];
    }
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
