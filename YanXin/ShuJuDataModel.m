//
//  ShuJuDataModel.m
//  YanXin
//
//  Created by mac on 16/4/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ShuJuDataModel.h"
#define FUWU @"http://119.29.83.154:8080/"

@implementation ShuJuDataModel
//查询首页演出公告
+(void)huoquFirstPage:(NSString*)page Tiao:(NSString*)type  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError
{
    NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/notice/app_qryNotice.action",FUWU];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlstr parameters:@{@"pageSize":page,@"type":type} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}
//演出公司
+(void)huoquSencondType:(NSString*)type  yeShu:(NSString*)yeshu  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
   
    NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/company/app_qryCompany.action",FUWU];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlstr parameters:@{@"pageSize":yeshu,@"type":type} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    

}

+(void)yanyuansousuosuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
   
     NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/actor/queryActors.action",FUWU];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlstr parameters:@{@"pageIndex":@"0",@"pageSize":@"0",@"category":@"0"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
         aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
 
    

}



@end
