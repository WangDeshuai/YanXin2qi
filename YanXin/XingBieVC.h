//
//  XingBieVC.h
//  YanXin
//
//  Created by Macx on 17/1/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XingBieVC : UIViewController
@property(nonatomic,copy)void(^XingBieBlock)(NSString*XXname,NSString*number);
/*
 tagg==1代表从个人信息来的选择的是男女
 tagg==2代表是我的界面进来的选择是否隐藏手机号
 */
@property(nonatomic,assign)NSInteger tagg;
@end
