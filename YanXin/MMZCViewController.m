//
//  MMZCViewController.m
//  MMR
//
//  Created by qianfeng on 15/6/30.
//  Copyright © 2015年 MaskMan. All rights reserved.
//

#import "MMZCViewController.h"
#import "MMZCHMViewController.h"
#import "ZhangHuiMiMa.h"
#import "JPUSHService.h"

@interface MMZCViewController ()
{
    UIImageView *View;
    UIView *bgView;
    UITextField *pwd;
    UITextField *user;
    UIButton *QQBtn;
    UIButton *weixinBtn;
    UIButton *xinlangBtn;
    MessageModel * model;
}
@property(copy,nonatomic) NSString * accountNumber;
@property(copy,nonatomic) NSString * mmmm;
//@property(copy,nonatomic) NSString * user;


@end

@implementation MMZCViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    //设置NavigationBar背景颜色
    View=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //View.backgroundColor=[UIColor redColor];
    View.image=[UIImage imageNamed:@"bg4.jpg"];
    [self.view addSubview:View];
    

    UIView * view1 =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KUAN, 64)];
    view1.backgroundColor=[UIColor colorWithRed:0/255.0 green:170/255.0 blue:238/255.0 alpha:1];
    [self.view addSubview:view1];
    
    
    //为了显示背景图片自定义navgationbar上面的三个按钮
    UIButton *but =[[UIButton alloc]initWithFrame:CGRectMake(5, 27, 35, 35)];
    [but setImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(clickaddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:but];
    
    UIButton *zhuce =[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60, 30, 50, 30)];
    [zhuce setTitle:@"注册" forState:UIControlStateNormal];
    [zhuce setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    zhuce.titleLabel.font=[UIFont systemFontOfSize:17];
    [zhuce addTarget:self action:@selector(zhuce) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:zhuce];
    
   
    UILabel *lanel=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-30)/2, 30, 50, 30)];
    lanel.text=@"登录";
    
    lanel.textColor=[UIColor whiteColor];
    [view1 addSubview:lanel];

    
    [self createButtons];
    [self createImageViews];
    [self createTextFields];
    
  //  [self createLabel];
}

-(void)clickaddBtn:(UIButton *)button
{

    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)createLabel
{

}

-(void)createTextFields
{
    CGRect frame=[UIScreen mainScreen].bounds;
    bgView=[[UIView alloc]initWithFrame:CGRectMake(10, 75+50, frame.size.width-20, 100)];
    bgView.layer.cornerRadius=3.0;
    bgView.alpha=0.7;
    bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bgView];
    
    user=[self createTextFielfFrame:CGRectMake(60, 10, 271, 30) font:[UIFont systemFontOfSize:14] placeholder:@"请输入您手机号码"];
    //user.text=@"13419693608";
    user.keyboardType=UIKeyboardTypeNumberPad;
    user.clearButtonMode = UITextFieldViewModeWhileEditing;
   
    pwd=[self createTextFielfFrame:CGRectMake(60, 60, 271, 30) font:[UIFont systemFontOfSize:14]  placeholder:@"密码" ];
    pwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    //pwd.text=@"123456";
    //密文样式
    pwd.secureTextEntry=YES;
    //pwd.keyboardType=UIKeyboardTypeNumberPad;

    
    UIImageView *userImageView=[self createImageViewFrame:CGRectMake(20, 13, 20, 20) imageName:@"login_admin" color:nil];
    UIImageView *pwdImageView=[self createImageViewFrame:CGRectMake(20, 63, 35/2, 43/2) imageName:@"login_password" color:nil];
    UIImageView *line1=[self createImageViewFrame:CGRectMake(20, 50, bgView.frame.size.width-40, 1) imageName:nil color:[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:.3]];
    
    [bgView addSubview:user];
    [bgView addSubview:pwd];
    
    [bgView addSubview:userImageView];
    [bgView addSubview:pwdImageView];
    [bgView addSubview:line1];
}


-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [user resignFirstResponder];
    [pwd resignFirstResponder];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [user resignFirstResponder];
    [pwd resignFirstResponder];
}

-(void)createImageViews
{
    
//    UIImageView *line3=[self createImageViewFrame:CGRectMake(2, 450*GAO/667, 100, 1) imageName:nil color:[UIColor lightGrayColor]];
//    UIImageView *line4=[self createImageViewFrame:CGRectMake(self.view.frame.size.width-100-4, 450*GAO/667, 100, 1) imageName:nil color:[UIColor lightGrayColor]];
//    
//   
//    [self.view addSubview:line3];
//    [self.view addSubview:line4];
    
}


-(void)createButtons
{
    UIButton *landBtn=[self createButtonFrame:CGRectMake(10, 190+50, self.view.frame.size.width-20, 37) backImageName:nil title:@"登录" titleColor:[UIColor whiteColor]  font:[UIFont systemFontOfSize:19] target:self action:@selector(landClick)];
    landBtn.backgroundColor=[UIColor colorWithRed:0/255.0 green:170/255.0 blue:238/255.0 alpha:1];
    landBtn.layer.cornerRadius=5.0f;
    
 //   UIButton *newUserBtn=[UIButton buttonWithType:UIButtonTypeCustom];
   // newUserBtn.frame=CGRectMake(5, 235+50, <#CGFloat width#>, <#CGFloat height#>)
     newUserBtn=[self createButtonFrame:CGRectMake(10, 235+55, 70, 15) backImageName:nil title:@"" titleColor:[UIColor grayColor] font:[UIFont systemFontOfSize:13] target:self action:@selector(registration:)];
    [newUserBtn setBackgroundImage:[UIImage imageNamed:@"mima1"] forState:0];
    [newUserBtn setBackgroundImage:[UIImage imageNamed:@"mima2"] forState:UIControlStateSelected];
    newUserBtn.selected=NO;
    //newUserBtn.backgroundColor=[UIColor lightGrayColor];
    
    UIButton *forgotPwdBtn=[self createButtonFrame:CGRectMake(self.view.frame.size.width-75, 235+50, 60, 30) backImageName:nil title:@"找回密码" titleColor:[UIColor grayColor] font:[UIFont systemFontOfSize:13] target:self action:@selector(fogetPwd:)];
    //fogotPwdBtn.backgroundColor=[UIColor lightGrayColor];
  
    
      #define Start_X 60.0f           // 第一个按钮的X坐标
      #define Start_Y 440.0f           // 第一个按钮的Y坐标
      #define Width_Space 50.0f        // 2个按钮之间的横间距
      #define Height_Space 20.0f      // 竖间距
      #define Button_Height 50.0f    // 高
      #define Button_Width 50.0f      // 宽


//    
//    //微信
//    weixinBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-50)/2, 490*GAO/667, 50, 50)];
//    //weixinBtn.tag = UMSocialSnsTypeWechatSession;
//    weixinBtn.layer.cornerRadius=25;
//    weixinBtn=[self createButtonFrame:weixinBtn.frame backImageName:@"ic_landing_wechat" title:nil titleColor:nil font:nil target:self action:@selector(onClickWX:)];
//    //qq
//    QQBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-50)/2-100, 490*GAO/667, 50, 50)];
//    //QQBtn.tag = UMSocialSnsTypeMobileQQ;
//    QQBtn.layer.cornerRadius=25;
//    QQBtn=[self createButtonFrame:QQBtn.frame backImageName:@"ic_landing_qq" title:nil titleColor:nil font:nil target:self action:@selector(onClickQQ:)];
//    
//    //新浪微博
//    xinlangBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-50)/2+100, 490*GAO/667, 50, 50)];
//    //xinlangBtn.tag = UMSocialSnsTypeSina;
//    xinlangBtn.layer.cornerRadius=25;
//    xinlangBtn=[self createButtonFrame:xinlangBtn.frame backImageName:@"ic_landing_microblog" title:nil titleColor:nil font:nil target:self action:@selector(onClickSina:)];
    
//    [self.view addSubview:weixinBtn];
//    [self.view addSubview:QQBtn];
//    [self.view addSubview:xinlangBtn];
    [self.view addSubview:landBtn];
    [self.view addSubview:newUserBtn];
    [self.view addSubview:forgotPwdBtn];

    
}


- (void)onClickQQ:(UIButton *)button
{
//    //例如QQ的登录
//    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
//           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
//     {
//         if (state == SSDKResponseStateSuccess)
//         {
//             
//             NSLog(@"uid=%@",user.uid);
//             NSLog(@"%@",user.credential);
//             NSLog(@"token=%@",user.credential.token);
//             NSLog(@"nickname=%@",user.nickname);
//         }
//         
//         else
//         {
//             NSLog(@">>>>>%@",error);
//         }
//         
//     }];


}

- (void)onClickWX:(UIButton *)button
{
}


- (void)onClickSina:(UIButton *)button
{
//    //例如QQ的登录
//    [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo
//           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
//     {
//         if (state == SSDKResponseStateSuccess)
//         {
//             
//             NSLog(@"uid=%@",user.uid);
//             NSLog(@"%@",user.credential);
//             NSLog(@"token=%@",user.credential.token);
//             NSLog(@"nickname=%@",user.nickname);
//         }
//         
//         else
//         {
//             NSLog(@">>>>>%@",error);
//         }
//         
//     }];

}

                     
-(UITextField *)createTextFielfFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder
{
    UITextField *textField=[[UITextField alloc]initWithFrame:frame];
    
    textField.font=font;
    
    textField.textColor=[UIColor grayColor];
    
    textField.borderStyle=UITextBorderStyleNone;
    
    textField.placeholder=placeholder;
    
    return textField;
}

-(UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName color:(UIColor *)color
{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:frame];
    
    if (imageName)
    {
        imageView.image=[UIImage imageNamed:imageName];
    }
    if (color)
    {
        imageView.backgroundColor=color;
    }
    
    return imageView;
}

-(UIButton *)createButtonFrame:(CGRect)frame backImageName:(NSString *)imageName title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font target:(id)target action:(SEL)action
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    if (imageName)
    {
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    if (font)
    {
        btn.titleLabel.font=font;
    }
    
    if (title)
    {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (color)
    {
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
    if (target&&action)
    {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

#pragma mark --登录按钮
-(void)landClick{
    [LCProgressHUD showLoading:@"正在登录..."];
    [Engine loginMessageAccount:user.text Password:pwd.text success:^(NSDictionary *dic) {
        [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        NSString * code =[NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSDictionary * contentDic =[dic objectForKey:@"content"];
            NSDictionary * userInfoDic =[contentDic objectForKey:@"userInfo"];
            //取出regist_id，推送用
            NSString * registId=[NSString stringWithFormat:@"%@",[userInfoDic objectForKey:@"regist_id"]];
            [self JpushAlias:registId];
            //取出手机用来判断是否登录
            [NSUSE_DEFO setObject:[ToolClass isString:[userInfoDic objectForKey:@"account"]] forKey:@"username"];
            [NSUSE_DEFO setObject:[ToolClass isString:[NSString stringWithFormat:@"%@",[userInfoDic objectForKey:@"usertype"]]] forKey:@"VIP"];
            [NSUSE_DEFO synchronize];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else
        {
            [LCProgressHUD showMessage:[dic objectForKey:@"msg"]];
        }
        
        
    } error:^(NSError *error) {
        
    }];
}
////登录
//-(void)landClick
//{
//    
//   
//
//       [ShuJuModel dengLuWithUseName:user.text password:pwd.text success:^(NSDictionary *dic) {
//           
//           NSString * code =[dic objectForKey:@"code"];
//           NSString * codee =[NSString stringWithFormat:@"%@",code];
//           if ([codee isEqualToString:@"1"]) {
//               
//               NSDictionary * dicc =[dic objectForKey:@"content"];
//               NSDictionary * userInfo =[dicc objectForKey:@"userInfo"];
//               NSString * registId=[NSString stringWithFormat:@"%@",[userInfo objectForKey:@"regist_id"]];
//               [self JpushAlias:registId];
//               
//               //登陆成功后服务器会返回用户信息，把其中的用户名存储起来,加以判断是否登陆
//               [[NSUserDefaults standardUserDefaults] setObject:user.text forKey:@"username"];
//               [[NSUserDefaults standardUserDefaults] synchronize];
//               [WINDOW showHUDWithText:@"登录成功" Type:ShowPhotoYes Enabled:YES];
//              // [LCLoadingHUD hideInKeyWindow];
//               [self dismissViewControllerAnimated:YES completion:nil];
//           }else
//           {
//               
//               [WINDOW showHUDWithText:[dic objectForKey:@"msg"] Type:ShowPhotoNo Enabled:YES];
//              //  [LCLoadingHUD hideInKeyWindow];
//           }
// 
//           
//           
//       } error:^(NSError *error) {
//           
//       }];
//        

//}

//注册
-(void)zhuce
{
    MMZCHMViewController * vc = [[MMZCHMViewController alloc]init];
    vc.pswNameBlock=^(NSString*name,NSString*psw){
        user.text=name;
        pwd.text=psw;
    };
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark --数据请求登陆



-(void)viewWillAppear:(BOOL)animated{
    
  NSString * a=  [[NSUserDefaults standardUserDefaults] objectForKey:@"jizhu"];
  NSString* b=  [[NSUserDefaults standardUserDefaults] objectForKey:@"jizhumima"];
    if (a!=nil&&b!=nil  ) {
        user.text=a;
        pwd.text=b;
        newUserBtn.selected=YES;
    }
    
    
    
}





-(void)registration:(UIButton *)button
{
    // [req setPostValue:user.text forKey:@"account"];
    //[req setPostValue:pwd.text forKey:@"password"];
   
    
    if ([user.text isEqualToString:@""] || [pwd.text isEqualToString:@""]) {
       
    }else{
         button.selected=!button.selected;
        if (button.selected==YES) {
            [[NSUserDefaults standardUserDefaults]setObject:user.text forKey:@"jizhu"];
            [[NSUserDefaults standardUserDefaults]setObject:pwd.text forKey:@"jizhumima"];
        }else if (button.selected==NO){
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"jizhu"];            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"jizhumima"];
        }
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
    
    
}
//找回密码
-(void)fogetPwd:(UIButton *)button
{
    ZhangHuiMiMa * vc =[ZhangHuiMiMa new];
    [self presentViewController:vc animated:YES completion:nil];
   // [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 工具

-(void)JpushAlias:(NSString*)bieMing{
   // NSLog(@"我看看报名有没有数据%@",bieMing);
//   // [JPUSHService setTags:nil
//                    alias:bieMing
//         callbackSelector:@selector(tagsAliasCallback:tags:alias:)
//                   target:self];
    
    
    /*
     + (void)setTags:(NSSet *)tags
     alias:(NSString *)alias
     fetchCompletionHandle:(void (^)(int iResCode, NSSet *iTags, NSString *iAlias))completionHandler;
     */
    
    [JPUSHService setTags:nil alias:bieMing fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        NSLog(@"看看结果%@",iAlias);
    }];
    
    
}

//- (void)tagsAliasCallback:(int)iResCode
//                     tags:(NSSet *)tags
//                    alias:(NSString *)alias {
//    NSString *callbackString =[NSString stringWithFormat:@"%d, \ntags: %@, \nalias: %@\n", iResCode,
//     [self logSet:tags], alias];
//   
//    NSLog(@"TagsAlias回调:%@", callbackString);
//}
//- (NSString *)logSet:(NSSet *)dic {
//    if (![dic count]) {
//        return nil;
//    }
//    NSString *tempStr1 =
//    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
//                                                 withString:@"\\U"];
//    NSString *tempStr2 =
//    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
//    NSString *tempStr3 =
//    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
//    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *str =
//    [NSPropertyListSerialization propertyListFromData:tempData
//                                     mutabilityOption:NSPropertyListImmutable
//                                               format:NULL
//                                     errorDescription:NULL];
//    return str;
//}
////手机号格式化
//-(NSString*)getHiddenStringWithPhoneNumber:(NSString*)number middle:(NSInteger)countHiiden{
//    // if (number.length>6) {
//    
//    if (number.length<countHiiden) {
//        return number;
//    }
//    NSInteger count=countHiiden;
//    NSInteger leftCount=number.length/2-count/2;
//    NSString *xings=@"";
//    for (int i=0; i<count; i++) {
//        xings=[NSString stringWithFormat:@"%@%@",xings,@"*"];
//    }
//    
//    NSString *chuLi=[number stringByReplacingCharactersInRange:NSMakeRange(leftCount, count) withString:xings];
//    // chuLi=[chuLi stringByReplacingCharactersInRange:NSMakeRange(number.length-count, count-leftCount) withString:xings];
//    
//    return chuLi;
//}

////手机号格式化后还原
//-(NSString*)getHiddenStringWithPhoneNumber1:(NSString*)number middle:(NSInteger)countHiiden{
//    // if (number.length>6) {
//    if (number.length<countHiiden) {
//        return number;
//    }
//    NSString *xings=@"";
//    for (int i=0; i<1; i++) {
//        //xings=[NSString stringWithFormat:@"%@",[CheckTools getUser]];
//    }
//    
//    NSString *chuLi=[number stringByReplacingCharactersInRange:NSMakeRange(0, 0) withString:@""];
//    // chuLi=[chuLi stringByReplacingCharactersInRange:NSMakeRange(number.length-count, count-leftCount) withString:xings];
//    
//    return chuLi;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
