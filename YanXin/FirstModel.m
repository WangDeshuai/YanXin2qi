//
//  FirstModel.m
//  YanXin
//
//  Created by mac on 16/4/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "FirstModel.h"

@implementation FirstModel
- (id)initWithDic:(NSDictionary *)dic{
    
    self = [super init];
    if (self)
    {
        _imageview=[dic objectForKey:@"logourl"];
        _titleLabel=[dic objectForKey:@"title"];
        _neirongLabel=[dic objectForKey:@"demand"];
        _nowTime=[dic objectForKey:@"addtime"];
        _fabuTime=[dic objectForKey:@"showtime"];
        NSString * didian =[NSString stringWithFormat:@"%@-%@-%@",[dic objectForKey:@"showprov"],[dic objectForKey:@"showcity"],[dic objectForKey:@"showdistrict"]];
        
        _didianLabel=didian;//[dic objectForKey:@"showaddr"];
        _nameLabel=[dic objectForKey:@"linkman"];
        _phoneLabel=[dic objectForKey:@"connecttel"];
        _xiangXi=[dic objectForKey:@"showaddr"];
    }
    
    return self;
    
}
@end
