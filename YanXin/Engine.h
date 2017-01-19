//
//  Engine.h
//  YanXin
//
//  Created by Macx on 17/1/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SuccessBlock)(NSDictionary * dic);
typedef void (^ErrorBlock)(NSError * error);

@interface Engine : NSObject

#pragma mark -- -1app批量上传多个(1-n个)图片base64编码
+(void)ShangChuanImageArrStr:(NSString*)str success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --2登录
+(void)loginMessageAccount:(NSString*)account Password:(NSString*)pwd success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;



#pragma mark --3个人资料，演员资料修改上传
+(void)upDataMessageAccount:(NSString*)account HeadImageUrl:(UIImage*)imageUrl Name:(NSString*)name Sex:(NSString*)sex PhoneNumber:(NSString*)phone Provname:(NSString*)pro CityName:(NSString*)cityname DistrictName:(NSString*)xianName Category:(NSString*)biaoQ Introduction:(NSString*)jianJie Experience:(NSString*)jingLi success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;




#pragma mark--4查询演员一级分类
+(void)chaXunYanYuanOneClassAll:(NSString*)all success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --5查询二级演员分类
+(void)chaXunerJiClassNum:(NSString*)num All:(NSString*)all success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark --6查询演员
+(void)chaXunYanYuanContentCategory:(NSString*)num Page:(NSString*)page  success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --7app升级演员界面，创建演员资料
+(void)appShengJiYanYuanFenLeiNum:(NSString*)num JianJie:(NSString*)jianjie JingLi:(NSString*)jingli Images:(NSString*)imageArr ShiPin:(NSString*)shipin success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --8实名认证升级界面
+(void)shiMingRenZhengRealName:(NSString*)name IdCard:(NSString*)idcad ImageZ:(UIImage*)image1 ImageF:(UIImage*)imageF success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --9查询我的资料
+(void)ChaXunMyMessageAccount:(NSString*)account success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;


#pragma mark --10查看演员动态
+(void)ChaKanYanYuanDongTaiPage:(NSString*)page Account:(NSString*)account success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --11查看演员基本资料
+(void)ChaKanJiBenZiLiaoAccount:(NSString*)account success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --12查询演商//(0.全部演商  3.演出公司 4.演出设备公司 5.演出场地公司
+(void)ChaXunYanShangPage:(NSString*)page Type:(NSString*)type success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --13查看演商详细资料
+(void)chaKanXiangQingMessageAccount:(NSString*)account success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --14查看演商成功案例
+(void)ChanKanYanShangAnLiAccount:(NSString*)account Type:(NSString*)type Page:(NSString*)page success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --15查询VIP等级
+(void)ChaXunVIPdengjisuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --16app查询vip升级等级信息
+(void)ShengJiVipMessagesuccess:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark--17app充值vip_支付宝支付_获取订单号
+(void)getDingDanNumberAccount:(NSString*)account VipID:(NSString*)vipId YanXinNum:(NSString*)yanxinNum Subject:(NSString*)miaoShu success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --18app  vip升级_支付宝支付_获取订单号
+(void)ShengJiVIPZhiFuBaoDiJiVIPId:(NSString*)dijiID GaoJiID:(NSString*)gaoJiId Price:(NSString*)price Subject:(NSString*)sub success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --19app充值vip_微信预支付
+(void)weiXinPayAccount:(NSString*)account YanXinNum:(NSString*)yanXinNum VIPID:(NSString*)vipID Price:(NSString*)price Body:(NSString*)body success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --20vip升级_微信预支付
+(void)ShengJiWeiXinVIPDiJiID:(NSString*)djID GaoJiID:(NSString*)gaiJiID Price:(NSString*)price Body:(NSString*)body success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

#pragma mark --21 查看演员相册(视频)
+(void)ChaKanYanYuanPhotoVitioAccount:(NSString*)account Type:(NSString*)type Page:(NSString*)page PageNum:(NSString*)num success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --22查询我的好友
+(void)ChaXunMyFriendsZhiJie:(NSString*)type Page:(NSString*)page success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;
#pragma mark --23查询已获得的财富
+(void)ChaXunCaiFuPage:(NSString*)page success:(SuccessBlock)aSuccess error:(ErrorBlock)aError;

@end
