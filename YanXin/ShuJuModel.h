//
//  ShuJuModel.h
//  YanXin
//
//  Created by mac on 16/3/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SuccessBlock)(NSDictionary * dic);
typedef void (^ErrorBlock)(NSError * error);
@interface ShuJuModel : NSObject

//登陆
+(void)dengLuWithUseName:(NSString*)name password:(NSString*)word success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

//注册
+ (void)registUserWithName:(NSString *)name password:(NSString *)psd Yanzhengma:(NSString*)yanzhengma success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
//保存个人信息(演员)
+(void)saveMyMessageWithName:(NSString*)name xingbie:(NSString*)xingbie address:(NSString*)address identity:(NSString*)shenfen biaoqian:(NSString*)biaoqian myjianjie:(NSString*)jianjie myjingli:(NSString*)jingli lineimage:(NSData*)touxiang phoneNumber:(NSString*)shoujihao success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

//保存个人信息(个人)
+(void)saveMyMessageWithName:(NSString*)name xingbie:(NSString*)xingbie address:(NSString*)address identity:(NSString*)shenfen  lineimage:(NSData*)touxiang phoneNumber:(NSString*)shoujihao  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


//获取个人信息
+(void)myMessageWithsuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;



//首页的轮播视图

+(void)getFirstImage:(NSString*)nage success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;





//保存预定信息
+(void)saveYuDingMyMessageWithTime:(NSString*)time Address:(NSString*)address zhuTi:(NSString*)zhuti YaoQiu:(NSString*)yaoqiu Name:(NSString*)name Phone:(NSString*)phone Type:(NSString*)type Image:(NSData*)image  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
//查询首页演出公告
+(void)huoquFirstPage:(NSString*)page Tiao:(NSString*)type provname:(NSString*)sheng cityname:(NSString*)shi districtname:(NSString*)xian    success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


//演出公司
+(void)huoquSencondType:(NSString*)type yeShu:(NSString*)yeshu   success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;




//演艺圈发布消息
+ (void)publishNeirong:(NSString *)neirong Image:(NSMutableArray*)imageArr success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
//获取演艺圈动态
+(void)huoquWithPage:(NSString*)page Tiaoshu:(NSString*)tiaoshu success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
//获取演员标签
+(void)huoquyanyuanWihBiaoQian:(NSString *)all success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
//演员分类
+(void)chaxunYanyiquanPage:(NSString*)page Tiaogshu:(NSString*)tiaosh Leimu:(NSString*)fenlei   success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
//provname:(NSString*)sheng cityname:(NSString*)city districtname:(NSString*)xian
//获取某个演员的个人信息
+(void)whoWithYanyuan:(NSString*)account success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
//获取某个演员的发布动态
+(void)whoWithDongTai:(NSString*)account  Page:(NSString*)page Tiaoshu:(NSString*)tiaoshu success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
//获取某个演员的相册
+(void)xiangceGetXiangCe:(NSString*)account YeShu:(NSString*)yeshu Tiaoshu:(NSString*)tiaoshu success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


//升级演员
+(void)shengjibiaoqian:(NSString*)biaoqian introduction:(NSString *)jianjie experience:(NSString*)jingli success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


//获取所有省市县
+(void)getshengAllsuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
//根据省查询市
+(void)getcityAll:(NSString*)name  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
//根据市查询县
+(void)getXianAll:(NSString*)cityName success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
//获取所有市
+(void)getshi1Allsuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
//获取所有县
+(void)getxian1Allsuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

//上传点赞
+(void)shangchuanzanLikedyid:(NSString*)qid success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

//回复的
+(void)huifupinglun:(NSString*)qiID Neirong:(NSString*)nr huifuren:(NSString*)men1 huifushui:(NSString*)men2 success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
//修改密码
+(void)xiugaimima:(NSString*)oldword newPsw:(NSString *)newpas success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


//接口获取订单号
+(void)zhifulianjieVIPID:(NSString *)idd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
//充值规则
+(void)chongzhiGuizesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
//注册短信验证
+(void)zhuceDuanXinYanZheng:(NSString*)phoneNumber success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
//找回密码
+(void)zhaohuimima:(NSString*)username pswWord:(NSString*)mima YanzhengM:(NSString*)yanzm success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

+(void)huoquVipTubiaosuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
//删除动态
+(void)shanChuMymessageID:(NSString*)messageID success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --统一下单微信支付
+(void)weixinZhiFuAccount:(NSString*)account vipID:(NSString*)VIPid JiaGe:(NSString*)jiage APPIp:(NSString*)appip Body:(NSString*)body success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

////云通讯短信验证测试
//+(void)duanxinyanzhengsuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;;
+(void)tellPhone:(NSString*)tell;
+ (CGFloat)getWidthWithFontSize:(CGFloat)size height:(CGFloat)height string:(NSString *)string;
@end
