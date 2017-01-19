//
//  MineModel.h
//  YanXin
//
//  Created by Macx on 17/1/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineModel : NSObject
@property(nonatomic,copy)NSString *phonenum;//联系方式
@property(nonatomic,copy)NSString *name;//名字
@property(nonatomic,copy)NSString *usertype;//用户类型
@property(nonatomic,copy)NSString *sex;//性别
@property(nonatomic,copy)NSString *sexNum;//性别
@property(nonatomic,copy)NSString *headImageStr;//头像
@property(nonatomic,copy)NSString *provname;//省
@property(nonatomic,copy)NSString *cityname;//市
@property(nonatomic,copy)NSString *districtname;//县
@property(nonatomic,copy)NSString * sheng;//连起来

@property(nonatomic,copy)NSString *introduction;//简介
@property(nonatomic,copy)NSString *experience;//精力
@property(nonatomic,copy)NSString *yanXinnum;//演信号
@property(nonatomic,copy)NSString *time;//加入时间
@property(nonatomic,copy)NSString * biaoQian;//标签名字
@property(nonatomic,copy)NSString* biaoQianNum;//category
@property(nonatomic,assign)BOOL isShiMing;//实名认证状态
@property(nonatomic,copy)NSString *vipname;//VIP名字
@property(nonatomic,strong)UIImage * vipImage;//vip
@property(nonatomic,copy)NSString *vipdengJi;//VIP等级
-(id)initWithMessageDic:(NSDictionary*)dic;

@end
