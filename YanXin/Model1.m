//
//  Model1.m
//  beauty
//
//  Created by mac on 15-12-22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "Model1.h"
#define FUWU @"http://192.168.1.133:8080/"
@implementation Model1
- (id)initWithDic:(NSDictionary *)dic{
    
    self = [super init];
    if (self)
    {
        self.bgUrl = [dic objectForKey:@"background_pic_url"];
        //首页滚动的
        self.picUrl=  [dic objectForKey:@"imgurl"];
        //跳转的
        self.jumpUrl=[dic objectForKey:@"jumpUrl"];
        self.titleName=[dic objectForKey:@"title"];
        
        
        self.picUrl1=[dic objectForKey:@"pic_url"];
    }
    
    
    return self;
    
}
@end
