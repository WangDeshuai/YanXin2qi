//
//  ZhiYeClassModel.h
//  YanXin
//
//  Created by Macx on 17/1/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZhiYeClassModel : NSObject
//职业的model
@property(nonatomic,copy)NSString * zhiYeName;
@property(nonatomic,copy)NSString * zhiYeNum;
-(id)initWithZhiYeClassDic:(NSDictionary*)dic;
@end
