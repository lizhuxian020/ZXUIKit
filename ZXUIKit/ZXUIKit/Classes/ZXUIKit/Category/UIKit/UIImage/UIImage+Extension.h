//
//  UIImage+Extension.h
//  ZXUIKit
//
//  Created by mac on 12/9/2018.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
*  创建一个纯颜色Image对象
*
*  @param color   颜色
*  @param size    image大小
*  @return 返回image对象
*/
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

/**
*  改变图片大小
*
*  @param newsize   大小
*  @return 返回一个新的image对象
*/
- (UIImage *)scaleToSize:(CGSize)newsize;

/// 生成指定大小二维码
+ (UIImage *)creatRacode:(NSString *)urlstring Width:(NSInteger)imgHW;

/**
 异步绘制圆角图片
 */
- (void)imageWithCorner:(CGFloat)corner fillColor:(UIColor *)fillColor completeBlk:(void(^)(UIImage *))complete;

/**
 返回可伸缩图片, 输入上下左右的比例, 使得top+bottom = 1, left+right = 1
 */
- (UIImage *)resizableTop:(CGFloat)top
                   bottom:(CGFloat)bottom
                     left:(CGFloat)left
                    right:(CGFloat)right;

@end
