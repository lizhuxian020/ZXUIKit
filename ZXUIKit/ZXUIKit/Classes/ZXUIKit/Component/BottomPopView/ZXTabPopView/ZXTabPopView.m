//
//  KMTTabPopView.m
//  KMDeparture
//
//  Created by mac on 15/8/2018.
//  Copyright © 2018 KMT. All rights reserved.
//

#import "ZXTabPopView.h"
#import "ZXTabPopContentView.h"

@interface ZXTabPopView()<UITextFieldDelegate> {
    ZXTabPopViewType _type;
}
@property(nonatomic, strong) UIView *containerView;

//必须strong
@property(nonatomic, strong) ZXTabPopContentView *textBtnsView;

@property(nonatomic, strong) UITextField *textField;
@end

@implementation ZXTabPopView

+(void)load {
    [super load];
}

- (instancetype)initWithTitle:(NSString *)title
                        Texts:(NSArray *)texts
       tabItemLeftRightMargin:(CGFloat)tabItemLeftRightMargin
       tabItemTopBottomMargin:(CGFloat)tabItemTopBottomMargin
                      tabFont:(UIFont *)tabFont
             minimumTabMargin:(CGFloat)minimumTabMargin
       contentTopBottomMargin:(CGFloat)contentTopBottomMargin {
    self = [super init];
    if (self) {
        _title = title;
        _textBtnsView = [[ZXTabPopContentView alloc] initWithTexts:texts tabItemLeftRightMargin:tabItemLeftRightMargin tabItemTopBottomMargin:tabItemTopBottomMargin tabFont:tabFont minimumTabMargin:minimumTabMargin contentTopBottomMargin:contentTopBottomMargin];
        [self reloadUI];
        /* 增加监听（当键盘出现或改变时） */
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        /* 增加监听（当键盘退出时） */
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)setTexts:(NSArray *)texts {
    _texts = texts;
    self.textBtnsView.texts = texts;
    [self reloadUI];
}

- (void)setCanMultipleSelect:(BOOL)canMultipleSelect {
    _canMultipleSelect = canMultipleSelect;
    if (_textBtnsView) _textBtnsView.canMultipleSelect = canMultipleSelect;
}

#pragma mark --PublicMethod
- (void)addTextFieldWithText:(NSString *)text
                        font:(UIFont *)font
                 placeHolder:(NSString *)placeHolder
          didEndEditCallback:(void (^)(NSString *content))didEndEdit {
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectZero];
    textField.text = text;
    textField.placeholder = placeHolder;
    textField.font = font;
    textField.delegate = self;
    textField.backgroundColor = kBackgroundColor;
    
    _textField = textField;
    [self.containerView addSubview:_textField];
    [self reloadUI];
}
- (void)didClickLeftLbl {
    self.didClickLeft ? self.didClickLeft(self.textBtnsView.selectedText) : [self dismiss:YES];
}

- (void)didClickRightLbl {
    self.didClickRight ? self.didClickRight(self.textBtnsView.selectedText) : [self dismiss:YES];
}

- (void)dismiss:(BOOL)animated {
    //由于使用IQKeyboard会使得整个KeyWindows都上移, 在状态栏可能会出现黑条=.=, 原因未知, 所以还是自己解决键盘遮盖问题
    IQKeyboardManager.sharedManager.enable = YES;
    [super dismiss:animated];
}

- (void)show:(BOOL)animated {
    [super show:animated];
    IQKeyboardManager.sharedManager.enable = YES;
}

- (NSString *)getTFContent {
    return _textField ? _textField.text : nil;
}

- (void)setTFContent:(NSString *)content {
    if (_textField) _textField.text = content;
}

- (void)setTextFieldDelegate:(id<UITextFieldDelegate>)delegate {
    if (_textField) {
        _textField.delegate = delegate;
    }
}

#pragma mark --CreateUI
- (UIView *)createContentViewWithWidth:(CGFloat)contentWidth {
    self.containerView.width = contentWidth;
    
    CGFloat startBottom = 0;
    if (_textField) {
        [_textField sizeToFit];
        _textField.height = _textField.height + 10;
        _textField.width = contentWidth - 30;
        _textField.origin = ZXPoint(15, 15);
        startBottom = _textField.bottom;
        [_textField addCornerRadius:5];
    }
    
    if (!self.textBtnsView.superview) [self.containerView addSubview:self.textBtnsView];
    self.textBtnsView.width = contentWidth;
    
    self.textBtnsView.y = startBottom;
    
    self.containerView.height = self.textBtnsView.bottom;
    
    return self.containerView;
}


#pragma mark --ObserveKeyboard
- (void)keyboardWillShow:(NSNotification *)aNotification {
    //获取键盘的高度
    NSDictionary *userInfo = aNotification.userInfo;
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = aValue.CGRectValue;
    
    //拿到TF距离屏幕的位置
    CGRect frame = [_textField convertRect:_textField.bounds toView:kKeyWindow];
    CGFloat shangsheng = keyboardRect.size.height - ( kScreenHeight - (frame.origin.y + frame.size.height)) + 10;
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

- (UIView *)containerView {
    if (!_containerView) {
        UIView *view = UIView.new;
        view.backgroundColor = UIColor.whiteColor;
        _containerView = view;
    }
    return _containerView;
}

- (ZXTabPopContentView *)textBtnsView {
    if (!_textBtnsView) {
        ZXTabPopContentView *view = [ZXTabPopContentView new];
        _textBtnsView = view;
    }
    return _textBtnsView;
}

- (void)dealloc {
    [kNotificationCenter removeObserver:self];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return range.location < 50;
}

@end
