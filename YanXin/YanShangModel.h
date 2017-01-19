//
//  YanShangModel.h
//  YanXin
//
//  Created by mac on 16/4/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YanShangModel : NSObject

@property (nonatomic, copy) NSString *titleName;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *imageVIPName;
@property (nonatomic, copy) NSString *jianJie;

@property (nonatomic, copy) NSString *anli;
@property (nonatomic, copy) NSMutableArray *anliArr;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *dizhi;
@property (nonatomic, copy) NSString *viplevel;
//演出场地才会有
@property(nonatomic,retain)NSMutableArray * huiyishi;
@property(nonatomic,retain)NSMutableArray * kefang;
- (id)initWithDic:(NSDictionary *)dic;

//演出公司
@property (nonatomic, copy) NSString *headImageUrl;//头像
@property (nonatomic, copy) NSString *title;//标题
@property (nonatomic, copy) NSString *content;//内容
@property (nonatomic, copy) NSString *renZheng;//认证
@property(nonatomic,strong)UIImage * vipImage;//vip等级
@property(nonatomic,copy)NSString * yanShangID;
@property(nonatomic,copy)NSString * yanShangAccount;
-(id)initWithYanChuCommnyDic:(NSDictionary*)dic;
@end
