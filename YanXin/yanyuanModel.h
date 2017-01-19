//
//  yanyuanModel.h
//  YanXin
//
//  Created by mac on 16/3/30.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface yanyuanModel : NSObject

@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * headimgurl;
@property(nonatomic,copy)NSString * sex;
@property(nonatomic,copy)NSString * sexName;
@property(nonatomic,copy)NSString * categoryname;
@property(nonatomic,copy)NSString * introduction;
@property(nonatomic,copy)NSString * vipname;
@property(nonatomic,strong)UIImage *xingbieImage;
@property(nonatomic,strong)UIImage * vipImage;
@property(nonatomic,strong)UIImage * shiMingImage;
@property(nonatomic,copy)NSString * whoPhone;//其它用户手机号，用来查询相应的动态基本信息

@property(nonatomic,copy)NSString * diqu;
@property(nonatomic,copy)NSString * viplevel;

- (id)initWithDic:(NSDictionary *)dic;
@end
