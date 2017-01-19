//
//  MyFriendsModel.m
//  YanXin
//
//  Created by Macx on 17/1/18.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MyFriendsModel.h"

@implementation MyFriendsModel
#pragma mark --直接好友
-(id)initWithZhiJieDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _headStr=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"headimgurl"]]];
        _name=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]]];
        _yanXinNum=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"promote_code"]]];
        _time=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"add_time"]]];
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
        

    }
    
    return self;
}
@end
