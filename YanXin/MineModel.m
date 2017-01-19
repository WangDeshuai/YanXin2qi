//
//  MineModel.m
//  YanXin
//
//  Created by Macx on 17/1/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "MineModel.h"

@implementation MineModel
-(id)initWithMessageDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        //联系方式
        _phonenum=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"connecttel"]]];
        //名字
        _name=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]]];
        //用户类型
        _usertype=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"usertype"]]];
        //性别
         NSString * xieBie=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"sex"]]];
        if ([xieBie isEqualToString:@"0"]) {
            _sex=@"女";
        }else{
            _sex=@"男";
        }
        
        _sexNum=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"sex"]]];
        //头像
        _headImageStr=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"headimgurl"]]];
        //省
       NSString* provname=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"provname"]]];
        _provname=provname;
        //市
         NSString*cityname=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"cityname"]]];
        _cityname=cityname;
        //县
         NSString*districtname=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"districtname"]]];
        _districtname=districtname;
        _sheng=[NSString stringWithFormat:@"%@-%@-%@",provname,cityname,districtname];
        //简介
        _introduction=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"introduction"]]];
        //精力
        _experience=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"experience"]]];
        //演信号
        _yanXinnum=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"promote_code"]]];
        //加入时间
        _time=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"registtime"]]];
        //标签
        _biaoQian=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"categoryname"]]];
        _biaoQianNum=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"category"]]];
        //实名认证状态
         NSString * dengJi=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"real_name_status"]]];
        if ([dengJi isEqualToString:@"0"]) {
            _isShiMing=NO;
        }else{
            _isShiMing=YES;
        }
        //VIP名字
        _vipname=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"vipname"]]];
        //VIP等级
        _vipdengJi=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"viplevel"]]];
        
        
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
