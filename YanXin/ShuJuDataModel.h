//
//  ShuJuDataModel.h
//  YanXin
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SuccessBlock)(NSDictionary * dic);
typedef void (^ErrorBlock)(NSError * error);
@interface ShuJuDataModel : NSObject

//查询首页演出公告
+(void)huoquFirstPage:(NSString*)page Tiao:(NSString*)type  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

//演出公司
+(void)huoquSencondType:(NSString*)type yeShu:(NSString*)yeshu   success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

//演员搜索
+(void)yanyuansousuosuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

@end
