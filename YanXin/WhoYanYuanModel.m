//
//  WhoYanYuanModel.m
//  YanXin
//
//  Created by mac on 16/3/31.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WhoYanYuanModel.h"
#import "ShuJuModel.h"
@implementation WhoYanYuanModel
- (id)initWithDic:(NSDictionary *)dic{
    
    self = [super init];
    if (self)
    {
        
        
       
        
        //姓名
        _name=[self string:[dic objectForKey:@"name"]];
        //性别
        NSString * xingbie =[NSString stringWithFormat:@"%@",[dic objectForKey:@"sex"]];
        if ([xingbie isEqualToString:@"0"]) {
            _sex=@"女";
        }else
        {
            _sex=@"男";
        }
        _diqu=[self string:[dic objectForKey:@"cityname"]];//;
       //联系方式
        _phoneNumber=[self string:[dic objectForKey:@"connecttel"]];
       //地区
        NSString * sheng =[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"provname"]]];
        NSString * shi =[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"cityname"]]];
        NSString * xian =[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"districtname"]]];
        _diqu=[NSString stringWithFormat:@"%@-%@-%@",sheng,shi,xian];
        //职业分类
        _biaoqian=[self string:[dic objectForKey:@"categoryname"]];
        //个人简介
       _myjianjie=[self string:[dic objectForKey:@"introduction"]];
        //个人经历
        _myjingli=[self string:[dic objectForKey:@"experience"]];
        //头像
        _imageURL=[self string:[dic objectForKey:@"headimgurl"]];
        //是否实名认证（YES，是）
        NSString * shiming =[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"real_name_status"]]];
        if ([shiming isEqualToString:@"1"]) {
            _isShiMing=YES;
        }else{
            _isShiMing=NO;
        }
        //演信号
        _yanXinNum=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"promote_code"]]];
       //vip等级
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
    //注册时间
    _zhuCeTime=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"registtime"]]];
    
    return self;
    
}

//动态属性
-(id)initWithDongTaiDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        //动态ID
        _headId=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]];
        //头像
        _headImage=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"headimgurl"]]];
        //名字
         _headName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]]];
        //实名认证
         _headRenZheng=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"real_name_status"]]];
        //发布时间
         _headTime=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"addtime"]]];
        //内容
         _headConent=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"content"]]];
        //图片数组
         _headImageArr=[dic objectForKey:@"imgList"];
        //动态ID
        _dongTaiID=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]];
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
