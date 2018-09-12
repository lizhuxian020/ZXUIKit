//
//  ZXOtherViewController.m
//  ZXUIKit_Example
//
//  Created by mac on 12/9/2018.
//  Copyright © 2018 lizhuxian020@gmail.com. All rights reserved.
//

#import "ZXOtherViewController.h"
#import <ZXUIKit/ZXUIKit.h>
#import <objc/runtime.h>
#import "ZXPerson.h"

@interface ZXOtherViewController ()

@end

@implementation ZXOtherViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBackgroundColor;
    
//    UIButton *btn = [UIButton new];
//    [btn setTitle:@"button" forState:UIControlStateNormal];
//    [self.view addSubview:btn];
//    btn.center = self.view.center;
//    [btn sizeToFit];
//    [btn showBorder];
//
//    [btn addAction:^(UIButton *btn) {
//        NSLog(@"aasd");
//    }];
    
    
    ZXPerson *p = [ZXPerson new];
    [p performSelector:@selector(qwe)];
    NSLog(@"%s", class_getName(class_getSuperclass (NSClassFromString(@"ZXPerson"))));
    
    NSLog(@"%zu",  class_getInstanceSize(p.class));
    
    NSArray *A = @[@"a", @"b", @"c"];
//
    id a= [A objectAtIndex:2];
    NSLog(@"%@", a);
//
    
//    [self exchangeImp];
    
    
    NSString *asd = @"lizhuxian020@125.com";
    
    BOOL re = asd.isMobileNumber;
    
    NSLog(@"%@", [asd securePhoneNumber]);
    
    NSArray *arr = @[
                     @{
                         @"asd":@"qwE",
                         },@{
                         @"zxc":@21
                         }];
    
    NSLog(@"%@", [NSString JSONStringWithObject:arr]);
    NSLog(@"%@", @"123".md5String);
    
    
    NSString *url = @"baidu.com/哈哈";
    NSLog(@"%@", url.urlInURLEncoding);
    NSLog(@"%@", @"123".aesString);
    NSLog(@"%@", aesDecryptString(@"123".aesString, @"wsAc78qwnb34cvs8"));
    NSLog(@"asd");
    
    ZXLog(@"aslkdjaskjdlasdjaksdjlasz");
    
}

- (void)exchangeImp {
    ZXPerson *p = [ZXPerson new];
    Method asdM = class_getInstanceMethod(p.class, @selector(asd));
    Method qweM = class_getInstanceMethod(p.class, @selector(qwe));
    
    method_exchangeImplementations(asdM, qweM);
    
    [p performSelector:@selector(qwe)];
}


//遍历成员变量
- (void)fetchIvar {
    ZXPerson *p = [ZXPerson new];
    unsigned int count = 0;
    //拿到成员变量列表
    Ivar *ivarList = class_copyIvarList(p.class, &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        const char *keyName = ivar_getName(ivar);
        //拿到成员变量名
        NSString *key = [NSString stringWithUTF8String:keyName];
        //去除开头的_
        key = [key substringFromIndex:1];
        
        NSLog(@"%@", key);
    }
}


- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
