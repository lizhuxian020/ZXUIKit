//
//  UIView+Extension.h
//  ZXUIKit
//
//  Created by mac on 3/9/2018.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  size;        ///< Shortcut for frame.size.

- (void)centerToParent:(UIView *)view;
- (void)centerToParentX: (UIView*)view;
- (void)centerToParentY: (UIView*)view;
- (BOOL)nearTo: (CGPoint)point lag: (CGFloat)lag;
- (UIImage*)toUIImage;

//加圆角
/**
 @brief  UIview圆角
 */
- (void)addTopRoundRadius:(CGFloat)radius;//上
- (void)addBottomRoundRadius:(CGFloat)radius;//下
- (void)addLeftRoundRadius:(CGFloat)radius;//左边
- (void)addRightRoundRadius:(CGFloat)radius;//右边
- (void)addCornerRadius:(CGFloat)radius;//四边
//移除view上面的所有控件
- (void)removeAllSubView;

//延迟时间执行
- (void)executeRunloop:(void (^)(void))runloop afterDelay:(float)delay;
- (void)presentAnimation;//从下到上动画
- (void)dimissAnimaiton;//从上到下动画
- (void)pushAnimation;//从左到右动画
- (void)popAnimation;//从右到左动画
- (void)showAnimation;//渐现动画
- (void)hideAnimation;//渐隐动画
- (void)windowPresent;//从下到上加入window动画
- (void)parentBottomPresent;//从下到上运动（根据自身高度 紧贴父视图底部）

//lineView
+(UIView *)drawLineView:(CGFloat)speace;
- (UIView *)findViewThatIsFirstResponder;

//
- (void)setViewWidth:(CGFloat)width;//View宽度重新设置
- (void)setViewHeight:(CGFloat)height;//View高度重新设置
- (void)setViewPointX:(CGFloat)pointX;//View x坐标设置
- (void)setViewPointY:(CGFloat)pointY;//View y坐标设置
- (UIViewController *)viewController;//递归查找view 的ViewController

//调试用
- (void)showBorder;

@end

NS_ASSUME_NONNULL_END
