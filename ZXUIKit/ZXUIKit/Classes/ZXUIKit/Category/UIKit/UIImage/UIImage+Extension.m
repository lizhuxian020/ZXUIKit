//
//  UIImage+Extension.m
//  ZXUIKit
//
//  Created by mac on 12/9/2018.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)scaleToSize:(CGSize)newsize {
    // 创建一个bitmap的context
    
    // 并把它设置成为当前正在使用的context
    
    UIGraphicsBeginImageContext(newsize);
    
    // 绘制改变大小的图片
    
    [self drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    
    // 从当前context中创建一个改变大小后的图片
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

#pragma mark 二维码生成
+ (UIImage *)creatRacode:(NSString *)urlstring Width:(NSInteger)imgHW
{
    //二维码滤镜
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    //恢复滤镜的默认属性
    
    [filter setDefaults];
    
    //将字符串转换成NSData
    
    NSData *data=[urlstring dataUsingEncoding:NSUTF8StringEncoding];
    
    //通过KVC设置滤镜inputmessage数据
    
    [filter setValue:data forKey:@"inputMessage"];
    
    //获得滤镜输出的图像
    
    CIImage *outputImage=[filter outputImage];
    
    //将CIImage转换成UIImage,并放大显示
    
    UIImage* resoultImg =[UIImage createNonInterpolatedUIImageFormCIImage:outputImage withSize:imgHW];
    return resoultImg;
}

//改变二维码大小
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 创建bitmap;
    
    size_t width = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
    
}

- (void)imageWithCorner:(CGFloat)corner fillColor:(UIColor *)fillColor completeBlk:(void(^)(UIImage *))complete {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIGraphicsBeginImageContextWithOptions(self.size, YES, 0);
        CGRect rect = ZXRect(0, 0, self.size.width, self.size.height);
        
        [fillColor setFill];
        UIRectFill(rect);
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:corner];
        [path addClip];
        
        [self drawInRect:rect];
        
        UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        dispatch_async(dispatch_get_main_queue(), ^{
            complete(resultImg);
        });
    });
}

- (UIImage *)resizableTop:(CGFloat)top
                   bottom:(CGFloat)bottom
                     left:(CGFloat)left
                    right:(CGFloat)right {
    
    // 设置端盖的值
    CGFloat t_top = self.size.height * top;
    CGFloat t_left = self.size.width * left;
    CGFloat t_bottom = self.size.height * bottom;
    CGFloat t_right = self.size.width * right;
    
    // 设置端盖的值
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(t_top, t_left, t_bottom, t_right);
    // 设置拉伸的模式
    UIImageResizingMode mode = UIImageResizingModeStretch;
    
    // 拉伸图片
    UIImage *newImage = [self resizableImageWithCapInsets:edgeInsets resizingMode:mode];
    
    return newImage;
}

@end
