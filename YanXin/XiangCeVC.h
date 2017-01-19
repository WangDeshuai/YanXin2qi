//
//  XiangCeVC.h
//  YanXin
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YanYuanKongJian.h"
@interface XiangCeVC : UIViewController
@property (nonatomic,copy)NSString * shui;
@property (nonatomic,retain)UIView * yelerView;
@property (assign,nonatomic)YanYuanKongJian * DeLiSelf;
@property(nonatomic,retain)UIView *backgroundView;
@end
