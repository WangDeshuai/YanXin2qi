//
//  XianViewController.h
//  YanXin
//
//  Created by Macx on 16/7/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XianViewController : UIViewController
@property(nonatomic,copy)NSString * xianName;
@property(nonatomic,copy)NSString*messageJie;
@property(nonatomic,copy)void(^xianBlock)(NSString*guojia,NSString*ss);
@end
