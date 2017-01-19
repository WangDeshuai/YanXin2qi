//
//  ChooseCityViewController.h
//  YanXin
//
//  Created by mac on 16/4/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseCityViewController : UIViewController
@property(nonatomic,copy)void(^shouYeBlock)(NSString*guojia,NSString*ss);
@property (nonatomic,copy)NSString * messageJie;
@property (nonatomic,copy)NSString *yuyuebtn;
@property(nonatomic,copy)NSString * shouYe;
@end
