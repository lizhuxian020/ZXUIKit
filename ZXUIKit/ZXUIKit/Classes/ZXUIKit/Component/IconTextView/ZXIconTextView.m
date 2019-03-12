//
//  KMTIconTextView.m
//  KMDeparture
//
//  Created by mac on 13/7/2018.
//  Copyright © 2018 KMT. All rights reserved.
//

#import "ZXIconTextView.h"
#import "CJLabel.h"

//#define iconTextMargin pixelToPoint(24)
//#define textSubTextMargin pixelToPoint(8)
#define bufferMargin 7

#define getAttrStr(text, font, color) [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: color}];

@interface ZXIconTextView() {
    CGFloat _originWidth;
    CGFloat _iconTextMargin, _textSubTextMargin;
    UIFont *_titleFont, *_textFont, *_subTextFont;
    UIColor *_titleColor, *_textColor, *_subTextColor;
}

@property(nonatomic, weak) CJLabel *titleLbl;

@property(nonatomic, weak) UIImageView *iconView;

@property(nonatomic, weak) CJLabel *textLbl;

@property(nonatomic, weak) CJLabel *subTextLbl;

@end

@implementation ZXIconTextView

- (instancetype)initWithWidth:(CGFloat)width {
    self = [super init];
    if (self) {
        [self createDefault];
        self.width = width;
    }
    return self;
}

- (void)createDefault {
    _iconTextMargin = 12;
    _textSubTextMargin = 4;
    UIFont *defaultFont = ZXFont(15);
    _titleFont = defaultFont;
    _textFont = defaultFont;
    _subTextFont = defaultFont;
    _titleColor = kLightGaryColor;
    _textColor = kTextColorAleartView;
    _subTextColor = kLightGaryColor;
}

+ (instancetype)viewWithWidth:(CGFloat)width {
    return [[ZXIconTextView alloc] initWithWidth:width];
}

- (void)setWidth:(CGFloat)width {
    [super setWidth:width];
    _originWidth = width;
}

- (void)reloadWithIcon:(UIImage *)icon text:(NSString *)text subText:(NSString *)subText {
    icon = icon ? icon : _iconView.image;
    text = text ? text : _textLbl.attributedText.string;
    subText = subText ? subText : _subTextLbl.attributedText.string;
    
    self.iconView.image = icon;
    [_iconView sizeToFit];
    
    self.textLbl.attributedText = getAttrStr(ZXStrFormat(@"%@ ", text), _textFont, _textColor);
    
    if ((subText && subText.length > 0) || _subTextLbl.attributedText) {
        self.subTextLbl.attributedText = getAttrStr(subText, _subTextFont, _subTextColor);
    }

    [self reload];
    
}

- (void)reloadWithTitle:(NSString *)title text:(NSString *)text subText:(NSString *)subText {
    title = title ? title : _titleLbl.attributedText.string;
    text = text ? text : _textLbl.attributedText.string;
    subText = subText ? subText : _subTextLbl.attributedText.string;
    
    BOOL hasTitle = title && title.length > 0;
    if (hasTitle) {
        self.titleLbl.attributedText = getAttrStr(title, _titleFont, _titleColor);
        [_titleLbl sizeToFit];
    }
    
    //BugFix: 修复纯文字与文字数字混搭的高度不一样问题
    self.textLbl.attributedText = getAttrStr(ZXStrFormat(@"%@ ", text), _textFont, _textColor);

    if ((subText && subText.length > 0) || _subTextLbl.attributedText) {
        self.subTextLbl.attributedText = getAttrStr(subText, _subTextFont, _subTextColor);
    }

    [self reload];
    
}

- (void)textAddRegexs:(NSArray<NSString *> *)regexs attribute:(NSDictionary *)attribute params:(id)params didClick:(CJLabelLinkModelBlock)block {
    __block NSAttributedString *new_as = nil;
    [regexs enumerateObjectsUsingBlock:^(NSString * _Nonnull regex, NSUInteger idx, BOOL * _Nonnull stop) {
        new_as = [CJLabelConfigure configureLinkAttributedString:self.textLbl.attributedText
                                                atRange:[CommonTools validateString:self.textLbl.attributedText.string regex:regex]
                                         linkAttributes:attribute
                                   activeLinkAttributes:nil
                                              parameter:nil
                                         clickLinkBlock:^(CJLabelLinkModel *linkModel) {
                                             block(linkModel);
                                         }
                                         longPressBlock:^(CJLabelLinkModel *linkModel) {
                                             block(linkModel);
                                         }
                                                 islink:YES];
    }];
    self.textLbl.attributedText = new_as;
    
}


- (void)reload {
    if (_iconView) [_iconView sizeToFit];
    if (_titleLbl) [_titleLbl sizeToFit];
    UIView *headView = _iconView ? _iconView : _titleLbl;
    CGFloat temp_iconTextMargin = headView ? _iconTextMargin : 0;
    _textLbl.width = _originWidth - temp_iconTextMargin - headView.width + bufferMargin;
    
    
    CGSize textSize = [[_textLbl.attributedText.string stringByReplacingOccurrencesOfString:@" " withString:@"　"] stringheightWithFont:_textFont andWidth:_textLbl.width];
    _textLbl.frame = ZXRect(headView.right + temp_iconTextMargin, headView.top, textSize.width+bufferMargin, textSize.height);
    [_textLbl sizeToFit];
    
    if (_subTextLbl) {
        _subTextLbl.width = _originWidth - temp_iconTextMargin - headView.width;
        CGSize subTextSize = [[_subTextLbl.attributedText.string stringByReplacingOccurrencesOfString:@" " withString:@"　"] stringheightWithFont:_subTextFont andWidth:_subTextLbl.width];
        _subTextLbl.frame = ZXRect(_textLbl.x, _textLbl.bottom + _textSubTextMargin, subTextSize.width, subTextSize.height);
        [_subTextLbl sizeToFit];
        if (_subTextLbl.width < subTextSize.width) _subTextLbl.width = subTextSize.width;
    }
    
    self.height = (_subTextLbl) ? self.subTextLbl.height + _textSubTextMargin + self.textLbl.height : self.textLbl.height;
    
    //这里不能用self.width = width, 因为会改变_originalWidth
    CGFloat width = (_subTextLbl) ? (self.subTextLbl.right > self.textLbl.right ? self.subTextLbl.right : self.textLbl.right) : self.textLbl.right;
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

#pragma mark --AssignBLK
- (FloatAssignBLK)setHeaderTextMargin {
    return ^(CGFloat margin) {
        _iconTextMargin = margin;
        return self;
    };
}
- (FloatAssignBLK)setTextSubTextMargin {
    return ^(CGFloat margin) {
        _textSubTextMargin = margin;
        return self;
    };
}
- (FontAssignBLK)setTitleFont {
    return ^(UIFont *font) {
        _titleFont = font;
        return self;
    };
}
- (FontAssignBLK)setTextFont {
    return ^(UIFont *font) {
        _textFont = font;
        return self;
    };
}
- (FontAssignBLK)setSubTextFont {
    return ^(UIFont *font) {
        _subTextFont = font;
        return self;
    };
}
- (ColorAssignBLK)setTitleColor {
    return ^(UIColor *color) {
        _titleColor = color;
        return self;
    };
}
- (ColorAssignBLK)setTextColor {
    return ^(UIColor *color) {
        _textColor = color;
        return self;
    };
}
- (ColorAssignBLK)setSubTextColor {
    return ^(UIColor *color) {
        _subTextColor = color;
        return self;
    };
}

#pragma mark --GET
- (UIImageView *)iconView {
    if (!_iconView) {
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        _iconView = iconView;
    }
    return _iconView;
}

- (UILabel *)titleLbl {
    if (!_titleLbl) {
        CJLabel *titleLbl = [[CJLabel alloc] initWithFrame:CGRectZero];
        [self addSubview:titleLbl];
        _titleLbl = titleLbl;
    }
    return _titleLbl;
}

- (UILabel *)textLbl {
    if (!_textLbl) {
        CJLabel *textLbl = [[CJLabel alloc] initWithFrame:CGRectZero];
        textLbl.numberOfLines = 0;
        [self addSubview:textLbl];
        _textLbl = textLbl;
    }
    return _textLbl;
}

- (UILabel *)subTextLbl {
    if (!_subTextLbl) {
        CJLabel *subTextLbl = [[CJLabel alloc] initWithFrame:CGRectZero];
        [self addSubview:subTextLbl];
        _subTextLbl = subTextLbl;
    }
    return _subTextLbl;
}


@end
