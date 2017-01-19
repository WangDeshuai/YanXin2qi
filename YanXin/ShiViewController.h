//
//  ShiViewController.h
//  YanXin
//
//  Created by Macx on 16/7/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShiViewController : UIViewController
@property(nonatomic,copy)NSString * shengName;
@property(nonatomic,copy)NSString*messageJie;
@property(nonatomic,copy)void(^shiBlock)(NSString*guojia,NSString*ss);
@end
