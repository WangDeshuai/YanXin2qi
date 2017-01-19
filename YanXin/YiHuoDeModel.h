//
//  YiHuoDeModel.h
//  YanXin
//
//  Created by Macx on 17/1/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YiHuoDeModel : NSObject
@property(nonatomic,copy)NSString * name;//姓名
@property(nonatomic,copy)NSString * headUrl;//头像
@property(nonatomic,copy)NSString * price;//价格
@property(nonatomic,strong)UIImage * vipImage;//会员级别
@property(nonatomic,strong)UIImage * friendImage;//好友直接间接
@property(nonatomic,copy)NSString * time;//时间
-(id)initWithYiHuoDeDic:(NSDictionary*)dic;
@end
