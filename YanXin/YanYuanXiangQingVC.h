//
//  YanYuanXiangQingVC.h
//  YanXin
//
//  Created by Macx on 16/12/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "yanyuanModel.h"
@interface YanYuanXiangQingVC : UIViewController
@property(nonatomic,strong)yanyuanModel * md;//用来虚拟头像
@property(nonatomic,copy)NSString * phoneNum;//只是为了获取演员界面传递过来的手机号(不能用model,否则从我的主页进来会出错)
@end
