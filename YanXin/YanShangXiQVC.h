//
//  YanShangXiQVC.h
//  YanXin
//
//  Created by Macx on 17/1/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YanShangXiQVC : UIViewController
//进入详情页的手机号
@property(nonatomic,copy)NSString * accountPhone;
//进入详情页的时候大图片
@property(nonatomic,copy)NSString * titleImage;
//详情页标题（公司名字）
@property(nonatomic,copy)NSString * titleName;
@end
