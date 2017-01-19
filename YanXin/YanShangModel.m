//
//  YanShangModel.m
//  YanXin
//
//  Created by mac on 16/4/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YanShangModel.h"

@implementation YanShangModel
- (id)initWithDic:(NSDictionary *)dic{
    
    self = [super init];
    if (self)
    {
     _titleName=[dic objectForKey:@"name"];
     _imageName=[dic objectForKey:@"showimgurl"];
     _imageVIPName=[dic objectForKey:@"vipimgurl"];
     _jianJie=[dic objectForKey:@"introduction"];
        _anliArr=[dic objectForKey:@"successcase"];
       _name=[dic objectForKey:@"linkman"];
       _phone=[dic objectForKey:@"connecttel"];
       _dizhi=[dic objectForKey:@"address"];
        _viplevel=[NSString stringWithFormat:@"%@",[dic objectForKey:@"viplevel"]];
        _huiyishi=[dic objectForKey:@"meetingRoom"];
        _kefang=[dic objectForKey:@"guestRoom"];
        
    }
    
    return self;
    
}
//演出公司
-(id)initWithYanChuCommnyDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _headImageUrl=[ToolClass  isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"headimgurl"]]];
        _title=[ToolClass  isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]]];
        _content=[ToolClass  isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"introduction"]]];
        _renZheng=[ToolClass  isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"authentication"]]];
        _yanShangID=[ToolClass  isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]]];
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
        _yanShangAccount=[NSString stringWithFormat:@"%@",[dic objectForKey:@"account"]];
    }
    return self;
}
@end
