//
//  MyFriendsModel.h
//  YanXin
//
//  Created by Macx on 17/1/18.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyFriendsModel : NSObject
#pragma mark --直接好友
@property(nonatomic,copy)NSString* headStr;
@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* yanXinNum;
@property(nonatomic,copy)NSString* time;
@property(nonatomic,strong)UIImage * vipImage;
-(id)initWithZhiJieDic:(NSDictionary*)dic;
@end
