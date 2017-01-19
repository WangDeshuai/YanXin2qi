//
//  VIPModel.m
//  YanXin
//
//  Created by Macx on 17/1/18.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "VIPModel.h"

@implementation VIPModel
#pragma mark --支付宝获取订单号的
-(id)initWithVIPModelDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _vipID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]];
        _vipName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]]];
        _vipDengJi=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"level"]]];
        _vipPrice=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]]];
        _vipMiaoShu=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"descri"]]];
        _vipTiShi=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"notice"]]];
        //是否显示提示语1.是0.否
        _vipIsTishi=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"isShowNotice"]]];
    }
    
    return self;
}
#pragma mark --微信支付
-(id)initWithWeiXinModelDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
         _weiXinID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"appid"]]];
         _weiNoncestr=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"noncestr"]]];
         _weiPackage=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"package"]]];
         _weiXinPartnerid=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"partnerid"]]];
         _weiXinPrepayid=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"prepayid"]]];
         _weiXinSign=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"sign"]]];
        _weiXinTimestamp=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"timestamp"]]];
    }
    
    return self;
}
#pragma mark --查询vip升级等级信息的
-(id)initWithShengJiVIPDic:(NSDictionary*)dic
{
    self=[super init];
    if (self) {
        _shengJiDID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"lowerVipId"]]];
        _shengJiGaoID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"higherVipId"]]];
        _shengJiMaoShu=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"upgradeDesc"]]];
        _shengJiPrice=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"moneyDifference"]]];
    }
    
    return self;
}
@end
