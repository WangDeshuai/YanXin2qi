//
//  WeiXinModel.m
//  YanXin
//
//  Created by Macx on 16/6/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WeiXinModel.h"

@implementation WeiXinModel
-(id)initWithZhiFuDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _timestamp=[self string:[dic objectForKey:@"timestamp"]];
        _partnerid=[self string:[dic objectForKey:@"partnerid"]];
        _package=[self string:[dic objectForKey:@"package"]];
        _noncestr=[self string:[dic objectForKey:@"noncestr"]];
        _sign=[self string:[dic objectForKey:@"sign"]];
        _appid=[self string:[dic objectForKey:@"appid"]];
        _prepayid=[self string:[dic objectForKey:@"prepayid"]];
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
