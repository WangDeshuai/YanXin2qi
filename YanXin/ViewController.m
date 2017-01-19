//
//  ViewController.m
//  YanXin
//
//  Created by mac on 16/2/18.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "Reachability.h"//网络监测
#import "JPUSHService.h"
#import "AppDelegate.h"
#import "YanYiQuanVC.h"
#import "MineVC.h"
@interface ViewController ()
{
   YanYiQuanVC *  qvc;
    UINavigationController * nav4;
    UINavigationController * nav3;
    UINavigationController * nav2;
    UINavigationController * nav1;
    UINavigationController * nav5;
    
}
@property(nonatomic,retain)NSMutableArray * array;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor whiteColor];
  
   
    NSString * star = [[NSUserDefaults standardUserDefaults] objectForKey:@"star"];
     NSString * star1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"nil"];
    if (star!=nil && star1==nil) {
        [self gotoNextVC];
    }
    else if(star1!=nil)
    {
        [self gotoNextVC];
    }
   
    
    
}

-(void)gotoNextVC
{
   //2秒过后首先判断网络状态
    [self netWorkTest];
    [self tableBar:nil];
   
}

-(void)image1
{
    UIImageView*bgimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    bgimage.image=[UIImage imageNamed:@"启动页2-5.jpg"];
    [self.view  addSubview:bgimage];
    
}

-(void)netWorkTest
{
    Reachability * reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    //获取当前的监听状态
    NetworkStatus status = [reach currentReachabilityStatus];
    NSString * str = nil;
    switch (status) {
        case kNotReachable:
        {
            
            str=@"网络断开连接";
           
            UIAlertController *alert =[UIAlertController alertControllerWithTitle:nil message:@"网络断开连接" preferredStyle:UIAlertControllerStyleActionSheet];
            
            [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timexioashi:) userInfo:alert repeats:YES];
          
            [self presentViewController:alert animated:YES completion:nil];
            
        }
            break;
        case kReachableViaWiFi:
        {
            // str=@"wifi";
        }
            break;
        case kReachableViaWWAN:
        {
            //  str=@"蜂窝网络";
        }
            break;
            
        default:
            break;
    }
    
}


//网络弹出框消失
-(void)timexioashi:(NSTimer*)theTimer
{
    UIAlertController * promptAlert = (UIAlertController*)[theTimer userInfo];
  //  [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    [promptAlert dismissViewControllerAnimated:YES completion:nil];
    promptAlert = NULL;
}



//tablebar
-(void)tableBar:(NSString*)aa
{
//首页
    ShouYeViewController * svc = [[ShouYeViewController alloc]init];
   nav1 = [[UINavigationController alloc]initWithRootViewController:svc];
    UIImage *fImage1 = [[UIImage imageNamed:@"首页"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *fImgage2 = [[UIImage imageNamed:@"蓝-首页"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //自定义方法
    svc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:fImage1 selectedImage:fImgage2];
    [svc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    [svc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:238/255.0 alpha:1]} forState:UIControlStateSelected];
//演商
    YanShangVC * mvc = [[YanShangVC alloc]init];
    nav2 = [[UINavigationController alloc]initWithRootViewController:mvc];
    
    UIImage * simage1 = [[UIImage imageNamed:@"演商"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * simage2 =[[UIImage imageNamed:@"蓝-演商"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mvc.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"演商" image:simage1 selectedImage:simage2];
    
    [mvc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    
    [mvc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:238/255.0 alpha:1]} forState:UIControlStateSelected];
//演员
    YanYuanVC *  wvc = [[YanYuanVC alloc]init];
    
    nav3 = [[UINavigationController alloc]initWithRootViewController:wvc];
    
    UIImage * simag1 = [[UIImage imageNamed:@"演员"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * simag2 =[[UIImage imageNamed:@"蓝-预定演员"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    wvc.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"演员" image:simag1 selectedImage:simag2];
    
    [wvc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    
    [wvc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:238/255.0 alpha:1]} forState:UIControlStateSelected];
    
//演艺圈
    qvc = [[YanYiQuanVC alloc]init];
    nav4 = [[UINavigationController alloc]initWithRootViewController:qvc];
    UIImage * qimag1 = [[UIImage imageNamed:@"演艺圈"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * qimag2 =[[UIImage imageNamed:@"蓝-演艺圈"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    qvc.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"演艺圈" image:qimag1 selectedImage:qimag2];
   
  //  qvc.tabBarItem.badgeValue=@"1";
    [qvc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    
    [qvc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:238/255.0 alpha:1]} forState:UIControlStateSelected];
    
   
//我的
    MineVC*  avc = [[MineVC alloc]init];
    nav5 = [[UINavigationController alloc]initWithRootViewController:avc];
    UIImage * aimag1 = [[UIImage imageNamed:@"我"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * aimag2 =[[UIImage imageNamed:@"蓝-我"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    avc.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"我" image:aimag1 selectedImage:aimag2];
    
    [avc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    
    [avc.tabBarItem setTitleTextAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:238/255.0 alpha:1]} forState:UIControlStateSelected];
    
      UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UITabBarController * tController = [[UITabBarController alloc]init];
    tController.viewControllers=@[nav1,nav2,nav3,nav4,nav5];
    window.rootViewController=tController;



}
-(void)tableBar1:(NSDictionary*)dicc
{
    NSLog(@"我草%@",dicc);
 //   [self tableBar:@"22"];
}
#pragma mark --极光推送

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
