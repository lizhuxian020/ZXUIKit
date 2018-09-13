//
//  GlobalHeader.h
//  ZXUIKit
//
//  Created by mac on 3/9/2018.
//

#ifndef GlobalHeader_h
#define GlobalHeader_h

#define kKeyWindow                           ([[UIApplication sharedApplication] keyWindow])
#define kUserDefaults                        [NSUserDefaults standardUserDefaults]
#define kNotificationCenter                  [NSNotificationCenter defaultCenter]
#define kIOSVersion                          [[[UIDevice currentDevice] systemVersion] floatValue]
#define kIsIOS7Later                         (IOSVersion >= 7.0)
#define kIsIOS8Later                         (IOSVersion >= 8.0)
#define kIsIOS11Later                        (IOSVersion >= 11.0)
#define kAPPVersion                          [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define ZXRect(x, y, w, h)                   CGRectMake(x, y, w, h)
#define ZXSize(w, h)                         CGSizeMake(w, h)
#define ZXPoint(x, y)                        CGPointMake(x, y)

#define kScreenRect                          [[UIScreen mainScreen] bounds]
#define kScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight                        [[UIScreen mainScreen] bounds].size.height

#define kRGB(r, g, b)                        [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
#define kRGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define KSELF                                __weak typeof(self) kself = self;

//通用
#define kBackgroundColor             kRGB(244,244,244)
#define kLineColor                   kRGB(204,204,204)
#define kTextColorAleartView         kRGB(51,51,51)
#define kMainYellow                  kRGB(255,174,0)
#define kLessGray                    kRGB(153,153,153)
#define kLightGaryColor              UIColor.lightGrayColor

//字体
#define ZXFont(_FontSize_)                            [UIFont systemFontOfSize:_FontSize_]

//打印输出
#ifdef DEBUG
#define ZXLog(...)DDLogVerbose(__VA_ARGS__)
#else  //发布状态  关闭LOG功能
#define ZXLog(...)
#endif

//打印输出
#ifdef DEBUG
#define ZXLogError(...)DDLogError(__VA_ARGS__)
#else  //发布状态  关闭LOG功能
#define ZXLogError(...)
#endif

//代码简写
#define ZXStrFormat(...)                       [NSString stringWithFormat:__VA_ARGS__]

#endif /* GlobalHeader_h */
