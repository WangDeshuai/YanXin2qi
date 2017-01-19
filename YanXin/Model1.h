//
//  Model1.h
//  beauty
//
//  Created by mac on 15-12-22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model1 : NSObject
@property (nonatomic,copy) NSString *bgUrl;
//首页轮播图的url
@property (nonatomic,copy) NSString *picUrl;
@property (nonatomic,copy) NSString *jumpUrl;
@property (nonatomic,copy)NSString * titleName;

//试用美丽衣橱
@property (nonatomic,copy) NSString *picUrl1;




- (id)initWithDic:(NSDictionary *)dic;

@end
