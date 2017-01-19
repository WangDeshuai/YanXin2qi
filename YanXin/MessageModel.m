//
//  MessageModel.m
//  YanXin
//
//  Created by mac on 16/3/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel
- (id)initWithDic:(NSDictionary *)dic{
    
    self = [super init];
    if (self)
    {
       
       // NSString * name =[NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
        self.name= [self string:[dic objectForKey:@"name"]];
       // NSLog(@"名字是%@",name);
         NSString * xingbie=[NSString stringWithFormat:@"%@",[dic objectForKey:@"sex"]];
        if ([xingbie isEqualToString:@"0"]) {
            self.xingBie=@"女";
        }
        else if ([xingbie isEqualToString:@"1"])
        {
            self.xingBie=@"男";
        }else{
            self.xingBie=@"";
        }
        
        
        NSString * shenfen=[NSString stringWithFormat:@"%@",[dic objectForKey:@"usertype"]];
        self.shenFen=shenfen;
        NSString * a =[self string:[dic objectForKey:@"provname"]];
         NSString * b =[self string:[dic objectForKey:@"cityname"]];
         NSString * c =[self string:[dic objectForKey:@"districtname"]];
       
        [[NSUserDefaults standardUserDefaults]setObject:a forKey:@"sheng1"];
         [[NSUserDefaults standardUserDefaults]setObject:b forKey:@"shi1"];
         [[NSUserDefaults standardUserDefaults]setObject:c forKey:@"xian1"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSString * dq =[NSString stringWithFormat:@"%@-%@-%@",a,b,c];
        self.diQu=dq;
        self.biaoQian=[self string:[dic objectForKey:@"categoryname"]];//[dic objectForKey:@"category"];
        self.jianJie=[self string:[dic objectForKey:@"introduction"]];//[dic objectForKey:@"introduction"];
        self.jingLi=[self string:[dic objectForKey:@"experience"]];//[dic objectForKey:@"experience"];
        self.lineImage= [dic objectForKey:@"headimgurl"];
        self.phone=[self string:[dic objectForKey:@"account"]];//[dic objectForKey:@"account"];
        self.huiyuan=[NSString stringWithFormat:@"%@",[dic objectForKey:@"viplevel"]];//[dic objectForKey:@"viplevel"];
        self.shoujihao=[self string:[dic objectForKey:@"connecttel"]];//[dic objectForKey:@"connecttel"];
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
