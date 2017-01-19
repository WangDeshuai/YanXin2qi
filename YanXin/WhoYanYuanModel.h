//
//  WhoYanYuanModel.h
//  YanXin
//
//  Created by mac on 16/3/31.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WhoYanYuanModel : NSObject
//基本信息属性
@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * sex;
@property(nonatomic,copy)NSString * phoneNumber;
@property(nonatomic,copy)NSString * diqu;
@property(nonatomic,copy)NSString * biaoqian;
@property(nonatomic,copy)NSString * myjianjie;
@property(nonatomic,copy)NSString * myjingli;
@property(nonatomic,copy)NSString * imageURL;
@property(nonatomic,assign)BOOL isShiMing;
@property(nonatomic,copy)NSString * zhuCeTime;
@property(nonatomic,copy)NSString * yanXinNum;
@property(nonatomic,strong)UIImage* vipImage;
- (id)initWithDic:(NSDictionary *)dic;
//动态属性
@property(nonatomic,copy)NSString * headId;//动态ID
@property(nonatomic,copy)NSString * headImage;//头像
@property(nonatomic,copy)NSString * headName;//姓名
@property(nonatomic,copy)NSString * headRenZheng;//认证
@property(nonatomic,copy)NSString * headTime;//发布时间
@property(nonatomic,copy)NSString * headConent;//内容
@property(nonatomic,strong)NSArray * headImageArr;//发布的图片
-(id)initWithDongTaiDic:(NSDictionary*)dic;


@end
