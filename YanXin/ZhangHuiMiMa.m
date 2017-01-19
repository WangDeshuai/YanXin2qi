//
//  ZhangHuiMiMa.m
//  YanXin
//
//  Created by mac on 16/5/3.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZhangHuiMiMa.h"

@interface ZhangHuiMiMa ()
{
    UITextField * phoneNumber;
    UITextField * pswWord ;
    UITextField * yanZhengM ;
    UIView * bgViewview;
    UIImageView * imageView;
    UITextField * userName;
    UITextField * pswName;
    UITextField * yanzhengName;
}
@end

@implementation ZhangHuiMiMa

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithRed:213/255.0 green:213/255.0  blue:213/255.0  alpha:1];
    imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO)];
    imageView.image=[UIImage imageNamed:@"bg4.jpg"];
    imageView.userInteractionEnabled=YES;
    [self.view addSubview:imageView];
    
    [self titleCrite];
    
    
    
    UIView * view1 =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KUAN, 64)];
    view1.backgroundColor=[UIColor colorWithRed:0/255.0 green:170/255.0 blue:238/255.0 alpha:1];
    [imageView addSubview:view1];
//
  //为了显示背景图片自定义navgationbar上面的三个按钮
    UIButton *but =[[UIButton alloc]initWithFrame:CGRectMake(5, 27, 35, 35)];
    [but setImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(clickaddBtn) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:but];
    UILabel *lanel=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-40)/2, 30, 80, 30)];
    lanel.text=@"找回密码";
    
    lanel.textColor=[UIColor whiteColor];
    [view1 addSubview:lanel];
  
    
}

-(void)titleCrite{
    bgViewview=[[UIView alloc]initWithFrame:CGRectMake(10, 75+50, self.view.frame.size.width-20, 140)];
    bgViewview.layer.cornerRadius=3.0;
    bgViewview.alpha=0.7;
    bgViewview.backgroundColor=[UIColor whiteColor];
    [imageView addSubview:bgViewview];
    
    UIImageView * userImage =[UIImageView new];
    userImage.image=[UIImage imageNamed:@"ic_landing_nickname"];
    UIImageView * pswuserImage =[UIImageView new];
    pswuserImage.image=[UIImage imageNamed:@"mm_normal"];
    
    UIImageView * yanzhengImage =[UIImageView new];
    yanzhengImage.image=[UIImage imageNamed:@"mm_normal"];
    
    [bgViewview sd_addSubviews:@[userImage,pswuserImage,yanzhengImage]];
    userImage.sd_layout
    .leftSpaceToView(bgViewview,15)
    .widthIs(25)
    .heightIs(25)
    .topSpaceToView(bgViewview,10);
    
    pswuserImage.sd_layout
    .leftEqualToView(userImage)
    .widthIs(25)
    .heightIs(25)
    .topSpaceToView(userImage,20);
    
    yanzhengImage.sd_layout
    .leftEqualToView(userImage)
    .widthIs(25)
    .heightIs(25)
    .topSpaceToView(pswuserImage,20);
    
    UIView * lineview1 =[UIView new];
    UIView * lineview2 =[UIView new];
   // UIView * lineview3 =[UIView new];
    lineview1.backgroundColor=[UIColor grayColor];
    lineview2.backgroundColor=[UIColor grayColor];
   // lineview3.backgroundColor=[UIColor grayColor];
    lineview1.alpha=.5;
    lineview2.alpha=.5;
   // lineview3.alpha=.7;
    [bgViewview sd_addSubviews:@[lineview2,lineview1]];
    
    lineview1.sd_layout
    .leftEqualToView(userImage)
    .rightSpaceToView(bgViewview,15)
    .topSpaceToView(bgViewview,45)
    .heightIs(1);
    
    lineview2.sd_layout
    .leftEqualToView(userImage)
    .rightSpaceToView(bgViewview,15)
    .topSpaceToView(lineview1,45)
    .heightIs(1);

    
     userName =[UITextField new];
     pswName =[UITextField new];
     yanzhengName =[UITextField new];
    UIButton * button =[UIButton new];
    
    userName.placeholder=@"请输入手机号";
    pswName.placeholder=@"请输入新密码";
    yanzhengName.placeholder=@"请输入验证码";
    
     userName.keyboardType=UIKeyboardTypeNumberPad;
     userName.font=[UIFont systemFontOfSize:15];
     pswName.font=[UIFont systemFontOfSize:15];
     yanzhengName.font=[UIFont systemFontOfSize:15];
    [button setTitle:@"获取验证码" forState:0];
    [button setTitleColor:[UIColor colorWithRed:0/255.0 green:170/255.0 blue:238/255.0 alpha:1] forState:0];
    [button  addTarget:self action:@selector(btnnn:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font=[UIFont systemFontOfSize:15];
    
    
//    userName.backgroundColor=[UIColor redColor];
//     pswName.backgroundColor=[UIColor redColor];
//     yanzhengName.backgroundColor=[UIColor redColor];
//    button.backgroundColor=[UIColor greenColor];
    
    [bgViewview sd_addSubviews:@[userName,pswName,yanzhengName,button]];
    
    userName.sd_layout
    .leftSpaceToView(userImage,10)
    .rightSpaceToView(bgViewview,5)
    .heightIs(30)
    .topSpaceToView(bgViewview,10);
    
    pswName.sd_layout
    .leftSpaceToView(pswuserImage,10)
    .rightSpaceToView(bgViewview,5)
    .heightIs(30)
    .topEqualToView(pswuserImage);
    
  
    
    button.sd_layout
    .topEqualToView(yanzhengImage)
    .rightSpaceToView(bgViewview,5)
    .heightIs(30)
    .widthIs(120);
    
    yanzhengName.sd_layout
    .leftSpaceToView(yanzhengImage,10)
    .rightSpaceToView(button,5)
    .heightIs(30)
    .topEqualToView(yanzhengImage);
    
    
    
    
    UIButton * tijiaoBtn =[UIButton new];
    tijiaoBtn.backgroundColor=[UIColor colorWithRed:0/255.0 green:170/255.0 blue:238/255.0 alpha:1];
    [tijiaoBtn addTarget:self action:@selector(tijao) forControlEvents:UIControlEventTouchUpInside];
    tijiaoBtn.layer.cornerRadius=5.0f;
    tijiaoBtn.clipsToBounds=YES;
    [tijiaoBtn setTitle:@"提交" forState:0];
    [imageView sd_addSubviews:@[tijiaoBtn]];
    tijiaoBtn.sd_layout
    .leftEqualToView(bgViewview)
    .rightEqualToView(bgViewview)
    .heightIs(35)
    .topSpaceToView(bgViewview,20);
    
    

    
    
    
    
}




//获取验证码
-(void)btnnn:(UIButton*)sender
{
   // [LCLoadingHUD showLoading:@"获取验证码..."];
    [ShuJuModel zhuceDuanXinYanZheng:userName.text success:^(NSDictionary *dic) {
       //  [LCLoadingHUD hideInKeyWindow];
        NSString*codee=  [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([codee isEqualToString:@"1"]) {
            //实现倒计时
            __block int timeout=60; //倒计时时间
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        [sender setTitle:@"发送验证码" forState:UIControlStateNormal];
                        sender.userInteractionEnabled = YES;
                    });
                }
                else{
                    int seconds = timeout % 60;
                    NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        //NSLog(@"____%@",strTime);
                        [UIView beginAnimations:nil context:nil];
                        [UIView setAnimationDuration:1];
                        [sender setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                        [UIView commitAnimations];
                        sender.userInteractionEnabled = NO;
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }else{
            
            [WINDOW showHUDWithText:[dic objectForKey:@"msg"] Type:ShowPhotoNo Enabled:YES];
        }
        
        
        
        
        
    }
     
   error:^(NSError *error) {
                               }];
}
-(void)tijao
{
    //[LCLoadingHUD showLoading:@"正在提交..."];
   
    
    [ShuJuModel zhaohuimima:userName.text pswWord:pswName.text YanzhengM:yanzhengName.text success:^(NSDictionary *dic) {
     //    [LCLoadingHUD hideInKeyWindow];
      NSString* code=  [NSString stringWithFormat:@"%@",[dic objectForKey:@"code"]];
        if ([code isEqualToString:@"1"]) {
            [WINDOW showHUDWithText:[dic objectForKey:@"msg"] Type:ShowPhotoYes Enabled:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [WINDOW showHUDWithText:[dic objectForKey:@"msg"] Type:ShowPhotoNo Enabled:YES];
        }
        
        
    } error:^(NSError *error) {
        
    }];
}
-(void)clickaddBtn
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
