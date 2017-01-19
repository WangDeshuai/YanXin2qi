//
//  NewYanYuanModel.m
//  YanXin
//
//  Created by Macx on 17/1/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "NewYanYuanModel.h"

@implementation NewYanYuanModel
//演员的标签
-(id)initWithBiaoQianDic:(NSDictionary*)dic{
    self=[super init];
    if (self) {
        _biaoQianName=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"categoryname"]]];
        _biaoQianTag=[ToolClass isString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"num"]]];
    }
    
    return self;
}
@end
