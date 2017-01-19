//
//  FirstModel.h
//  YanXin
//
//  Created by mac on 16/4/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FirstModel : NSObject
@property (nonatomic,copy)NSString * imageview;
@property (nonatomic,copy)NSString * titleLabel;
@property (nonatomic,copy)NSString * neirongLabel;
@property (nonatomic,copy)NSString * didianLabel;
@property (nonatomic,copy)NSString * fabuTime;
@property (nonatomic,copy)NSString * nowTime;
@property (nonatomic,copy)NSString * nameLabel;
@property (nonatomic,copy)NSString * phoneLabel;
@property(nonatomic,copy)NSString* xiangXi;


- (id)initWithDic:(NSDictionary *)dic;

@end
