//
//  KMTTextPopView.m
//  KMDeparture
//
//  Created by mac on 25/8/2018.
//  Copyright © 2018 KMT. All rights reserved.
//

#import "ZXTextPopView.h"

#define kTextView_leftRightMargin 15
#define kTextView_topBottomMargin 10
#define kTextView_maxLength 50

UIFont *TextPop_DefaultFont;

@interface ZXTextPopView()<UITextViewDelegate> {
    NSString *_placeholder;
}

@property(nonatomic, strong) UIView *containerView;

@property(nonatomic, weak) UITextView *mainTF;

@property(nonatomic, weak) UILabel *textNumLbl;

@end

@implementation ZXTextPopView

+(void)load {
    [super load];
    TextPop_DefaultFont = ZXFont(15);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        /* 增加监听（当键盘出现或改变时） */
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        /* 增加监听（当键盘退出时） */
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

#pragma mark --ObserveKeyboard
- (void)keyboardWillShow:(NSNotification *)aNotification {
    //获取键盘的高度
    NSDictionary *userInfo = aNotification.userInfo;
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = aValue.CGRectValue;
    
    //拿到TF距离屏幕的位置
    CGFloat shangsheng = keyboardRect.size.height;
    // 输入框上移
    UIView *contentView = [self valueForKey:@"contentView"];
    [UIView animateWithDuration:0.1 animations:^ {
        contentView.y = (kScreenHeight - contentView.height) - shangsheng;
    }];
}

- (void)keyboardWillHide:(NSNotification *)aNotification {
    /* 输入框下移 */
    UIView *contentView = [self valueForKey:@"contentView"];
    [UIView animateWithDuration:0.1 animations:^ {
        contentView.y = kScreenHeight - contentView.height;
    }];
    
}

#pragma mark --PublicMethod
- (void)setPlaceHolder:(NSString *)placeHolder {
    _placeholder = placeHolder;
    UILabel *view = [self.mainTF valueForKey:@"_placeholderLabel"];
    if (!view && [view isKindOfClass:UILabel.class]) {
        view.text = placeHolder;
    } else if (view == nil) {
        // _placeholderLabel
        UILabel *placeHolderLabel = [[UILabel alloc] init];
        placeHolderLabel.text = placeHolder;
        placeHolderLabel.numberOfLines = 0;
        placeHolderLabel.textColor = [UIColor lightGrayColor];
        [placeHolderLabel sizeToFit];
        [self.mainTF addSubview:placeHolderLabel];
        
        // same font
        placeHolderLabel.font = TextPop_DefaultFont;
        
        [self.mainTF setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    }
}

#pragma mark --OVERRIDE
- (UIView *)createContentViewWithWidth:(CGFloat)contentWidth {
    self.containerView.width = contentWidth;
    self.mainTF.width = contentWidth;
    self.mainTF.height = 200;
    
    [self.textNumLbl sizeToFit];
    self.textNumLbl.y = self.mainTF.bottom + 5;
    self.textNumLbl.right = contentWidth - kTextView_leftRightMargin;
    
    self.containerView.height = self.textNumLbl.bottom + kTextView_topBottomMargin;
    
    return self.containerView;
}

- (void)didClickRightLbl {
    
    NSString *content = self.mainTF.text;
    if (kIsEmpty(content)) {
        kShowToast(_placeholder?:@"内容不能为空");
        return;
    }
//    self.didClickRight ? self.didClickRight(content) : [self dismiss:YES];
    if (self.didClickRight) {
        self.didClickRight(content);
    }
    [self dismiss:YES];
}

- (void)dismiss:(BOOL)animated {
    //由于使用IQKeyboard会使得整个KeyWindows都上移, 在状态栏可能会出现黑条=.=, 原因未知, 所以还是自己解决键盘遮盖问题
    IQKeyboardManager.sharedManager.enable = YES;
    [super dismiss:animated];
}

- (void)show:(BOOL)animated {
    [super show:animated];
    IQKeyboardManager.sharedManager.enable = NO;
}

#pragma mark --UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    NSMutableString *str = [NSMutableString stringWithString:textView.text];
    [str replaceCharactersInRange:range withString:text];
    if (str.length <= kTextView_maxLength) return YES;
    if (str.length > kTextView_maxLength) {
        //如果此时已经大于等于MAX了, 就直接NO
        if (textView.text.length >= kTextView_maxLength) return NO;
        //否则裁剪
        NSString *subStr = [str substringToIndex:kTextView_maxLength];
        textView.text = subStr;
        //这里returnNO,不触发didChange, 手动设置lbl
        self.textNumLbl.text = ZXStrFormat(@"%d/%d", (int)textView.text.length, kTextView_maxLength);
        [self.textNumLbl sizeToFit];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    self.textNumLbl.text = ZXStrFormat(@"%d/%d", (int)textView.text.length, kTextView_maxLength);
    [self.textNumLbl sizeToFit];
}

#pragma mark --GET & SET
- (UIView *)containerView {
    if (!_containerView) {
        UIView *view = [UIView new];
        view.backgroundColor = UIColor.whiteColor;
        _containerView = view;
    }
    return _containerView;
}

-(UITextView *)mainTF {
    if (!_mainTF) {
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
        [textView setTextContainerInset:UIEdgeInsetsMake(kTextView_topBottomMargin, kTextView_leftRightMargin, kTextView_topBottomMargin, kTextView_leftRightMargin)];
        textView.font = TextPop_DefaultFont;
        [self.containerView addSubview:textView];
        _mainTF = textView;
        _mainTF.delegate = self;
        textView.backgroundColor = UIColor.whiteColor;
    }
    return _mainTF;
}

- (UILabel *)textNumLbl {
    if (!_textNumLbl) {
        UILabel *lbl = [UILabel new];
        lbl.font = TextPop_DefaultFont;
        [self.containerView addSubview:lbl];
        lbl.text = ZXStrFormat(@"0/%d", kTextView_maxLength);
        _textNumLbl = lbl;
    }
    return _textNumLbl;
}
@end
