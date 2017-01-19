//
//  VIPModel.h
//  YanXin
//
//  Created by Macx on 17/1/18.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VIPModel : NSObject
#pragma mark --支付宝获取订单号的
@property(nonatomic,copy)NSString * vipID;//idd
@property(nonatomic,copy)NSString * vipName;//名字
@property(nonatomic,copy)NSString * vipDengJi;//等级
@property(nonatomic,copy)NSString * vipPrice;//价格
@property(nonatomic,copy)NSString * vipMiaoShu;//描述
@property(nonatomic,copy)NSString * vipTiShi;//提示语
@property(nonatomic,copy)NSString * vipIsTishi;//是否显示提示语
-(id)initWithVIPModelDic:(NSDictionary*)dic;


#pragma mark --微信预支付的
@property(nonatomic,copy)NSString * weiXinID;//微信idd
@property(nonatomic,copy)NSString * weiNoncestr;
@property(nonatomic,copy)NSString * weiPackage;
@property(nonatomic,copy)NSString * weiXinPartnerid;//
@property(nonatomic,copy)NSString * weiXinPrepayid;//
@property(nonatomic,copy)NSString * weiXinSign;//
@property(nonatomic,copy)NSString * weiXinTimestamp;
-(id)initWithWeiXinModelDic:(NSDictionary*)dic;

#pragma mark --查询vip升级等级信息的
@property(nonatomic,copy)NSString * shengJiDID;//微信idd
@property(nonatomic,copy)NSString * shengJiGaoID;
@property(nonatomic,copy)NSString * shengJiMaoShu;
@property(nonatomic,copy)NSString * shengJiPrice;
-(id)initWithShengJiVIPDic:(NSDictionary*)dic;
@end
