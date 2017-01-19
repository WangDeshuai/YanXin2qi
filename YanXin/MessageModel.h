//
//  MessageModel.h
//  YanXin
//
//  Created by mac on 16/3/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * xingBie;
@property(nonatomic,copy)NSString * diQu;
@property(nonatomic,copy)NSString * shenFen;
@property(nonatomic,copy)NSString * biaoQian;
@property(nonatomic,copy)NSString * jianJie;
@property(nonatomic,copy)NSString * jingLi;
@property(nonatomic,copy)NSString * lineImage;
@property(nonatomic,copy)NSString * phone;
@property(nonatomic,copy)NSString * huiyuan;
@property(nonatomic,copy)NSString * shoujihao;



- (id)initWithDic:(NSDictionary *)dic;

@end
