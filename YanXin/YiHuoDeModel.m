//
//  YiHuoDeModel.m
//  YanXin
//
//  Created by Macx on 17/1/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "YiHuoDeModel.h"

@implementation YiHuoDeModel
-(id)initWithYiHuoDeDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _headUrl =[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"headimgurl"]]];
        _name =[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]]];
        _time =[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"charge_time"]]];
        _price =[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"brokerage"]]];
        NSString * vip =[NSString stringWithFormat:@"%@",[dic objectForKey:@"viplevel"]];
        if ([vip isEqualToString:@"0"]) {
            //没有vip
            _vipImage=nil;
        }else if ([vip isEqualToString:@"1"]){
            //vip1
            _vipImage=[UIImage imageNamed:@"messege_vip1"];
        }else if ([vip isEqualToString:@"2"]){
            //vip2
            _vipImage=[UIImage imageNamed:@"messege_vip2"];
        }else if ([vip isEqualToString:@"3"]){
            //vip3
            _vipImage=[UIImage imageNamed:@"messege_vip3"];
        }
        
        NSString * friend =[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"relation_grade"]]];
        if ([friend isEqualToString:@"1"]) {
            //直接好友
            _friendImage=[UIImage imageNamed:@"cf_zj"];
        }else if ([friend isEqualToString:@"2"]){
            //间接好友
             _friendImage=[UIImage imageNamed:@"cf_jj"];
        }else{
            //其它好友
             _friendImage=[UIImage imageNamed:@"cf_qt"];
        }
        
    }
    
    return self;
}
@end
