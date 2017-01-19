//
//  ZhiYeClassModel.m
//  YanXin
//
//  Created by Macx on 17/1/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ZhiYeClassModel.h"

@implementation ZhiYeClassModel
-(id)initWithZhiYeClassDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _zhiYeName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"categoryname"]]];
        _zhiYeNum=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"num"]]];
    }
    
    return self;
}
@end
