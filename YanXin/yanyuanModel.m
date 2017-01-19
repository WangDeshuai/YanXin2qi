//
//  yanyuanModel.m
//  YanXin
//
//  Created by mac on 16/3/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "yanyuanModel.h"

@implementation yanyuanModel

- (id)initWithDic:(NSDictionary *)dic{
    
    self = [super init];
    if (self)
    {
        _categoryname=[self string:[dic objectForKey:@"categoryname"]];
       
        _vipname=[self string:[dic objectForKey:@"vipimgurl"]];
        _headimgurl=[self string:[dic objectForKey:@"headimgurl"]];
        _introduction=[self string:[dic objectForKey:@"introduction"]];
        _name=[self string:[dic objectForKey:@"name"]];
        _sex=[self string:[dic objectForKey:@"sex"]];
        _whoPhone=[self string:[dic objectForKey:@"account"]];
        NSString * vip =[NSString stringWithFormat:@"%@",[dic objectForKey:@"viplevel"]];
         _viplevel=vip;
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
        
        
        
        NSString * xingbie =[NSString stringWithFormat:@"%@",_sex];
        //0女，1男
        if ([xingbie isEqualToString:@"0"]) {
            _xingbieImage=[UIImage imageNamed:@"yy_femal"];
            _sexName=@"女";
        }else
        {
            _xingbieImage=[UIImage imageNamed:@"yy_Male"];
            _sexName=@"男";
        }
       
        //实名认证
        NSString * shiMing =[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"real_name_status"]]];
        if ([shiMing isEqualToString:@"1"]) {
            //实名认证
            _shiMingImage=[UIImage imageNamed:@"messege_shiming"];
        }else{
            //没有
            _shiMingImage=nil;
        }
        
        //地区
        
        
        
        
    }
    
    
    return self;
    
}
//过滤一下
-(NSString*)string:(id)sss
{
    NSString * a=@"";
    if (sss==[NSNull null]) {
        a=@"";
    }else{
        a=sss;
    }
    return a;
}
@end
