//
//  WeiXinModel.h
//  YanXin
//
//  Created by Macx on 16/6/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiXinModel : NSObject
@property(nonatomic,copy)NSString*timestamp;
@property(nonatomic,copy)NSString*partnerid;
@property(nonatomic,copy)NSString*package;
@property(nonatomic,copy)NSString*noncestr;
@property(nonatomic,copy)NSString*sign;
@property(nonatomic,copy)NSString*appid;
@property(nonatomic,copy)NSString*prepayid;
-(id)initWithZhiFuDic:(NSDictionary*)dic;
@end
