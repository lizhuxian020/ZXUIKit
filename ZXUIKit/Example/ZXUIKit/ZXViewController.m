//
//  ZXViewController.m
//  ZXUIKit
//
//  Created by lizhuxian020@gmail.com on 07/30/2018.
//  Copyright (c) 2018 lizhuxian020@gmail.com. All rights reserved.
//

#import "ZXViewController.h"
#import <ZXUIKit/ZXUIKit.h>
#import "ZXOtherViewController.h"

@interface ZXViewController ()

@end

@implementation ZXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = kMainYellow;
    
//    UILabel *lbl = [UILabel new];
//    lbl.text = @"asdajlkdjaskdj\nsdlaslkdjas";
//    lbl.numberOfLines = 0;
//    lbl.size = ZXSize(200, 200);
//    [lbl showBorder];
//    [self.view addSubview:lbl];
//
//    lbl.center = self.view.center;
//
//    [lbl setLineSpace:20];
//
//    [lbl setWordSpace:5];
    
//    UIImage *colorImg = [UIImage imageWithColor:kLessGray andSize:ZXSize(200, 200)];
//    UIImageView *imgView = [[UIImageView alloc] initWithImage:colorImg];
//    [self.view addSubview:imgView];
//    imgView.center = self.view.center;
//
//    [colorImg imageWithCorner:10 fillColor:UIColor.redColor completeBlk:^(UIImage *resImg) {
//        imgView.image = resImg;
//    }];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self alertWithTitle:@"title" message:@"message" actionTitles:@[@"取消", @"confirm"] actionHandler:^(UIAlertAction *action) {
//        if (action.index.intValue == 0) {
//            NSLog(@"取消");
//        } else if (action.index.intValue == 1) {
//            NSLog(@"confirm");
//        }
//    }];
    
    [self.navigationController pushViewController:[ZXOtherViewController new] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
