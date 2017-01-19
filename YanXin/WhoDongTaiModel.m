//
//  WhoDongTaiModel.m
//  YanXin
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WhoDongTaiModel.h"

@implementation WhoDongTaiModel
- (id)initWithDic:(NSDictionary *)dic{
    
    self = [super init];
    if (self)
    {
        self.time=[self string:[dic objectForKey:@"addtime"]];//[dic objectForKey:@"addtime"];
        self.neirong=[self string:[dic objectForKey:@"content"]];//[dic objectForKey:@"content"];
         self.picNamesArray=[dic objectForKey:@"imgList"];
        _zhuce=[self string:[dic objectForKey:@"account"]];
        NSString * ss =[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
        _messageID=[self string:ss];
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
