//
//  AppDelegate.m
//  YanXin
//
//  Created by mac on 16/2/18.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "LZQStratViewController_25.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "WXApiObject.h"
#define ORDER_PAY_NOTIFICATION @"abc"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSnsPlatformManager.h"
#import "JPUSHService.h"
#import "ViewController.h"
#import <AdSupport/AdSupport.h>
#import "YanYiQuanVC.h"
@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
  //
    
    
 
////友盟APPK
    [UMSocialData setAppKey:@"57200c43e0f55afeba001afb"];
     //[UMSocialData setAppKey:UmengAppkey];
 //qq
    [UMSocialQQHandler setQQWithAppId:@"1105221542" appKey:@"B2FstPjNoCcu3XM4" url:@"https://itunes.apple.com/cn/app/yan-xin-zhong-guo-yan-chu-wang/id1112389632?mt=8"];
 //微信分享
    [UMSocialWechatHandler setWXAppId:@"wx3085116ab6386aaf" appSecret:@"e737784ad482a842cb4b8f65f467bfb7" url:@"https://itunes.apple.com/cn/app/yan-xin-zhong-guo-yan-chu-wang/id1112389632?mt=8"];
//注册
   [WXApi registerApp:@"wx1b5705d0dd1891c0" withDescription:@"yishuPayDes"];
    
    
    
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
     self.window.backgroundColor = [UIColor whiteColor];
    
 
    NSString * star =  [[NSUserDefaults standardUserDefaults] objectForKey:@"star"];
    
    if (star ==nil) {
        LZQStratViewController_25 *lzqStartViewController = [[LZQStratViewController_25 alloc] init];
       
        self.window.rootViewController = lzqStartViewController;
       
    }
    else{
    [[NSUserDefaults standardUserDefaults] setObject:@"star1" forKey:@"nil"];
    [[NSUserDefaults standardUserDefaults] synchronize];
      
        ViewController * vc = [[ViewController alloc]init];
        UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
        self.window.rootViewController = nav;
       

  }
    [self.window makeKeyAndVisible];
    
     [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
   
//    _yvc=[[YanYiQuanVC alloc]init];
//     _yvc.tabBarItem.badgeValue=@"1";
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //       categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound |UIUserNotificationTypeAlert)categories:nil];
    }else {
        //categories    nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound |UIRemoteNotificationTypeAlert)categories:nil];
    }
    
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:advertisingId];
    
    //[self Jpush];
//    YanYiQuanVC * vc =[YanYiQuanVC new];
//    [vc Color];
    return YES;
}

-(void)Jpush{
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
}
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
    NSDictionary * userInfo = [notification userInfo];
    NSDictionary *extras = [userInfo valueForKey:@"extras"];
    //NSLog(@"接收Jpush到的值%@",extras);
    NSString *customizeField1 = [extras valueForKey:@"business_msg"];
   NSLog(@"我看看是Json不%@",customizeField1);
   
    NSNotification * notice =[NSNotification notificationWithName:@"123456" object:self userInfo:extras];
    [[NSNotificationCenter defaultCenter]postNotification:notice];
    
    [[NSUserDefaults standardUserDefaults]setObject:customizeField1 forKey:@"Jpush"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    

}








#pragma mark -- 极光推送
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
   // rootViewController.deviceTokenValueLabel.text =
   // [NSString stringWithFormat:@"%@", deviceToken];
   // rootViewController.deviceTokenValueLabel.textColor =
    [UIColor colorWithRed:0.0 / 255
                    green:122.0 / 255
                     blue:255.0 / 255
                    alpha:1];
    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
}

// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}
#endif

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:%@", [self logDic:userInfo]);
   // [rootViewController addNotificationCount];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:%@", [self logDic:userInfo]);
   // [rootViewController addNotificationCount];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

























#pragma mark--ss

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
   
        
        if ([url.host isEqualToString:@"safepay"]) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"这是首页的结果result = %@",resultDic);
            }];
            return YES;
        }else{
            [WXApi handleOpenURL:url delegate:self];
        }
       
    
    }
    return result;
    
}
-(void) onResp:(BaseResp*)resp
{
    
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp*response=(PayResp*)resp;  // 微信终端返回给第三方的关于支付结果的结构体
        switch (response.errCode) {
            case WXSuccess:
            {// 支付成功，向后台发送消息
                NSLog(@"支付成功");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WX_PaySuccess" object:nil];
            }
                break;
            case WXErrCodeCommon:
            { //签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等
                NSLog(@"支付失败");
                [LCProgressHUD showMessage:@"支付失败"];
            }
                break;
            case WXErrCodeUserCancel:
            { //用户点击取消并返回
                NSLog(@"取消支付");
                [LCProgressHUD showMessage:@"取消支付"];
            }
                break;
            case WXErrCodeSentFail:
            { //发送失败
                NSLog(@"发送失败");
                [LCProgressHUD showMessage:@"发送失败"];
            }
                break;
            case WXErrCodeUnsupport:
            { //微信不支持
                NSLog(@"微信不支持");
                [LCProgressHUD showMessage:@"微信不支持"];
            }
                break;
            case WXErrCodeAuthDeny:
            { //授权失败
                NSLog(@"授权失败");
                [LCProgressHUD showMessage:@"授权失败"];
              
            }
                break;
            default:
                break;
        }
    }
    
    
    
}
// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
        if ([url.host isEqualToString:@"safepay"]) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
              //  NSLog(@"这是首页的结果result = %@",resultDic);
                //创建一个消息对象
                NSNotification * notice = [NSNotification notificationWithName:@"safepay" object:nil userInfo:resultDic];
                //发送消息
                [[NSNotificationCenter defaultCenter]postNotification:notice];
                
            }];
            return YES;
        }else{
            [WXApi handleOpenURL:url delegate:self];
        }
        
        
    }
    return result;
    
}
@end
