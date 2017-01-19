//
//  Engine.m
//  YanXin
//
//  Created by Macx on 17/1/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "Engine.h"

@implementation Engine
#pragma mark -- -1app批量上传多个(1-n个)图片base64编码
+(void)ShangChuanImageArrStr:(NSString*)str success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@upload/app_batchUploadImgBase64.action",SER_VICE];
    /*
     //获得的data
     NSData *imageData=dataImage;
     //base编码后
     NSString * endStr =[imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
     
     
     */
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:str forKey:@"imgCodeArr"];
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"-1app批量上传%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"-1app批量上传%@",error);
    }];
    

    
    
}
#pragma mark --2登录
+(void)loginMessageAccount:(NSString*)account Password:(NSString*)pwd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@login/appLogin.action",SER_VICE];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:account forKey:@"account"];
    [dic setObject:pwd forKey:@"password"];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"2登录%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"2登录%@",error);
    }];

    
}

#pragma mark --3个人资料，演员资料修改上传
+(void)upDataMessageAccount:(NSString*)account HeadImageUrl:(UIImage*)imageUrl Name:(NSString*)name Sex:(NSString*)sex PhoneNumber:(NSString*)phone Provname:(NSString*)pro CityName:(NSString*)cityname DistrictName:(NSString*)xianName Category:(NSString*)biaoQ Introduction:(NSString*)jianJie Experience:(NSString*)jingLi success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * strr =[NSString stringWithFormat:@"%@user/modifyPerBaseInfo.action",SER_VICE];
     NSString *urlStr = [strr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
       AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary * dic =[NSMutableDictionary new];
     [dic setObject:account forKey:@"account"];//账号
     [dic setObject:name forKey:@"name"];//姓名
     [dic setObject:sex forKey:@"sex"];//性别
     [dic setObject:phone forKey:@"connecttel"];//联系方式
     [dic setObject:pro forKey:@"provname"];//省
     [dic setObject:cityname forKey:@"cityname"];//市
     [dic setObject:xianName forKey:@"districtname"];//区县
     [dic setObject:biaoQ forKey:@"category"];//标签
     [dic setObject:jianJie forKey:@"introduction"];//简介
     [dic setObject:jingLi forKey:@"experience"];//经历
    NSString *imagetype=@"png";
    NSData *imageData=UIImageJPEGRepresentation(imageUrl, .6);
    [manager  POST:urlStr parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSDateFormatter *formmettrt = [[NSDateFormatter alloc]init];
        [formmettrt setDateFormat:@"yyyyMMddHHmmss"];
        [formData appendPartWithFileData:imageData name:@"headimgurl" fileName:[NSString stringWithFormat:@"%@.%@", [formmettrt stringFromDate:[NSDate date]], imagetype] mimeType:[NSString stringWithFormat:@"image/%@", imagetype]];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"3个人资料，演员资料修改上传%@",str);
        aSuccess(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}






#pragma mark--4查询演员一级分类
+(void)chaXunYanYuanOneClassAll:(NSString*)all success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@category/app_qryFirstLevelCategory.action",SER_VICE];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:all forKey:@"includeAll"];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"4查询演员一级分类%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"4查询演员一级分类%@",error);
    }];
    
}
#pragma mark --5查询二级演员分类
+(void)chaXunerJiClassNum:(NSString*)num All:(NSString*)all success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@category/app_qryChildCategoriesByParentNum.action",SER_VICE];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:all forKey:@"includeAll"];
    [dic setObject:num forKey:@"parentNum"];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"5查询二级演员分类%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"5查询二级演员分类%@",error);
    }];
    
}

#pragma mark --6查询演员
+(void)chaXunYanYuanContentCategory:(NSString*)num Page:(NSString*)page  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
  
    NSString * a =[[NSUserDefaults standardUserDefaults]objectForKey:@"shengz"];
    NSString * b =[[NSUserDefaults standardUserDefaults]objectForKey:@"shiz"];
    NSString * c =[[NSUserDefaults standardUserDefaults]objectForKey:@"xianz"];
    NSString *d =[[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    if (b==nil) {
        b=@"";
    } if(a==nil){
        a=@"";
    } if (c==nil){
        c=@"";
    }if (d==nil) {
        d=@"";
    }
    NSString * urlStr =[NSString stringWithFormat:@"%@actor/app_qryActors.action",SER_VICE];
    NSMutableDictionary * dicc =[NSMutableDictionary new];
    [dicc setObject:a forKey:@"provname"];
    [dicc setObject:b forKey:@"cityname"];
    [dicc setObject:c forKey:@"districtname"];
    [dicc setObject:@"10" forKey:@"pageSize"];
    [dicc setObject:num forKey:@"category"];
    [dicc setObject:page forKey:@"pageIndex"];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dicc success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"6查询演员%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"6查询演员%@",error);
    }];
    
}


#pragma mark --7app升级演员界面，创建演员资料
+(void)appShengJiYanYuanFenLeiNum:(NSString*)num JianJie:(NSString*)jianjie JingLi:(NSString*)jingli Images:(NSString*)imageArr ShiPin:(NSString*)shipin success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    if ([NSUSE_DEFO objectForKey:@"username"]==nil) {
        [LCProgressHUD showMessage:@"7app升级演员界面，创建演员资料您还没有登录"];
        return;
    }
    NSString * strr =[NSString stringWithFormat:@"%@actor/app_setActorInfoInUpgrade.action",SER_VICE];
    NSString *urlStr = [strr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
   
      NSMutableDictionary * dic =[NSMutableDictionary new];
      [dic setObject:[NSUSE_DEFO objectForKey:@"username"] forKey:@"account"];//账号
      [dic setObject:num forKey:@"category"];
      [dic setObject:jianjie forKey:@"introduction"];
      [dic setObject:jingli forKey:@"experience"];
        if (shipin) {
         [dic setObject:shipin forKey:@"videoArr"];
    }
      [dic setObject:imageArr forKey:@"imgArr"];
//     if (shipinArr.count!=0 ) {
//         for (int i =0;i<shipinArr.count;i++) {
//             NSString * shi =[NSString stringWithFormat:@"video%d",i];
//            [dic setObject:shipinArr[i] forKey:shi];
//         }
//     }
    
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"7app升级演员界面，创建演员资料%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"7app升级演员界面，创建演员资料%@",error);
    }];
//    [manager  POST:urlStr parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        
////        NSDateFormatter *formmettrt = [[NSDateFormatter alloc]init];
////        [formmettrt setDateFormat:@"yyyyMMddHHmmss"];
////        
////        if (imageArr.count==0) {
////            
////        }else{
////            for (int i = 0; i < imageArr.count; i++) {
////                UIImage * image= imageArr[i];
////                NSString *imagetype=@"jpg";
////                NSData *data = UIImageJPEGRepresentation(image, 0);
////                NSString *IMAGE=[NSString stringWithFormat:@"img%d",i];
////                [formData appendPartWithFileData:data name:IMAGE fileName:[NSString stringWithFormat:@"%@.%@", [formmettrt stringFromDate:[NSDate date]], imagetype] mimeType:[NSString stringWithFormat:@"image/%@", imagetype]];
////                
////            }
////            
////        }
//        
//        
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
//        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"7app升级演员界面，创建演员资料%@",str);
//        aSuccess(responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"输出错误%@",error);
//    }];
//    
    
}

#pragma mark --8实名认证升级界面
+(void)shiMingRenZhengRealName:(NSString*)name IdCard:(NSString*)idcad ImageZ:(UIImage*)image1 ImageF:(UIImage*)imageF success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    if ([NSUSE_DEFO objectForKey:@"username"]==nil) {
        [LCProgressHUD showMessage:@"8实名认证升级界面您还没有登录"];
        return;
    }
    NSString * strr =[NSString stringWithFormat:@"%@user/app_setUserAuthenticationInUpgrade.action",SER_VICE];
    NSString *urlStr = [strr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[NSUSE_DEFO objectForKey:@"username"] forKey:@"account"];//账号
     [dic setObject:name forKey:@"real_name"];
     [dic setObject:idcad forKey:@"id_card"];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    
    [manager  POST:urlStr parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {//
        if (image1!=nil || imageF!=nil) {
            NSString *imagetype=@"png";
            NSData *imageData=UIImageJPEGRepresentation(image1, 0);
            NSData *imageData2=UIImageJPEGRepresentation(imageF, 0);
            NSDateFormatter *formmettrt = [[NSDateFormatter alloc]init];
            [formmettrt setDateFormat:@"yyyyMMddHHmmss"];
            [formData appendPartWithFileData:imageData name:@"id_card_front" fileName:[NSString stringWithFormat:@"%@.%@", [formmettrt stringFromDate:[NSDate date]], imagetype] mimeType:[NSString stringWithFormat:@"image/%@", imagetype]];
            [formData appendPartWithFileData:imageData2 name:@"id_card_back" fileName:[NSString stringWithFormat:@"%@.%@", [formmettrt stringFromDate:[NSDate date]], imagetype] mimeType:[NSString stringWithFormat:@"image/%@", imagetype]];
        }
        
       
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"8实名认证升级界面%@",str);
        aSuccess(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

#pragma mark --9查询我的资料
+(void)ChaXunMyMessageAccount:(NSString*)account success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@user/qryInfoByAcc.action",SER_VICE];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",account]] forKey:@"account"];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"9查询我的资料%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"9查询我的资料%@",error);
    }];
}
#pragma mark --10查看演员动态
+(void)ChaKanYanYuanDongTaiPage:(NSString*)page Account:(NSString*)account success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
   
    NSString * urlStr =[NSString stringWithFormat:@"%@actor/app_getActorDyByAcc.action",SER_VICE];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:page forKey:@"pageIndex"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",account]] forKey:@"account"];
    [dic setObject:@"10" forKey:@"pageSize"];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"10查看演员动态%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"10查看演员动态%@",error);
    }];

}
#pragma mark --11查看演员基本资料
+(void)ChaKanJiBenZiLiaoAccount:(NSString*)account success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@actor/app_getActorBaseInfoByAcc.action",SER_VICE];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",account]] forKey:@"account"];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"11查看演员基本资料%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"11查看演员基本资料%@",error);
    }];
    
}
#pragma mark --12查询演商//(0.全部演商  3.演出公司 4.演出设备公司 5.演出场地公司
+(void)ChaXunYanShangPage:(NSString*)page Type:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@company/app_qryCompany.action",SER_VICE];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:type forKey:@"type"];
    [dic setObject:page forKey:@"pageIndex"];
    [dic setObject:@"10" forKey:@"pageSize"];
    NSString * a =[[NSUserDefaults standardUserDefaults]objectForKey:@"shengz"];
    NSString * b =[[NSUserDefaults standardUserDefaults]objectForKey:@"shiz"];
    NSString * c =[[NSUserDefaults standardUserDefaults]objectForKey:@"xianz"];
    NSString *d =[[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    if (b==nil) {
        b=@"";
    } if(a==nil){
        a=@"";
    } if (c==nil){
        c=@"";
    }if (d==nil) {
        d=@"";
    }
    [dic setObject:a forKey:@"provname"];
    [dic setObject:b forKey:@"cityname"];
    [dic setObject:c forKey:@"districtname"];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"12查询演商%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"12查询演商%@",error);
    }];
    
}
#pragma mark --13查看演商详细资料
+(void)chaKanXiangQingMessageAccount:(NSString*)account success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@company/app_viewCompanyDetailInfoByAcc.action",SER_VICE];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",account]] forKey:@"account"];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"13查看演商详细资料%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"13查看演商详细资料%@",error);
    }];
    
}

#pragma mark --14查看演商成功案例
+(void)ChanKanYanShangAnLiAccount:(NSString*)account Type:(NSString*)type Page:(NSString*)page success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@company/app_qryCompanySuccessCaseByType.action",SER_VICE];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",account]] forKey:@"account"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",type]] forKey:@"case_type"];
    [dic setObject:@"10" forKey:@"pageSize"];
    [dic setObject:page forKey:@"pageIndex"];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"14查看演商成功案例%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"14查看演商成功案例%@",error);
    }];
    
}
#pragma mark --15查询VIP等级
+(void)ChaXunVIPdengjisuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@vip/app_qryViprule.action",SER_VICE];
   
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"15查询VIP等级%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"15查询VIP等级%@",error);
    }];
    
    
}

#pragma mark --16app查询vip升级等级信息
+(void)ShengJiVipMessagesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@vip/app_qryVipruleInUpgrade.action",SER_VICE];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    //[ToolClass isString:[NSString stringWithFormat:@"%@",[NSUSE_DEFO objectForKey:@"username"]]]
    [dic setObject:@"18514232635" forKey:@"account"];
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"16app查询vip升级等级信息%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"16app查询vip升级等级信息%@",error);
    }];
    
}
#pragma mark--17app充值vip_支付宝支付_获取订单号
+(void)getDingDanNumberAccount:(NSString*)account VipID:(NSString*)vipId YanXinNum:(NSString*)yanxinNum Subject:(NSString*)miaoShu success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@charge/app_aliPay_getOut_trade_noInCharge.action",SER_VICE];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",vipId]] forKey:@"vipId"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",account]] forKey:@"account"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",yanxinNum]] forKey:@"inviter_promote_code"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",miaoShu]] forKey:@"subject"];
    
    [dic setObject:@"ios" forKey:@"osType"];
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"15查询VIP等级%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"15查询VIP等级%@",error);
    }];
    
}
#pragma mark --18app  vip升级_支付宝支付_获取订单号
+(void)ShengJiVIPZhiFuBaoDiJiVIPId:(NSString*)dijiID GaoJiID:(NSString*)gaoJiId Price:(NSString*)price Subject:(NSString*)sub success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlStr =[NSString stringWithFormat:@"%@charge/app_aliPay_getout_trade_noInUpgrade.action",SER_VICE];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",[NSUSE_DEFO objectForKey:@"username"]]] forKey:@"account"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",dijiID]] forKey:@"lowerVipId"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",gaoJiId]] forKey:@"heigherVipId"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",price]] forKey:@"moneyDifference"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",sub]] forKey:@"subject"];
    
    [dic setObject:@"ios" forKey:@"osType"];
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"18app  vip升级_支付宝支付_获取订单号%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"18app  vip升级_支付宝支付_获取订单号%@",error);
    }];
    
}
#pragma mark --19app充值vip_微信预支付
+(void)weiXinPayAccount:(NSString*)account YanXinNum:(NSString*)yanXinNum VIPID:(NSString*)vipID Price:(NSString*)price Body:(NSString*)body success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@charge/app_weixin_perpayInCharge.action",SER_VICE];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    //VIPID
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",vipID]] forKey:@"vipId"];
    //账号
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",account]] forKey:@"account"];
    //演信号
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",yanXinNum]] forKey:@"inviter_promote_code"];
    //价格
     [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",price]] forKey:@"total_fee"];
    //标题
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",body]] forKey:@"body"];
    
    [dic setObject:@"ios" forKey:@"osType"];
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"19app充值vip_微信预支付%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"19app充值vip_微信预支付%@",error);
    }];
}

#pragma mark --20vip升级_微信预支付
+(void)ShengJiWeiXinVIPDiJiID:(NSString*)djID GaoJiID:(NSString*)gaiJiID Price:(NSString*)price Body:(NSString*)body success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    ///
     NSString * urlStr =[NSString stringWithFormat:@"%@charge/app_weixin_perpayInUpgrade.action",SER_VICE];
    
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    //低级ID
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",djID]] forKey:@"lowerVipId"];
    //账号
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",[NSUSE_DEFO objectForKey:@"username"]]] forKey:@"account"];
    //高级ID
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",gaiJiID]] forKey:@"heigherVipId"];
    //价格
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",price]] forKey:@"total_fee"];
    //标题
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",body]] forKey:@"body"];
    
    [dic setObject:@"ios" forKey:@"osType"];
    
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"20vip升级_微信预支付%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"20vip升级_微信预支付%@",error);
    }];
}



#pragma mark --21 查看演员相册(视频)
+(void)ChaKanYanYuanPhotoVitioAccount:(NSString*)account Type:(NSString*)type Page:(NSString*)page PageNum:(NSString*)num success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlStr =[NSString stringWithFormat:@"%@actor/app_queryAlbumByAcc.action",SER_VICE];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    //[ToolClass isString:[NSString stringWithFormat:@"%@",account]]
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",account]] forKey:@"account"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",type]] forKey:@"file_type"];
    [dic setObject:num forKey:@"pageSize"];
    [dic setObject:page forKey:@"pageIndex"];
    //
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"21 查看演员相册(视频)%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"21 查看演员相册(视频)%@",error);
    }];
    
}
#pragma mark --22查询我的好友
+(void)ChaXunMyFriendsZhiJie:(NSString*)type Page:(NSString*)page success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    ///user/app_qryMyFriends.action
    NSString * urlStr =[NSString stringWithFormat:@"%@user/app_qryMyFriends.action",SER_VICE];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",[NSUSE_DEFO objectForKey:@"username"]]] forKey:@"account"];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",type]] forKey:@"relation_grade"];
    [dic setObject:@"10" forKey:@"pageSize"];
    [dic setObject:page forKey:@"pageIndex"];
    //
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"22查询我的好友%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"22查询我的好友%@",error);
    }];
    
}
#pragma mark --23查询已获得的财富
+(void)ChaXunCaiFuPage:(NSString*)page success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    ///user/app_qryMyWealthHaveObtained.action
    NSString * urlStr =[NSString stringWithFormat:@"%@user/app_qryMyWealthHaveObtained.action",SER_VICE];
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",[NSUSE_DEFO objectForKey:@"username"]]] forKey:@"account"];
    
    [dic setObject:@"10" forKey:@"pageSize"];
    [dic setObject:page forKey:@"pageIndex"];
    //
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"23查询已获得的财富%@",str);
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"23查询已获得的财富%@",error);
    }];
    
}
@end
