//
//  ShuJuModel.m
//  YanXin
//
//  Created by mac on 16/3/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ShuJuModel.h"
//119.29.83.154
//192.168.1.133
#define FUWU @"http://119.29.83.154:8080/"
@implementation ShuJuModel


//登陆
+(void)dengLuWithUseName:(NSString*)name password:(NSString*)word success:(SuccessBlock)aSuccess error:(ErrorBlock)aError
{
    NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/login/appLogin.action",FUWU];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlstr parameters:@{@"account":name,@"password":word} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData * data =[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString * str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
         NSLog(@"登陆%@",str);
        
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}
//注册
+ (void)registUserWithName:(NSString *)name password:(NSString *)psd Yanzhengma:(NSString*)yanzhengma success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
{
     NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/regist/personalRegist.action",FUWU];
   
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
   // [LCLoadingHUD showLoading:@"验证码验证中..."];
    [manager POST:urlstr parameters:@{@"randomStr":yanzhengma,@"account":name,@"password":psd} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData * data =[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString * str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"注册%@",str);
        aSuccess(responseObject);
    } failure:
     ^(AFHTTPRequestOperation *operation, NSError *error) {
         
     }];
    
//    NSURL * url = [NSURL URLWithString:urlstr];
//    __weak ASIFormDataRequest * req = [ASIFormDataRequest requestWithURL:url];
//    [req setPostValue:yanzhengma forKey:@"randomStr"];
//    [req setPostValue:name forKey:@"account"];
//    [req setPostValue:psd forKey:@"password"];
//    [req setCompletionBlock:^{
//        NSLog(@">>>>>%@",req.responseString);
//        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:req.responseData options:NSJSONReadingMutableContainers error:nil];
//        aSuccess(dic);
//    }];
//    [req startAsynchronous];
//    [req  setFailedBlock:^{
//    }];
}

//保存个人信息(演员)
+(void)saveMyMessageWithName:(NSString*)name xingbie:(NSString*)xingbie address:(NSString*)address identity:(NSString*)shenfen biaoqian:(NSString*)biaoqian myjianjie:(NSString*)jianjie myjingli:(NSString*)jingli lineimage:(NSData*)touxiang phoneNumber:(NSString*)shoujihao success:(SuccessBlock)aSuccess error:(ErrorBlock)aError
{
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
     manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSLog(@"%@",address);
    
    NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/user/modifyPerBaseInfo.action",FUWU];
    if (touxiang==nil) {
        touxiang=@"";
    }
    
    NSData *imageData=touxiang;
    NSString *imagetype=@"png";
    NSString * a =[[NSUserDefaults standardUserDefaults]objectForKey:@"sheng1"];
    NSString * b =[[NSUserDefaults standardUserDefaults]objectForKey:@"shi1"];
    NSString * c =[[NSUserDefaults standardUserDefaults]objectForKey:@"xian1"];
    NSString *d =[[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
    if (b==nil) {
        b=@"";
       // [LCLoadingHUD hideInKeyWindow];
        [WINDOW showHUDWithText:@"请填写完信息" Type:ShowPhotoNo Enabled:YES];
        return;
    } if(a==nil){
        a=@"";
       //   [LCLoadingHUD hideInKeyWindow];
        [WINDOW showHUDWithText:@"请填写完信息" Type:ShowPhotoNo Enabled:YES];
        return;
    } if (c==nil){
        c=@"";
        //  [LCLoadingHUD hideInKeyWindow];
        [WINDOW showHUDWithText:@"请填写完信息" Type:ShowPhotoNo Enabled:YES];
        return;
    }if (d==nil) {
        d=@"";
    }if (biaoqian==nil) {
        biaoqian=@"1";
    }

    
    
    NSMutableDictionary * dicc =[NSMutableDictionary new];
    [dicc setObject:shenfen forKey:@"usertype"];
    [dicc setObject:name forKey:@"name"];
    [dicc setObject:xingbie forKey:@"sex"];
    [dicc setObject:d forKey:@"account"];
    
    [dicc setObject:a forKey:@"provname"];
    [dicc setObject:b forKey:@"cityname"];
    [dicc setObject:c forKey:@"districtname"];
    [dicc setObject:biaoqian forKey:@"category"];
    [dicc setObject:jianjie forKey:@"introduction"];
    [dicc setObject:jingli forKey:@"experience"];
   
   [dicc setObject:shoujihao forKey:@"connecttel"];
    
    
    [manager POST:urlstr parameters:dicc constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSDateFormatter *formmettrt = [[NSDateFormatter alloc]init];
        [formmettrt setDateFormat:@"yyyyMMddHHmmss"];
        [formData appendPartWithFileData:imageData name:@"headimgurl" fileName:[NSString stringWithFormat:@"%@.%@", [formmettrt stringFromDate:[NSDate date]], imagetype] mimeType:[NSString stringWithFormat:@"image/%@", imagetype]];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * diccc = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        aSuccess(diccc);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       // NSLog(@"错误%@",error);
    }];

    
    
    
    
}
//保存个人信息(个人)
+(void)saveMyMessageWithName:(NSString*)name xingbie:(NSString*)xingbie address:(NSString*)address identity:(NSString*)shenfen  lineimage:(NSData*)touxiang phoneNumber:(NSString*)shoujihao  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError
{
     NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/user/modifyPerBaseInfo.action",FUWU];
    if (touxiang==nil) {
        touxiang=@"";
    }
    NSData *imageData=touxiang;
    NSString *imagetype=@"png";
    NSString * a =[[NSUserDefaults standardUserDefaults]objectForKey:@"sheng1"];
    NSString * b =[[NSUserDefaults standardUserDefaults]objectForKey:@"shi1"];
    NSString * c =[[NSUserDefaults standardUserDefaults]objectForKey:@"xian1"];
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
    
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dicc =[NSMutableDictionary new];
     [dicc setObject:shenfen forKey:@"usertype"];
     [dicc setObject:name forKey:@"name"];
     [dicc setObject:xingbie forKey:@"sex"];
    
     [dicc setObject:a forKey:@"provname"];
     [dicc setObject:b forKey:@"cityname"];
     [dicc setObject:c forKey:@"districtname"];
    
    [dicc setObject:d forKey:@"account"];
    [dicc setObject:shoujihao forKey:@"connecttel"];
    [manager POST:urlstr parameters:dicc constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSDateFormatter *formmettrt = [[NSDateFormatter alloc]init];
        [formmettrt setDateFormat:@"yyyyMMddHHmmss"];
        [formData appendPartWithFileData:imageData name:@"headimgurl" fileName:[NSString stringWithFormat:@"%@.%@", [formmettrt stringFromDate:[NSDate date]], imagetype] mimeType:[NSString stringWithFormat:@"image/%@", imagetype]];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
      //  NSDictionary * diccc = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
       aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

    
}


//获取个人信息
+(void)myMessageWithsuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/user/qryInfoByAcc.action",FUWU];
    AFHTTPRequestOperationManager * manamger =[AFHTTPRequestOperationManager manager];
    NSString * a =[[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    if (a==nil) {
        a=@"";
    }
    [manamger POST:urlstr parameters:@{@"account":a} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}






+(void)getFirstImage:(NSString*)nage success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/banner/app_getBanners.action",FUWU];
      NSDictionary *parameters = @{@"location":nage};

    AFHTTPRequestOperationManager *manager1 = [AFHTTPRequestOperationManager manager];
    [manager1 POST:urlstr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData * data =[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString * str =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"轮播图%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];



}





//保存预定信息
+(void)saveYuDingMyMessageWithTime:(NSString*)time Address:(NSString*)address zhuTi:(NSString*)zhuti YaoQiu:(NSString*)yaoqiu Name:(NSString*)name Phone:(NSString*)phone Type:(NSString*)type Image:(NSData*)image success:(SuccessBlock)aSuccess error:(ErrorBlock)aError
{
    AFHTTPRequestOperationManager *manager1 = [AFHTTPRequestOperationManager manager];
    manager1.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (image==nil) {
        image=@"";
    }
    NSData *imageData=image;
    NSString *imagetype=@"png";
     NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/notice/modifyNotice.action",FUWU];
    
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"username"] forKey:@"account"];
    [dic setObject:type forKey:@"type"];
    [dic setObject:time forKey:@"showtime"];
    
    [dic setObject:address forKey:@"showaddr"];
//    NSLog(@"省份：%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"shengyu"]);
//     NSLog(@"市区：%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"shiyu"]);
//     NSLog(@"县城：%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"xianyu"]);
    [dic setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"shengyu"] forKey:@"showprov"];
    [dic setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"shiyu"] forKey:@"showcity"];
   [dic setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"xianyu"] forKey:@"showdistrict"];
    [dic setObject:zhuti forKey:@"title"];
    [dic setObject:yaoqiu forKey:@"demand"];
    [dic setObject:name forKey:@"linkman"];
    [dic setObject:phone forKey:@"connecttel"];
    
   
    [manager1  POST:urlstr parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSDateFormatter *formmettrt = [[NSDateFormatter alloc]init];
        [formmettrt setDateFormat:@"yyyyMMddHHmmss"];
        [formData appendPartWithFileData:imageData name:@"logourl" fileName:[NSString stringWithFormat:@"%@.%@", [formmettrt stringFromDate:[NSDate date]], imagetype] mimeType:[NSString stringWithFormat:@"image/%@", imagetype]];
        
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
    //NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
     //   NSDictionary *dic = [self sstringWith:str];
       NSDictionary * diccc = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"这是%@",str);
        aSuccess(diccc);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    


}















//查询首页演出公告
+(void)huoquFirstPage:(NSString*)page Tiao:(NSString*)type provname:(NSString*)sheng cityname:(NSString*)shi districtname:(NSString*)xian    success:(SuccessBlock)aSuccess error:(ErrorBlock)aError
{
   
     NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/notice/app_qryNotice.action",FUWU];
//    
    AFHTTPRequestOperationManager * manage =[AFHTTPRequestOperationManager manager];
    NSMutableDictionary * dicc =[NSMutableDictionary new];
   
    if (sheng==nil) {
        sheng=@"";
    } if(shi==nil){
        shi=@"";
    } if (xian==nil){
        xian=@"";
    }
    [dicc setObject:page forKey:@"pageIndex"];
    [dicc setObject:type forKey:@"type"];
    [dicc setObject:sheng forKey:@"provname"];
    [dicc setObject:shi forKey:@"cityname"];
    [dicc setObject:xian forKey:@"districtname"];
    
    [manage POST:urlstr parameters:dicc success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"查询首页演出公告%@",str);
        aSuccess(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"查询首页演出公告%@",error);
         [LCProgressHUD  hide];
    }];
//
    
    
    
}

//演出公司
+(void)huoquSencondType:(NSString*)type  yeShu:(NSString*)yeshu  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
   
     NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/company/app_qryCompany.action",FUWU];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    
    NSString * a =[[NSUserDefaults standardUserDefaults]objectForKey:@"shengz"];
    NSString * b =[[NSUserDefaults standardUserDefaults]objectForKey:@"shiz"];
    NSString * c =[[NSUserDefaults standardUserDefaults]objectForKey:@"xianz"];
    
    if (b==nil) {
        b=@"";
    } if(a==nil){
        a=@"";
    } if (c==nil){
        c=@"";
    
    }
    
    
    
    NSMutableDictionary * dicc =[NSMutableDictionary new];
    [dicc setObject:a forKey:@"provname"];
    [dicc setObject:b forKey:@"cityname"];
    [dicc setObject:c forKey:@"districtname"];
    [dicc setObject:type forKey:@"type"];
    [dicc setObject:yeshu forKey:@"pageIndex"];
   [manager POST:urlstr parameters:dicc success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        aSuccess(responseObject);
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
   }];
    
    
    
    
//    NSURL * url =[NSURL URLWithString:urlstr];
//    __weak ASIFormDataRequest * req = [ASIFormDataRequest requestWithURL:url];
//    
//    
//    [req setPostValue:[[NSUserDefaults standardUserDefaults]  objectForKey:@"shengz"] forKey:@"provname"];
//    [req setPostValue:[[NSUserDefaults standardUserDefaults]  objectForKey:@"shiz"] forKey:@"cityname"];
//    [req setPostValue:[[NSUserDefaults standardUserDefaults]  objectForKey:@"xianz"] forKey:@"districtname"];
//    
//    
//    [req setPostValue:type forKey:@"type"];
//    [req setPostValue:yeshu forKey:@"pageIndex"];
//    [req setCompletionBlock:^{
//   // NSLog(@"我是演商%@",req.responseString);
//        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:req.responseData options:NSJSONReadingMutableContainers error:nil];
//        aSuccess(dic);
//    }];
//    [req startAsynchronous];
//    [req  setFailedBlock:^{
//        
//    }];


}



//演艺圈发布消息
+ (void)publishNeirong:(NSString *)neirong Image:(NSMutableArray*)imageArr success:(SuccessBlock)aSuccess error:(ErrorBlock)aError
{
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/actor/addDynamic.action",FUWU];
    NSString * a =[[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    if (a==nil) {
        a=@"";
    }if (neirong==nil) {
        neirong=@"";
    }
    NSMutableDictionary * dicc =[NSMutableDictionary new];
    [dicc setObject:a forKey:@"account"];
    [dicc setObject:neirong forKey:@"content"];
    [manager POST:urlstr parameters:dicc constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSDateFormatter *formmettrt = [[NSDateFormatter alloc]init];
        [formmettrt setDateFormat:@"yyyyMMddHHmmss"];
        
        if (imageArr.count==0) {
            
        }else{
            for (int i = 0; i < imageArr.count; i++) {
                UIImage * image= imageArr[i];
                NSString *imagetype=@"jpg";
                NSData *data = UIImageJPEGRepresentation(image, 0);
                NSString *IMAGE=[NSString stringWithFormat:@"IMAGE%d",i];
                [formData appendPartWithFileData:data name:IMAGE fileName:[NSString stringWithFormat:@"%@.%@", [formmettrt stringFromDate:[NSDate date]], imagetype] mimeType:[NSString stringWithFormat:@"image/%@", imagetype]];
                
            }

        }
        
        
        
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
//        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",str);
//        
        NSDictionary * diccc = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        aSuccess(diccc);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

//获取演艺圈动态
+(void)huoquWithPage:(NSString*)page Tiaoshu:(NSString*)tiaoshu success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
   
     NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/actor/queryShowbiz.action",FUWU];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
   
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
   NSDictionary *parameters = @{@"pageIndex":[NSString stringWithFormat:@"%@",page],@"pageSize":[NSString stringWithFormat:@"%@",tiaoshu],@"login_account":d,@"provname":a,@"cityname":b,@"districtname":c};
    
    [manager POST:urlstr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
//        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
//        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"演员数据%@",str);
        
        
        
        aSuccess(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
//
    
    
}
//获取演员标签
+(void)huoquyanyuanWihBiaoQian:(NSString *)all success:(SuccessBlock)aSuccess error:(ErrorBlock)aError
{
    
    NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/actor/queryCategorys.action",FUWU];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlstr parameters:@{@"includeAll":all} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData * data =[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"留言结果%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}

//演员分类
+(void)chaxunYanyiquanPage:(NSString*)page Tiaogshu:(NSString*)tiaosh Leimu:(NSString*)fenlei   success:(SuccessBlock)aSuccess error:(ErrorBlock)aError
{
    
     NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/actor/queryActors.action",FUWU];
    
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    
    
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

    
    
    
    
    NSMutableDictionary * dicc =[NSMutableDictionary new];
    [dicc setObject:a forKey:@"provname"];
    [dicc setObject:b forKey:@"cityname"];
    [dicc setObject:c forKey:@"districtname"];
    [dicc setObject:page forKey:@"pageIndex"];
    [dicc setObject:tiaosh forKey:@"pageSize"];
    [dicc setObject:fenlei  forKey:@"category"];
    
    [manager POST:urlstr parameters:dicc success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData * data =[NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"演员分类%@",str);

        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    
    
}

//获取某个演员的个人信息
+(void)whoWithYanyuan:(NSString*)account success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/actor/app_getActorBaseInfoByAcc.action",FUWU];
    if (account==nil) {
        account=@"";
    }
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlstr parameters:@{@"account":account} success:^(AFHTTPRequestOperation *operation, id responseObject) {
         aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

////获取某个演员的发布动态
+(void)whoWithDongTai:(NSString*)account  Page:(NSString*)page Tiaoshu:(NSString*)tiaoshu success:(SuccessBlock)aSuccess error:(ErrorBlock)aError
{
    
     NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/actor/app_getActorDyByAcc.action",FUWU];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    if (account==nil) {
        account=@"";
    }
    [manager POST:urlstr parameters:@{@"account":account,@"pageIndex":page,@"pageSize":tiaoshu} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"获取某个演员的发布动态%@",str);

        
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    

}
//获取相册
+(void)xiangceGetXiangCe:(NSString*)account YeShu:(NSString*)yeshu Tiaoshu:(NSString*)tiaoshu success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/actor/app_queryAlbumByAcc.action",FUWU];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    if (account==nil) {
        account=@"";
    }
    
    [manager POST:urlstr parameters:@{@"account":account,@"pageSize":tiaoshu,@"pageIndex":yeshu} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    
}



//升级演员
+(void)shengjibiaoqian:(NSString*)biaoqian introduction:(NSString *)jianjie experience:(NSString*)jingli success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
     NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/user/app_upgradeToActor.action",FUWU];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlstr parameters:@{@"account":[[NSUserDefaults standardUserDefaults] objectForKey:@"username"],@"category":biaoqian,@"introduction":jianjie,@"experience":jingli} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}



//获取所有省市县
+(void)getshengAllsuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
   
     NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/admDivison/qryAllProvince.action",FUWU];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlstr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
+(void)getcityAll:(NSString*)name  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
   
     NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/admDivison/qryCitiesByProvinceName.action",FUWU];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlstr parameters:@{@"provinceName":name} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

    
}
//根据市查询县
+(void)getXianAll:(NSString*)cityName success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/admDivison/qryDistrictsByCityName.action",FUWU];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlstr parameters:@{@"cityName":cityName} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
         aSuccess(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

    
}

//获取所有市
+(void)getshi1Allsuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
   
    NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/admDivison/qryAllCity.action",FUWU];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlstr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];



}
//获取所有县
+(void)getxian1Allsuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
   
    NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/admDivison/qryAllDistrict.action",FUWU];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlstr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}



//上传点赞
+(void)shangchuanzanLikedyid:(NSString*)qid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/actor/app_modifyPraise.action",FUWU];
    
    NSString * a =[[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    if (a==nil) {
        a=@"";
    }
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlstr parameters:@{@"praccount":a,@"dyid":qid} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}
//回复的
+(void)huifupinglun:(NSString*)qiID Neirong:(NSString*)nr huifuren:(NSString*)men1 huifushui:(NSString*)men2 success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
     NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/actor/addDiscuss.action",FUWU];
    NSMutableDictionary * dicc =[NSMutableDictionary new];
    [dicc setObject:qiID forKey:@"dyid"];
    [dicc setObject:men1 forKey:@"disaccount"];
    [dicc setObject:men2 forKey:@"berepliedaccount"];
    [dicc setObject:nr forKey:@"content"];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlstr parameters:dicc success:^(AFHTTPRequestOperation *operation, id responseObject) {
         aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];


}

//修改密码
+(void)xiugaimima:(NSString*)oldword newPsw:(NSString *)newpas success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
   
    NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/user/app_updateOldPassword.action",FUWU];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSString * a =[[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    if (a==nil) {
        a=@"";
    }
    [manager POST:urlstr parameters:@{@"account":a,@"psw_old":oldword,@"psw_new":newpas} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    

}


+(void)chongzhiGuizesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/vip/app_qryViprule.action",FUWU];
    NSLog(@"%@",urlstr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlstr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

    
    
}

//接口获取订单号
+(void)zhifulianjieVIPID:(NSString *)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/charge/app_getout_trade_no.action",FUWU];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSString * a =[[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    if (a==nil) {
        a=@"";
    }
    [manager POST:urlstr parameters:@{@"account":a,@"vipId":idd,@"osType":@"ios"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
          aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}

//注册短信验证
+(void)zhuceDuanXinYanZheng:(NSString*)phoneNumber success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/sms/sendVerificationCode.action",FUWU];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlstr parameters:@{@"telNum":phoneNumber} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        aSuccess(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];


    
    
}


//找回密码
+(void)zhaohuimima:(NSString*)username pswWord:(NSString*)mima YanzhengM:(NSString*)yanzm success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    
    NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/user/app_resetPassword.action",FUWU];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlstr parameters:@{@"account":username,@"password":mima,@"randomStr":yanzm} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
}


+(void)huoquVipTubiaosuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/vip/app_qryIsShowVipImg.action",FUWU];
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
   // NSLog(@">>>%@",urlstr);
    [manager GET:urlstr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    
}

+ (CGFloat)getWidthWithFontSize:(CGFloat)size height:(CGFloat)height string:(NSString *)string{
    
    if (![string isKindOfClass:[NSString class]]) {
        return 0;
    }
    //    NSDictionary *dict = @{NSFontAttributeName : [UIFont fontWithName:@"FZLTXHK--GBK1-0" size:size]};
    NSDictionary *dict = @{NSFontAttributeName : [UIFont systemFontOfSize:size]};
    
    CGSize textSize = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin  attributes:dict context:nil].size;
    return textSize.width;
}

//删除动态
+(void)shanChuMymessageID:(NSString*)messageID success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
    NSString * urlstr =[NSString stringWithFormat:@"%@YanXinManage/showbizManage/app_deleDynamic.action?id=%@",FUWU,messageID];
    
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
     NSLog(@"删除动态的>>>%@",urlstr);
    [manager GET:urlstr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
#pragma mark --微信预支付
+(void)weixinZhiFuAccount:(NSString*)account vipID:(NSString*)VIPid JiaGe:(NSString*)jiage APPIp:(NSString*)appip Body:(NSString*)body success:(SuccessBlock)aSuccess error:(ErrorBlock)aError{
   
    NSMutableDictionary * dicc =[NSMutableDictionary new];
    if (account && VIPid && jiage &&appip) {
        [dicc setObject:account forKey:@"account"];
        [dicc setObject:VIPid forKey:@"vipId"];
        [dicc setObject:jiage forKey:@"total_fee"];
        [dicc setObject:appip forKey:@"spbill_create_ip"];
        [dicc setObject:@"ios" forKey:@"osType"];
        [dicc setObject:body forKey:@"body"];
    }else{
        NSLog(@"参数不全");
    }
    NSString *urlStr =[NSString stringWithFormat:@"%@YanXinManage/charge/app_weixin_perpay.action",FUWU];
    NSLog(@"这是url>>>%@",urlStr);
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    [manager POST:urlStr parameters:dicc success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"返回的结果%@",str);
         aSuccess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"这是urlwww>>>%@",urlStr);

       // NSLog(@"%@",error);
    }];
    
}
+(void)tellPhone:(NSString*)tell{
    //联系我们
    NSString *allString = [NSString stringWithFormat:@"tel:%@",tell];
    NSString*telUrl = [allString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telUrl]];
}

@end
